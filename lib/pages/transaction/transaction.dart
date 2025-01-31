import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../backend/default/constant.dart';
import '../../backend/controllers/transaction_controller.dart';
import '../components/transactiondetalis.dart';
import '../components/transactionlist.dart';
import '../components/successsalert.dart';

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
  final TransactionController _transactionController = TransactionController();

  List<Map<String, dynamic>> customerList = [];
  String? selectedCustomer;
  List<Map<String, dynamic>> productList = [];
  List<Map<String, dynamic>> cartItems = [];

  int total = 0;
  int totalPrice = 0;

  void calculateTotalPrice() {
    setState(() {
      totalPrice = cartItems.fold<int>(
        0,
        (previousValue, item) =>
            previousValue + (item['harga'] as int) * (item['total'] as int),
      );
    });
  }

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cartItems.add({
        ...product,
        'total': 1,
      });
      total += 1;
    });
    calculateTotalPrice();
  }

  void onAdd(int index) {
    setState(() {
      cartItems[index]['total'] += 1;
      total += 1;
    });
    calculateTotalPrice();
  }

  void onRemove(int index) {
    setState(() {
      if (cartItems[index]['total'] > 1) {
        cartItems[index]['total'] -= 1;
        total -= 1;
      }
    });
    calculateTotalPrice();
  }

  void onDelete(int index) {
    setState(() {
      total -= cartItems[index]['total'] as int;
      cartItems.removeAt(index);
    });
    calculateTotalPrice();
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
                              return productList.where((product) =>
                                  product['namaProduk']
                                      .toLowerCase()
                                      .contains(textValue.text.toLowerCase()));
                            },
                            displayStringForOption: (option) {
                              String jenis = option['jenis'] == 1
                                  ? 'Food'
                                  : option['jenis'] == 2
                                      ? 'Drink'
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
                                    width:
                                        MediaQuery.of(context).size.width - 32,
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
                        total: item['total'],
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
                        items: customerList.map((customer) {
                          return DropdownMenuItem<String>(
                            value: customer['namaPelanggan'],
                            child: Text(customer['namaPelanggan']),
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
                      totalItem: total,
                      totalPrice: 'Rp. $totalPrice',
                      customer: selectedCustomer ?? 'Non Member',
                    ),
                    AcceptButton(
                      onPressed: () async {
                        try {
                          // Ambil data pelanggan
                          final selectedCustomerData = customerList.firstWhere(
                              (customer) =>
                                  customer['namaPelanggan'] == selectedCustomer,
                              orElse: () => {});

                          if (cartItems.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please add a product.')),
                            );
                            return;
                          }

                          await _transactionController.addTransaction(
                            pelangganID: selectedCustomerData['pelangganID'],
                            totalHarga: totalPrice,
                            cartItems: cartItems,
                          );

                          setState(() {
                            cartItems.clear();
                            total = 0;
                            totalPrice = 0;
                            selectedCustomer = null;
                          });
                          showSuccessDialog(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Failed to add transaction: $e')),
                          );
                        }
                      },
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
