import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';

@RoutePage()
class CheckoutCardScreen extends StatefulWidget {
  const CheckoutCardScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutCardScreen> createState() => _CheckoutCardScreenState();
}

class _CheckoutCardScreenState extends State<CheckoutCardScreen> {
  final _formKey = GlobalKey<FormState>();

  // Card controllers
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardholderNameController =
      TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  // Address controllers
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();

  bool _saveCard = false;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardholderNameController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);

    return Scaffold(
      backgroundColor:
          isDarkMode ? ColorDark.background : ColorLight.background,
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? ColorDark.background : ColorLight.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
          ),
          onPressed: () => context.router.pop(),
        ),
        title: Text(
          'Add Payment Card',
          style: TextStyle(
            color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
            fontSize: responsive.setWidth(18),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(responsive.setWidth(16)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card visualization
              _buildCardPreview(isDarkMode, responsive),
              SizedBox(height: responsive.setHeight(24)),

              // Card Information Section
              _buildSectionTitle('Card Information', isDarkMode, responsive),
              SizedBox(height: responsive.setHeight(16)),

              // Card Number Field
              _buildTextField(
                controller: _cardNumberController,
                label: 'Card Number',
                hint: '0000 0000 0000 0000',
                isDarkMode: isDarkMode,
                responsive: responsive,
                keyboardType: TextInputType.number,
                prefixIcon: Icon(
                  Icons.credit_card,
                  color:
                      isDarkMode
                          ? ColorDark.iconSecondary
                          : ColorLight.iconSecondary,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card number';
                  } else if (value.replaceAll(' ', '').length != 16) {
                    return 'Card number must be 16 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.setHeight(16)),

              // Cardholder Name Field
              _buildTextField(
                controller: _cardholderNameController,
                label: 'Cardholder Name',
                hint: 'Name as shown on card',
                isDarkMode: isDarkMode,
                responsive: responsive,
                keyboardType: TextInputType.name,
                prefixIcon: Icon(
                  Icons.person_outline,
                  color:
                      isDarkMode
                          ? ColorDark.iconSecondary
                          : ColorLight.iconSecondary,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter cardholder name';
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.setHeight(16)),

              // Expiry Date and CVV in a row
              Row(
                children: [
                  // Expiry Date Field
                  Expanded(
                    child: _buildTextField(
                      controller: _expiryDateController,
                      label: 'Expiry Date',
                      hint: 'MM/YY',
                      isDarkMode: isDarkMode,
                      responsive: responsive,
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        } else if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                          return 'Use MM/YY format';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: responsive.setWidth(16)),

                  // CVV Field
                  Expanded(
                    child: _buildTextField(
                      controller: _cvvController,
                      label: 'CVV',
                      hint: '123',
                      isDarkMode: isDarkMode,
                      responsive: responsive,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        } else if (value.length != 3) {
                          return '3 digits required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: responsive.setHeight(24)),

              // Billing Address Section
              _buildSectionTitle('Billing Address', isDarkMode, responsive),
              SizedBox(height: responsive.setHeight(16)),

              // Address Field
              _buildTextField(
                controller: _addressController,
                label: 'Street Address',
                hint: '123 Main St',
                isDarkMode: isDarkMode,
                responsive: responsive,
                keyboardType: TextInputType.streetAddress,
                prefixIcon: Icon(
                  Icons.home_outlined,
                  color:
                      isDarkMode
                          ? ColorDark.iconSecondary
                          : ColorLight.iconSecondary,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.setHeight(16)),

              // City Field
              _buildTextField(
                controller: _cityController,
                label: 'City',
                hint: 'New York',
                isDarkMode: isDarkMode,
                responsive: responsive,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.setHeight(16)),

              // State and ZIP in a row
              Row(
                children: [
                  // State Field
                  Expanded(
                    child: _buildTextField(
                      controller: _stateController,
                      label: 'State',
                      hint: 'NY',
                      isDarkMode: isDarkMode,
                      responsive: responsive,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: responsive.setWidth(16)),

                  // ZIP Field
                  Expanded(
                    child: _buildTextField(
                      controller: _zipController,
                      label: 'ZIP Code',
                      hint: '10001',
                      isDarkMode: isDarkMode,
                      responsive: responsive,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: responsive.setHeight(16)),

              // Save Card Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _saveCard,
                    onChanged: (value) {
                      setState(() {
                        _saveCard = value ?? false;
                      });
                    },
                    activeColor:
                        isDarkMode ? ColorDark.primary : ColorLight.primary,
                  ),
                  Text(
                    'Save card for future purchases',
                    style: TextStyle(
                      color:
                          isDarkMode
                              ? ColorDark.titleText
                              : ColorLight.titleText,
                      fontSize: responsive.setWidth(14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: responsive.setHeight(32)),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: responsive.setHeight(50),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process data
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Card saved successfully"),
                        ),
                      );
                      context.router.pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isDarkMode
                            ? ColorDark.buttonBackground
                            : ColorLight.buttonBackground,
                    foregroundColor:
                        isDarkMode
                            ? ColorDark.buttonText
                            : ColorLight.buttonText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'SAVE CARD',
                    style: TextStyle(
                      fontSize: responsive.setWidth(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: responsive.setHeight(20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardPreview(bool isDarkMode, ResponsiveUiConfig responsive) {
    return Container(
      height: responsive.setHeight(200),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              isDarkMode
                  ? [Colors.grey.shade900, Colors.grey.shade800]
                  : [Colors.blueGrey.shade700, Colors.blueGrey.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? ColorDark.cardShadow : ColorLight.cardShadow,
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.all(responsive.setWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Chip and card type
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                'https://www.freepnglogos.com/uploads/chip-png/chip-png-sim-card-chip-13.png',
                height: responsive.setHeight(40),
                width: responsive.setWidth(50),
                errorBuilder:
                    (context, error, stackTrace) => Icon(
                      Icons.credit_card_outlined,
                      color: Colors.white,
                      size: responsive.setWidth(40),
                    ),
              ),
              Icon(
                Icons.credit_score_outlined,
                color: Colors.white,
                size: responsive.setWidth(40),
              ),
            ],
          ),

          // Card number preview
          Text(
            _cardNumberController.text.isEmpty
                ? '**** **** **** ****'
                : _formatCardNumber(_cardNumberController.text),
            style: TextStyle(
              color: Colors.white,
              fontSize: responsive.setWidth(18),
              letterSpacing: 2.0,
              fontWeight: FontWeight.w500,
            ),
          ),

          // Cardholder and expiry
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CARDHOLDER',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: responsive.setWidth(10),
                    ),
                  ),
                  Text(
                    _cardholderNameController.text.isEmpty
                        ? 'YOUR NAME'
                        : _cardholderNameController.text.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.setWidth(14),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EXPIRES',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: responsive.setWidth(10),
                    ),
                  ),
                  Text(
                    _expiryDateController.text.isEmpty
                        ? 'MM/YY'
                        : _expiryDateController.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.setWidth(14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatCardNumber(String input) {
    String cardNum = input.replaceAll(' ', '');
    if (cardNum.length < 16) {
      cardNum = cardNum.padRight(16, '*');
    }

    return '${cardNum.substring(0, 4)} ${cardNum.substring(4, 8)} ${cardNum.substring(8, 12)} ${cardNum.substring(12, 16)}';
  }

  Widget _buildSectionTitle(
    String title,
    bool isDarkMode,
    ResponsiveUiConfig responsive,
  ) {
    return Text(
      title,
      style: TextStyle(
        fontSize: responsive.setWidth(18),
        fontWeight: FontWeight.w600,
        color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isDarkMode,
    required ResponsiveUiConfig responsive,
    Widget? prefixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
        labelStyle: TextStyle(
          color: isDarkMode ? ColorDark.inputLabel : ColorLight.inputLabel,
          fontSize: responsive.setWidth(14),
        ),
        hintStyle: TextStyle(
          color: isDarkMode ? ColorDark.inputHint : ColorLight.inputHint,
          fontSize: responsive.setWidth(14),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color:
                isDarkMode
                    ? ColorDark.inputLabel.withOpacity(0.5)
                    : ColorLight.inputLabel.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: isDarkMode ? ColorDark.primary : ColorLight.primary,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: isDarkMode ? ColorDark.error : ColorLight.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: isDarkMode ? ColorDark.error : ColorLight.error,
            width: 2.0,
          ),
        ),
        filled: true,
        fillColor:
            isDarkMode ? ColorDark.inputBackground : ColorLight.inputBackground,
        contentPadding: EdgeInsets.symmetric(
          horizontal: responsive.setWidth(16),
          vertical: responsive.setHeight(16),
        ),
      ),
      style: TextStyle(
        color: isDarkMode ? ColorDark.inputText : ColorLight.inputText,
        fontSize: responsive.setWidth(16),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: (value) {
        // Trigger rebuild for card preview
        if (controller == _cardNumberController ||
            controller == _cardholderNameController ||
            controller == _expiryDateController) {
          setState(() {});
        }
      },
    );
  }
}
