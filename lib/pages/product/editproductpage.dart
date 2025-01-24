import 'package:flutter/material.dart';
import '../../backend/controllers/product_controller.dart';

class EditProductDialog extends StatefulWidget {
  final int productId;
  final String name;
  final int stock;
  final double price;
  final int type;

  const EditProductDialog({
    super.key,
    required this.productId,
    required this.name,
    required this.stock,
    required this.price,
    required this.type,
  });

  @override
  _EditProductDialogState createState() => _EditProductDialogState();

  static Future<void> showEditProductDialog(
    BuildContext context, {
    required int productId,
    required String name,
    required int stock,
    required double price,
    required int type,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: EditProductDialog(
          productId: productId,
          name: name,
          stock: stock,
          price: price,
          type: type,
        ),
      ),
    );
  }
}

class _EditProductDialogState extends State<EditProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _stockController = TextEditingController();
  final _priceController = TextEditingController();
  int _selectedType = 1; // 1 = Food, 2 = Drink
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _stockController.text = widget.stock.toString();
    _priceController.text = widget.price.toString();
    _selectedType = widget.type;
  }

  Future<void> updateProduct() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      final productController = ProductController();
      final success = await productController.updateProduct(
        widget.productId,
        _nameController.text,
        int.parse(_stockController.text),
        double.parse(_priceController.text),
        _selectedType,
      );

      setState(() {
        isLoading = false;
      });

      if (success) {
        Navigator.pop(context); // Tutup dialog
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memperbarui produk')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Edit Product',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Nama Produk
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Produk',
                filled: true,
                fillColor: Color.fromARGB(255, 240, 249, 241),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama produk tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Stok Produk
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.green),
                  onPressed: () {
                    if (_stockController.text.isNotEmpty) {
                      final stock = int.tryParse(_stockController.text);
                      if (stock != null && stock > 1) {
                        setState(() {
                          _stockController.text = (stock - 1).toString();
                        });
                      }
                    }
                  },
                ),
                Expanded(
                  child: TextFormField(
                    controller: _stockController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Stok',
                      filled: true,
                      fillColor: Color.fromARGB(255, 240, 249, 241),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null; 
                      }

                      final stock = int.tryParse(value);
                      if (stock == null) {
                        return 'Please input a valid number';
                      }

                      return null;
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green),
                  onPressed: () {
                    if (_stockController.text.isNotEmpty) {
                      final stock = int.tryParse(_stockController.text);
                      if (stock != null) {
                        setState(() {
                          _stockController.text = (stock + 1).toString();
                        });
                      }
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Harga Produk
            TextFormField(
              controller: _priceController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Harga',
                prefixText: 'Rp ',
                filled: true,
                fillColor: Color.fromARGB(255, 240, 249, 241),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Price cannot be empty';
                }

                final number = int.tryParse(value);
                if (number == null) {
                  return 'Please input a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Jenis Produk (Food or Drink)
            Row(
              children: [
                const Text('Jenis: '),
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
            const SizedBox(height: 16),

            // Tombol Submit
            ElevatedButton(
              onPressed: isLoading ? null : updateProduct,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Update Produk'),
            ),
          ],
        ),
      ),
    );
  }
}
