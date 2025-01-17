import 'package:flutter/material.dart';
import '../../backend/controllers/product_controller.dart';

class CreateProductPage {
  static Future<bool> createProduct(BuildContext context) async {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _stockController = TextEditingController();
    final _priceController = TextEditingController();
    int _selectedType = 1;
    bool isLoading = false;

    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(  // Menambahkan StatefulBuilder agar setState dapat digunakan
          builder: (context, setState) {
            return AlertDialog(
              title: const Center(child: Text('Add Product')),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Product Name'),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Product Name',
                          filled: true,
                          fillColor: Color.fromARGB(255, 240, 249, 241),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text('Stock'),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _stockController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Stock',
                                filled: true,
                                fillColor: Color.fromARGB(255, 240, 249, 241),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text('Price'),
                      TextFormField(
                        controller: _priceController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Price',
                          prefixText: 'Rp ',
                          filled: true,
                          fillColor: Color.fromARGB(255, 240, 249, 241),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field must be filled';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text('Type:'),
                      Row(
                        children: [
                          Radio<int>(
                            value: 1,
                            groupValue: _selectedType,
                            onChanged: (value) {
                              setState(() {
                                _selectedType = value ?? 1;
                              });
                            },
                          ),
                          const Text('Food'),
                          const SizedBox(width: 16),
                          Radio<int>(
                            value: 2,
                            groupValue: _selectedType,
                            onChanged: (value) {
                              setState(() {
                                _selectedType = value ?? 2;
                              });
                            },
                          ),
                          const Text('Drink'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              isLoading = true;
                              final success = await ProductController()
                                  .createProduct(
                                      _nameController.text,
                                      int.parse(_stockController.text),
                                      double.parse(_priceController.text),
                                      _selectedType);
                              if (success) {
                                Navigator.pop(context, true);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Failed to add product')),
                                );
                                isLoading = false;
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Add Product'),
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((value) => value ?? false);
  }
}
