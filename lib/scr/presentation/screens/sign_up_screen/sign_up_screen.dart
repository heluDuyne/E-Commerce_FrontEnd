import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_frontend/injector.dart';
import 'package:e_commerce_frontend/scr/data/models/request/user_request_model/user_request_model.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/signup/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_frontend/scr/core/utils/app_route/app_router.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  SignUpScreen({super.key});

  void _signUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Handle sign-up logic
      context.read<SignupBloc>().add(
        CreateUserEvent(
          UserRequestModel(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
          ),
        ),
      );
    }
    // context.router.push(const VerificationCodeRoute());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<SignupBloc>(),
      child: Builder(
        builder: (context) {
          return BlocListener<SignupBloc, SignupState>(
            listener: (context, state) {
              switch (state) {
                case SignupSuccess():
                  Navigator.pop(context); // Close the loading dialog
                  // context.router.push(HomeRoute());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Sign Up Successful! Welcome ${state.userInfo.name}!",
                      ),
                    ),
                  );
                  context.router.push(
                    VerificationCodeRoute(email: emailController.text),
                  );
                case SignUpError():
                  Navigator.pop(context); // Close the loading dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Sign Up Failed: ${state.message}")),
                  );
                default:
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
              }
            },
            child: Scaffold(
              backgroundColor: Colors.white,
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
                            "Create",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "your account",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: "Enter your name",
                            ),
                            validator:
                                (value) =>
                                    value!.isEmpty
                                        ? "Please enter your name"
                                        : null,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: "Email address",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator:
                                (value) =>
                                    !RegExp(r'\S+@\S+\.\S+').hasMatch(value!)
                                        ? "Enter a valid email"
                                        : null,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                              labelText: "Password",
                            ),
                            obscureText: true,
                            validator:
                                (value) =>
                                    value!.length < 6
                                        ? "Password must be at least 6 characters"
                                        : null,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: confirmPasswordController,
                            decoration: const InputDecoration(
                              labelText: "Confirm password",
                            ),
                            obscureText: true,
                            validator:
                                (value) =>
                                    value != passwordController.text
                                        ? "Passwords do not match"
                                        : null,
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () => _signUp(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 60,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "SIGN UP",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _BuildLoginWithOther(context),
                          const SizedBox(height: 20),
                          _BuildLoginButton(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BuildLoginWithOther extends StatelessWidget {
  const _BuildLoginWithOther(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("or sign up with"),
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
    );
  }
}

class _BuildLoginButton extends StatelessWidget {
  const _BuildLoginButton(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          context.router.push(LoginRoute());
        },
        child: const Text(
          "Already have an account? Log In",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
