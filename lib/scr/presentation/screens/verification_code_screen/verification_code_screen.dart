import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_frontend/injector.dart';
import 'package:e_commerce_frontend/scr/core/utils/loading_dialog/loading_dialog.dart';
import 'package:e_commerce_frontend/scr/data/models/request/email_verify_request_model/email_verify_request_model.dart';
import 'package:e_commerce_frontend/scr/presentation/bloc/email_verify/email_verify_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class VerificationCodeScreen extends StatefulWidget {
  final String email;
  const VerificationCodeScreen({required this.email, super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  Timer? _timer;
  int _secondsRemaining = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 30;
      _canResend = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void _handleResend(BuildContext context) {
    if (_canResend) {
      context.read<EmailVerifyBloc>().add(ResendVerificationEmailEvent());
      _startTimer();
    }
  }

  String get _timerText {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _onCodeChanged(BuildContext context, String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    // Check if all fields are filled
    if (value.length == 1) {
      bool allFilled = true;
      for (var controller in _controllers) {
        if (controller.text.isEmpty) {
          allFilled = false;
          break;
        }
      }
      if (allFilled) {
        var verificationCode = _controllers.map((c) => c.text).join();
        context.read<EmailVerifyBloc>().add(
          VerifyEmailEvent(
            EmailVerifyRequestModel(
              email: widget.email,
              verificationCode: verificationCode,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return BlocProvider(
      create: (context) => locator<EmailVerifyBloc>(),
      child: Builder(
        builder: (context) {
          return BlocListener<EmailVerifyBloc, EmailVerifyState>(
            listener: (context, state) {
              switch (state) {
                case EmailVerified():
                  context.router.pop();
                //TODO: Navigate to the Home screen or next step
                case EmailVerifyError():
                  context.router.pop();
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                case EmailResended():
                  context.router.pop();
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Verification code resent successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                case ResendError():
                  context.router.pop();
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                default:
                  showLoadingDialog(
                    context: context,
                  );
              }
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => context.router.pop(),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 24.0 : screenSize.width * 0.1,
                      vertical: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Verification code',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Please enter the verification code we sent\nto your email address',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: Colors.black54, height: 1.5),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            6,
                            (index) => Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      _focusNodes[index].hasFocus
                                          ? Colors.black
                                          : Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: _controllers[index],
                                  focusNode: _focusNodes[index],
                                  onChanged:
                                      (value) =>
                                          _onCodeChanged(context, value, index),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    isDense: true,
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                  ),
                                  // cursorColor: Colors.black,
                                  // cursorHeight: 24,
                                  // cursorWidth: 1.5,
                                  showCursor: false,
                                  textAlignVertical: TextAlignVertical.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: TextButton(
                            onPressed:
                                _canResend
                                    ? () => _handleResend(context)
                                    : null,
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: StadiumBorder(
                                side: BorderSide(
                                  color:
                                      _canResend
                                          ? Colors.grey[300]!
                                          : Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: _canResend ? 'Resend code' : 'Resend in ',
                                style: TextStyle(
                                  color:
                                      _canResend
                                          ? Colors.black
                                          : Colors.grey[600],
                                  fontSize: 14,
                                ),
                                children:
                                    _canResend
                                        ? null
                                        : [
                                          TextSpan(
                                            text: _timerText,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                              ),
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
        },
      ),
    );
  }
}
