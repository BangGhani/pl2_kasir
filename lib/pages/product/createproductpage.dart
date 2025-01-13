import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../backend/controllers/routes.dart';
import '../../backend/controllers/product_controller.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _stockController = TextEditingController();
  final _priceController = TextEditingController();
  int _selectedType = 1; // 1 = Food, 2 = Drink

  bool isLoading = false;

  // Fungsi untuk menambahkan produk
  Future<void> createProduct() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      // Memanggil ProductController untuk menambah produk
      final productController = ProductController();
      final success = await productController.createProduct(
        _nameController.text,
        int.parse(_stockController.text),
        double.parse(_priceController.text),
        _selectedType,
      );

      setState(() {
        isLoading = false;
      });

      if (success) {
        // Navigasi ke halaman utama setelah berhasil
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        // Tampilkan error jika gagal
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menambahkan produk')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Create Product',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
                          return 'Stok tidak boleh kosong';
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
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Harga',
                  prefixText: 'Rp ',
                  filled: true,
                  fillColor: Color.fromARGB(255, 240, 249, 241),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga tidak boleh kosong';
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
                onPressed: isLoading ? null : createProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Tambah Produk'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
