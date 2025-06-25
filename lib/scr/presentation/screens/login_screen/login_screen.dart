import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_frontend/injector.dart';
import 'package:e_commerce_frontend/scr/core/utils/app_route/app_router.gr.dart';
import 'package:e_commerce_frontend/scr/core/utils/constants/images.dart';
import 'package:e_commerce_frontend/scr/core/utils/loading_dialog/loading_dialog.dart';
import 'package:e_commerce_frontend/scr/data/models/request/login_request_model/login_request_model.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/login/login_bloc.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/oauth_authentication/oauth_bloc.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/recommendation/recommendation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  void _logIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(
        SignInEvent(
          LoginRequestModel(
            email: emailController.text,
            password: passwordController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<LoginBloc>(),
      child: Builder(
        builder: (context) {
          return BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LogingIn) {
                showLoadingDialog(context: context);
              } else if (state is LoggedIn) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Welcome to Elanza!')),
                );
                context.router.replace(const HomeRoute());
              } else if (state is LoginError) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.errorMessage}')),
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
                            "Log into",
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

                          // Email Input
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

                          // Password Input
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

                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                context.router.push(ForgotPasswordRoute());
                              },
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
                                  vertical: 14,
                                  horizontal: 60,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "LOG IN",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // OR Log In With
                          const SizedBox(height: 20),
                          _BuildLoginWithOther(context),

                          // Sign Up Link
                          _BuildSignUpButton(),
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

class _BuildSignUpButton extends StatelessWidget {
  const _BuildSignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          context.router.push(SignUpRoute());
        },
        child: const Text(
          "Don't have an account? Sign Up",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class _BuildLoginWithOther extends StatelessWidget {
  const _BuildLoginWithOther(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<OAuthAuthenticationBloc>(),
      child: Center(
        child: Column(
          children: [
            const Text("or log in with"),
            const SizedBox(height: 10),
            Builder(
              builder: (BuildContext context) {
                return BlocListener<
                  OAuthAuthenticationBloc,
                  OAuthAuthenticationState
                >(
                  listener: (context, state) {
                    if (state is Authenticating) {
                      showLoadingDialog(context: context);
                    }
                    if (state is Authenticated) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Logged in successfully!"),
                        ),
                      );
                    } else if (state is Error) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Row(
                          children: [
                            Image.asset(Images.googleIcon, width: 20),
                            const SizedBox(width: 5),
                            const Text("Google"),
                          ],
                        ),
                        onPressed: () {
                          context.read<OAuthAuthenticationBloc>().add(
                            AuthenticateWithGoogle(),
                          );
                        },
                      ),
                      const SizedBox(width: 20),
                      TextButton(
                        child: Row(
                          children: [
                            Image.asset(Images.facebookIcon, width: 20),
                            const SizedBox(width: 5),
                            const Text("Facebook"),
                          ],
                        ),
                        onPressed: () {
                          context.read<OAuthAuthenticationBloc>().add(
                            AuthenticateWithFacebook(),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
