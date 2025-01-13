// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// // import '../../backend/default/constant.dart';
// import '../../backend/controllers/routes.dart';
// import '../components/donut.dart';
// import '../components/cardlist.dart';

// class ProductPage extends StatelessWidget {
//   const ProductPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               floating: true,
//               title: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 25.0),
//                     child: SvgPicture.asset(
//                       "assets/images/cashier_logo.svg",
//                       height: 170,
//                     ),
//                   )
//               ),
//             ),
//             const SliverToBoxAdapter(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 16.0,
//                   vertical: 24.0,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       "PRODUCT",
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 1.2,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(height: 24),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         DonutItem(
//                           color: Colors.green,
//                           number: 5,
//                           label: "Food",
//                           iconPath: "assets/icons/food.svg",
//                         ),
//                         SizedBox(width: 60),
//                         DonutItem(
//                           color: Colors.green,
//                           number: 0,
//                           label: "Drink",
//                           iconPath: "assets/icons/drink.svg",
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: CardList(
//                 title: 'Food',
//                 onTap: () => Navigator.pushNamed(context, AppRoutes.foodProduct),
//                 products: const [
//                   ProductList(name: 'Nasi Goreng', stock: '20', price: '10000'),
//                   ProductList(name: 'Nasi Pecel', stock: '24', price: '9000'),
//                   ProductList(name: 'Bakmie', stock: '13', price: '10000'),
//                   ProductList(name: 'Bakmie', stock: '13', price: '10000'),
//                 ],
//               ),
//             ),
//             // const SliverPadding(
//             //   padding: EdgeInsets.symmetric(vertical: AppDefaults.padding),
//             //   sliver: SliverToBoxAdapter(
//             //     child: OurNewItem(),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../backend/controllers/routes.dart';
import '../components/donut.dart';
import '../components/cardlist.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductList> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await Supabase.instance.client
        .from('produk')
        .select('namaProduk, stok, harga'); // Mengambil data produk

    final data = response as List<dynamic>;
    setState(() {
      products = data.map((item) {
        return ProductList(
          name: item['namaProduk'],
          stock: item['stok'].toString(),
          price: item['harga'].toString(),
        );
      }).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: SvgPicture.asset(
                    "assets/images/cashier_logo.svg",
                    height: 170,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "PRODUCT",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DonutItem(
                          color: Colors.green,
                          number: 5,
                          label: "Food",
                          iconPath: "assets/icons/food.svg",
                        ),
                        SizedBox(width: 60),
                        DonutItem(
                          color: Colors.green,
                          number: 0,
                          label: "Drink",
                          iconPath: "assets/icons/drink.svg",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CardList(
                      title: 'Food',
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.foodProduct),
                      products: products,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItem {
  final String name;
  final String stock;
  final String price;

  const ProductItem({
    required this.name,
    required this.stock,
    required this.price,
  });
}
