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

class _AccountPageState extends State<AccountPage> with SingleTickerProviderStateMixin {
  final List<Map<String, String>> customers = [];
  final List<Map<String, String>> officers = [];

  final formKeyCustomer = GlobalKey<FormState>(); // Ganti nama key untuk Customer
  final formKeyOfficer = GlobalKey<FormState>();   // Ganti nama key untuk Officer
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final officerNameController = TextEditingController();
  final officerPhoneController = TextEditingController();
  final officerAddressController = TextEditingController();
  final officerEmailController = TextEditingController();
  final officerPasswordController = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void registerCustomerAccount() async {
    if (formKeyCustomer.currentState!.validate()) {
      final name = nameController.text;
      final phone = phoneController.text;
      final address = addressController.text;
      final email = emailController.text;
      final password = passwordController.text;

      try {
        await registerCustomer(email, password, name, phone, address);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Customer registered successfully')),
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

  void registerOfficerAccount() async {
    if (formKeyOfficer.currentState!.validate()) {
      final name = officerNameController.text;
      final phone = officerPhoneController.text;
      final address = officerAddressController.text;
      final email = officerEmailController.text;
      final password = officerPasswordController.text;

      try {
        await registerCustomer(email, password, name, phone, address); // Bisa disesuaikan jika ada fungsi spesifik untuk officer
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Officer registered successfully')),
        );
        // Bersihkan form setelah berhasil
        officerNameController.clear();
        officerPhoneController.clear();
        officerAddressController.clear();
        officerEmailController.clear();
        officerPasswordController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const CustomSliverAppBar(),
          SliverToBoxAdapter(
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Customer'),
                Tab(text: 'Officer'),
              ],
              labelColor: Colors.blue, // Warna teks tab yang aktif
              unselectedLabelColor: Colors.grey, // Warna teks tab yang tidak aktif
              indicatorColor: Colors.blue, // Warna indikator tab
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(), // Nonaktifkan geser antar tab
              children: [
                // Tab Customer
                SingleChildScrollView(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: Form(
                    key: formKeyCustomer,  // Ganti key untuk form Customer
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
                          text: 'Register Customer Account',
                          onPressed: registerCustomerAccount,
                        ),
                      ],
                    ),
                  ),
                ),
                // Tab Officer
                SingleChildScrollView(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: Form(
                    key: formKeyOfficer,  // Ganti key untuk form Officer
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          label: 'Officer Name',
                          hintText: 'Enter officer name',
                          controller: officerNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          label: 'Phone Number',
                          hintText: 'Enter officer phone number',
                          controller: officerPhoneController,
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
                          hintText: 'Enter officer address',
                          controller: officerAddressController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an address';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          label: 'Email',
                          hintText: 'Enter officer email',
                          controller: officerEmailController,
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
                          hintText: 'Enter officer password',
                          controller: officerPasswordController,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        ),
                        GreenButton(
                          text: 'Register Officer Account',
                          onPressed: registerOfficerAccount,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
