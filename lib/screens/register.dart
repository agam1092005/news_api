// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/auth_provider.dart';
import '../widgets/rounded_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();
  void _register(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      await authProvider.register(_nameController.text, _emailController.text,
          _passwordController.text);
      if (authProvider.user != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('loggedin', true);
        Navigator.pushReplacementNamed(context, '/news');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text('Something went wrong. Please try again.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Something went wrong. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 150,
        child: Column(
          children: [
            RoundedButton(
              onPressed: () {
                if (_registerKey.currentState!.validate())
                  {
                    _register(context);
                  }
              },
              height: 50,
              width: 200,
              child: const Text(
                "Signup",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                ),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xFF0C54BE),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text(
          'MyNews',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xFF0C54BE),
          ),
        ),
      ),
      body: Form(
        key: _registerKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        12,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    autofocus: false,
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (value) =>
                    value!.isEmpty ? 'Name is mandatory' : null,
                    cursorColor: const Color(0xFF0C54BE),
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "Name",
                      contentPadding: EdgeInsets.all(16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        12,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    autofocus: false,
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is mandatory';
                      }
                      String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                    cursorColor: const Color(0xFF0C54BE),
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      contentPadding: EdgeInsets.all(16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        12,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    autofocus: false,
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (value) =>
                    (value!.length < 8) ? 'Password should be atleast 8 characters' : null,
                    cursorColor: const Color(0xFF0C54BE),
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      contentPadding: EdgeInsets.all(16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
