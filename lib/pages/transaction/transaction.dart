import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Pastikan Anda mengimpor paket ini jika menggunakan SvgPicture

import '../../backend/default/constant.dart';
import '../../backend/controllers/routes.dart';
import '../components/transactiondetalis.dart';
import '../components/transactionlist.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    super.key,
    this.isHomePage = false,
  });

  final bool isHomePage;

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
                        //Search Box
                        Form(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.all(AppDefaults.padding),
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
                            autofocus: true,
                            onChanged: (String? value) {},
                            onFieldSubmitted: (v) {},
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
                    const SingleCartItemTile(
                      title: 'Sate',
                      price: '12000',
                      type: 'Makanan',
                    ),
                    const ItemTotalsAndPrice(
                      totalItem: 30,
                      totalPrice: '12000',
                      customer: 'Prabowo',
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(AppDefaults.padding),
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, AppRoutes.orderSuccessfull);
                          },
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
