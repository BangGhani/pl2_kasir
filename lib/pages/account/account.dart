import 'package:flutter/material.dart';
import '../../backend/default/constant.dart';
import '../../backend/controllers/account_controller.dart';
import '../components/appbar.dart';
import '../components/form.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int selectedIndex = 0;
  final List<Map<String, String>> customers = [];
  final List<Map<String, String>> officers = [];

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void register() async {
    if (formKey.currentState!.validate()) {
      final name = nameController.text;
      final phone = phoneController.text;
      final address = addressController.text;
      final email = emailController.text;
      final password = passwordController.text;

      try {
        await registerCustomer(email, password, name, phone, address);
        ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('CustomeraqQA registered successfully')),
        );
        // Bersihkan form setelah berhasil
        nameController.clear();
        phoneController.clear();
        addressController.clear();
        emailController.clear();
        passwordController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const CustomSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      label: 'Name',
                      hintText: 'Enter your name',
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      label: 'Phone Number',
                      hintText: 'Enter your phone number',
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      label: 'Address',
                      hintText: 'Enter your address',
                      controller: addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an address';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      label: 'Email',
                      hintText: 'Enter your email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      label: 'Password',
                      hintText: 'Enter your password',
                      controller: passwordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    GreenButton(
                      text: 'Register Account',
                      onPressed: register,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(thickness: 2, color: Colors.black),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final list = selectedIndex == 0 ? customers : officers;
                final account = list[index];
                return Card(
                  margin: const EdgeInsets.all(AppDefaults.margin),
                  child: ListTile(
                    title: Text(account['name']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone: ${account['phone']}'),
                        Text('Address: ${account['address']}'),
                        Text('Email: ${account['email']}'),
                      ],
                    ),
                  ),
                );
              },
              childCount:
                  selectedIndex == 0 ? customers.length : officers.length,
            ),
          ),
        ],
      ),
    );
  }
}
