import 'package:flutter/material.dart';


class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _selectedIndex = 0;
  final List<Map<String, String>> _customers = [];
  final List<Map<String, String>> _officers = [];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        final account = {
          'name': _nameController.text,
          'phone': _phoneController.text,
          'address': _addressController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        };
        if (_selectedIndex == 0) {
          _customers.add(account);
        } else {
          _officers.add(account);
        }
        _nameController.clear();
        _phoneController.clear();
        _addressController.clear();
        _emailController.clear();
        _passwordController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Management Page'),
            pinned: true,
            floating: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => _onItemTapped(0),
                      child: Text(
                        'Customer',
                        style: TextStyle(
                          color:
                              _selectedIndex == 0 ? Colors.blue : Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _onItemTapped(1),
                      child: Text(
                        'Officer',
                        style: TextStyle(
                          color:
                              _selectedIndex == 1 ? Colors.blue : Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(labelText: 'Address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an address';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _register,
                      child: Text('REGISTER'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Divider(thickness: 2, color: Colors.grey),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final list = _selectedIndex == 0 ? _customers : _officers;
                final account = list[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  _selectedIndex == 0 ? _customers.length : _officers.length,
            ),
          ),
        ],
      ),
    );
  }
}
