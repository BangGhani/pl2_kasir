import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../backend/default/constant.dart';
import '../../backend/controllers/transaction_controller.dart';
import '../components/transactiondetalis.dart';
import '../components/transactionlist.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
    this.isHomePage = false,
  });

  final bool isHomePage;

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CustomerController _customerController = CustomerController();
  final ProductController _productController = ProductController();

  String? selectedCustomer;
  List<String> customerList = [];
  List<Map<String, dynamic>> productList = [];
  List<Map<String, dynamic>> cartItems = [];
  int totalStock = 0;
  int itemStock = 0;

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cartItems.add({
        ...product,
        'stock': 1,
      });
      itemStock = cartItems.last['stock'];
      totalStock += 1;
    });
  }

  void onAdd(int index) {
    setState(() {
      cartItems[index]['stock'] += 1;
      itemStock = cartItems[index]['stock'];
      totalStock += 1;
    });
  }

  void onRemove(int index) {
    setState(() {
      if (cartItems[index]['stock'] > 1) {
        cartItems[index]['stock'] -= 1;
      }
      itemStock = cartItems[index]['stock'];
      totalStock -= 1;
    });
  }

  void onDelete(int index) {
    setState(() {
      cartItems.removeAt(index);
      totalStock -= 1;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCustomers();
    fetchProducts();
  }

  Future<void> fetchCustomers() async {
    try {
      final customers = await _customerController.fetchCustomers();
      setState(() {
        customerList = customers;
      });
    } catch (e) {
      debugPrint('Error fetching customers: $e');
    }
  }

  Future<void> fetchProducts() async {
    try {
      final products = await _productController.fetchProducts();
      setState(() {
        productList = products;
      });
    } catch (e) {
      debugPrint('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Transaction',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: Stack(
                      children: [
                        Form(
                          child: Autocomplete<Map<String, dynamic>>(
                            optionsBuilder: (TextEditingValue textValue) {
                              if (textValue.text.isEmpty) {
                                return const Iterable<
                                    Map<String, dynamic>>.empty();
                              }
                              // Filter productList berdasarkan query
                              return productList.where((product) =>
                                  product['namaProduk']
                                      .toLowerCase()
                                      .contains(textValue.text.toLowerCase()));
                            },
                            displayStringForOption: (option) {
                              String jenis = option['jenis'] == 1 ? 'Food'
                                : option['jenis'] == 2 ? 'Drink' 
                                : 'Others';
                              return '${option['namaProduk']} ($jenis)';
                            },
                            onSelected: (Map<String, dynamic> selectedProduct) {
                              addToCart(selectedProduct);
                            },
                            fieldViewBuilder: (context, controller, focusNode,
                                onEditingComplete) {
                              return TextFormField(
                                controller: controller,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  hintText: 'Search Product',
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(
                                        AppDefaults.padding),
                                    child: SvgPicture.asset(
                                      AppIcons.search,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.primary,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  prefixIconConstraints: const BoxConstraints(),
                                  contentPadding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                                textInputAction: TextInputAction.search,
                              );
                            },
                            optionsViewBuilder: (context, onSelected, options) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Material(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width -
                                        32, // Lebar dropdown
                                    margin: const EdgeInsets.all(8.0),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: options.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final Map<String, dynamic> option =
                                            options.elementAt(index);
                                        final String jenis =
                                            option['jenis'] == 1
                                                ? 'Food'
                                                : 'Drink';

                                        return ListTile(
                                          title: Text(option['namaProduk']),
                                          subtitle: Text(jenis),
                                          onTap: () => onSelected(option),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...cartItems.map((item) {
                      int itemIndex = cartItems.indexOf(item);
                      return SingleCartItemTile(
                        title: item['namaProduk'],
                        price: item['harga'],
                        type: item['jenis'] == 1 ? 'Food' : 'Drink',
                        stock: item['stock'],
                        onAdd: () => onAdd(itemIndex),
                        onRemove: () => onRemove(itemIndex),
                        onDelete: () => onDelete(itemIndex),
                      );
                    }).toList(),
                    const Text(
                      'Customer',
                      textAlign: TextAlign.start,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppDefaults.padding),
                      child: DropdownButton<String>(
                        value: selectedCustomer,
                        isExpanded: true,
                        hint: const Text('Select Customer'),
                        items: customerList.map((String customer) {
                          return DropdownMenuItem<String>(
                            value: customer,
                            child: Text(customer),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCustomer = newValue;
                          });
                        },
                      ),
                    ),
                    ItemTotalsAndPrice(
                      totalItem: totalStock,
                      totalPrice: cartItems(
                        (previousValue, item) =>
                            previousValue +
                            (item['harga'] as int) * item['stock'],
                      ).toString(), // Convert the result to a string
                      customer: selectedCustomer ?? 'Select Customer',
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(AppDefaults.padding),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Checkout'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
