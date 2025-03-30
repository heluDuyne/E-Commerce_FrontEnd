import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_frontend/scr/core/utils/app_route/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _logIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Handle login logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Successful!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Log into",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "your account",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Email Input
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: "Email address"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                    !RegExp(r'\S+@\S+\.\S+').hasMatch(value!)
                        ? "Enter a valid email"
                        : null,
                  ),
                  const SizedBox(height: 10),

                  // Password Input
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: "Password"),
                    obscureText: true,
                    validator: (value) => value!.length < 6
                        ? "Password must be at least 6 characters"
                        : null,
                  ),
                  const SizedBox(height: 10),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Log In Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _logIn(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, //
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text("LOG IN", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // OR Log In With
                  Center(
                    child: Column(
                      children: [
                        const Text("or log in with"),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.apple, size: 40),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(Icons.account_circle, size: 40),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(Icons.facebook, size: 40),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Sign Up Link
                  Center(
                    child: TextButton(
                      onPressed: () {
                         context.router.push( SignUpRoute());
                      },
                      child: const Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
