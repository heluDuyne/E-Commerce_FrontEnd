import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:e_commerce_frontend/scr/core/utils/app_route/app_router.gr.dart';

@RoutePage()
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // Form controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _streetNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _couponController = TextEditingController();

  // Country dropdown value
  String? _selectedCountry;

  // Error states tracking
  bool _lastNameError = false;

  // Step tracking
  int _currentStep = 0;

  // Shipping method selection
  int _selectedShippingMethod = 0;

  // Copy address option
  bool _copyAddressFromShipping = false;

  // List of countries for dropdown
  final List<String> _countries = [
    'Vietnam',
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'Germany',
    'France',
  ];
  // Shipping method options
  final List<ShippingMethod> _shippingMethods = [
    ShippingMethod(
      title: 'Free',
      subtitle: 'Delivery to home',
      description: 'Delivery from 3 to 7 business days',
      price: 0,
    ),
    ShippingMethod(
      title: '\$ 9.90',
      subtitle: 'Delivery to home',
      description: 'Delivery from 4 to 6 business days',
      price: 9.90,
    ),
    ShippingMethod(
      title: '\$ 9.90',
      subtitle: 'Fast Delivery',
      description: 'Delivery from 2 to 3 business days',
      price: 9.90,
    ),
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _streetNameController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _phoneNumberController.dispose();
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);

    // Colors based on theme
    final backgroundColor =
        isDarkMode ? ColorDark.background : ColorLight.background;
    final titleColor = isDarkMode ? ColorDark.titleText : ColorLight.titleText;
    final subtitleColor =
        isDarkMode ? ColorDark.subtitleText : ColorLight.subtitleText;
    final inputLabelColor =
        isDarkMode ? ColorDark.inputLabel : ColorLight.inputLabel;
    final inputBackgroundColor =
        isDarkMode ? ColorDark.inputBackground : ColorLight.inputBackground;
    final errorColor = isDarkMode ? ColorDark.error : ColorLight.error;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        leadingWidth: responsive.setWidth(55), // Reduced width
        leading: Padding(
          padding: EdgeInsets.only(
            left: responsive.setWidth(20),
          ), // Reduced padding
          child: Container(
            width: responsive.setWidth(32), // Reduced container size
            height: responsive.setWidth(32), // Reduced container size
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: isDarkMode ? Colors.black26 : Colors.black12,
                  blurRadius: 3, // Reduced shadow blur
                  offset: const Offset(0, 1), // Reduced shadow offset
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: titleColor,
                size: responsive.setWidth(20), // Reduced icon size
              ),
              onPressed: () => Navigator.of(context).pop(),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ),
        title: Text(
          'Check out',
          style: TextStyle(
            color: titleColor,
            fontSize: responsive.setWidth(16),
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          // Theme toggle button
          Padding(
            padding: EdgeInsets.only(right: responsive.setWidth(20)),
            child: Container(
              width: responsive.setWidth(32),
              height: responsive.setWidth(32),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode ? Colors.black26 : Colors.black12,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: titleColor,
                  size: responsive.setWidth(16),
                ),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.setWidth(24),
            vertical: responsive.setHeight(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkout stepper
              _buildCheckoutStepper(responsive, isDarkMode),

              SizedBox(height: responsive.setHeight(32)),

              // Step title
              Text(
                'STEP 1',
                style: TextStyle(
                  color: subtitleColor,
                  fontSize: responsive.setWidth(12),
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: responsive.setHeight(6)),

              // Shipping title
              Text(
                'Shipping',
                style: TextStyle(
                  color: titleColor,
                  fontSize: responsive.setWidth(24),
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: responsive.setHeight(24)),

              // Form fields
              _buildInputField(
                label: 'First name',
                controller: _firstNameController,
                required: true,
                responsive: responsive,
                labelColor: inputLabelColor,
                textColor: titleColor,
                backgroundColor: inputBackgroundColor,
              ),

              _buildInputField(
                label: 'Last name',
                controller: _lastNameController,
                required: true,
                isError: _lastNameError,
                responsive: responsive,
                labelColor: inputLabelColor,
                textColor: titleColor,
                backgroundColor: inputBackgroundColor,
              ),

              if (_lastNameError)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: responsive.setHeight(16),
                    left: responsive.setWidth(2),
                  ),
                  child: Text(
                    'Field is required',
                    style: TextStyle(
                      color: errorColor,
                      fontSize: responsive.setWidth(12),
                    ),
                  ),
                ),

              // Country dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label row with asterisk
                  Row(
                    children: [
                      Text(
                        'Country',
                        style: TextStyle(
                          color: inputLabelColor,
                          fontSize: responsive.setWidth(14),
                        ),
                      ),
                      SizedBox(width: responsive.setWidth(4)),
                      Text(
                        '*',
                        style: TextStyle(
                          color: errorColor,
                          fontSize: responsive.setWidth(14),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: responsive.setHeight(8)),

                  // Dropdown field
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: inputLabelColor, width: 1.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedCountry,
                              hint: Text(
                                'Select country',
                                style: TextStyle(
                                  color: inputLabelColor,
                                  fontSize: responsive.setWidth(14),
                                ),
                              ),
                              icon: const SizedBox.shrink(),
                              isExpanded: true,
                              dropdownColor: backgroundColor,
                              items:
                                  _countries.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: titleColor,
                                          fontSize: responsive.setWidth(14),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedCountry = newValue;
                                });
                              },
                            ),
                          ),
                        ),

                        // Dropdown icon
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: inputLabelColor,
                          size: responsive.setWidth(20),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: responsive.setHeight(24)),
                ],
              ),

              _buildInputField(
                label: 'Street name',
                controller: _streetNameController,
                required: true,
                responsive: responsive,
                labelColor: inputLabelColor,
                textColor: titleColor,
                backgroundColor: inputBackgroundColor,
              ),

              _buildInputField(
                label: 'City',
                controller: _cityController,
                required: true,
                responsive: responsive,
                labelColor: inputLabelColor,
                textColor: titleColor,
                backgroundColor: inputBackgroundColor,
              ),

              _buildInputField(
                label: 'State / Province',
                controller: _stateController,
                required: false,
                responsive: responsive,
                labelColor: inputLabelColor,
                textColor: titleColor,
                backgroundColor: inputBackgroundColor,
              ),

              _buildInputField(
                label: 'Zip-code',
                controller: _zipCodeController,
                required: true,
                keyboardType: TextInputType.number,
                responsive: responsive,
                labelColor: inputLabelColor,
                textColor: titleColor,
                backgroundColor: inputBackgroundColor,
              ),

              _buildInputField(
                label: 'Phone number',
                controller: _phoneNumberController,
                required: true,
                keyboardType: TextInputType.phone,
                responsive: responsive,
                labelColor: inputLabelColor,
                textColor: titleColor,
                backgroundColor: inputBackgroundColor,
              ),

              SizedBox(height: responsive.setHeight(32)),

              // Shipping method section
              _buildShippingMethodSection(
                responsive,
                isDarkMode,
                titleColor,
                subtitleColor,
              ),

              SizedBox(height: responsive.setHeight(32)),

              // Coupon code section
              _buildCouponCodeSection(
                responsive,
                isDarkMode,
                titleColor,
                inputLabelColor,
                inputBackgroundColor,
              ),

              SizedBox(height: responsive.setHeight(32)),

              // Billing address section
              _buildBillingAddressSection(responsive, isDarkMode, titleColor),

              SizedBox(height: responsive.setHeight(32)),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: responsive.setHeight(50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isDarkMode
                            ? ColorDark.buttonBackground
                            : ColorLight.buttonBackground,
                    foregroundColor:
                        isDarkMode
                            ? ColorDark.buttonText
                            : ColorLight.buttonText,
                    shape: const StadiumBorder(), // Perfect pill shape
                    elevation: 0,
                  ),
                  onPressed: _validateAndContinue,
                  child: Text(
                    'Continue to payment',
                    style: TextStyle(
                      fontSize: responsive.setWidth(16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Form validation and navigation
  void _validateAndContinue() {
    bool isValid = true;

    // Validate required fields
    if (_lastNameController.text.trim().isEmpty) {
      setState(() {
        _lastNameError = true;
      });
      isValid = false;
    } else {
      setState(() {
        _lastNameError = false;
      });
    }

    // Validate other required fields
    if (_firstNameController.text.trim().isEmpty ||
        _selectedCountry == null ||
        _streetNameController.text.trim().isEmpty ||
        _cityController.text.trim().isEmpty ||
        _zipCodeController.text.trim().isEmpty ||
        _phoneNumberController.text.trim().isEmpty) {
      isValid = false;
      // Show a snackbar message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    // If all validations pass, go to next step
    if (isValid) {
      setState(() {
        _currentStep = 1;
      });
      context.router.push(const CheckoutCardRoute());
    }
  }

  // Custom input field builder
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required bool required,
    bool isError = false,
    TextInputType keyboardType = TextInputType.text,
    required ResponsiveUiConfig responsive,
    required Color labelColor,
    required Color textColor,
    required Color backgroundColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label row with asterisk for required fields
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: labelColor,
                fontSize: responsive.setWidth(14),
              ),
            ),
            if (required) SizedBox(width: responsive.setWidth(4)),
            if (required)
              Text(
                '*',
                style: TextStyle(
                  color: isError ? ColorLight.error : labelColor,
                  fontSize: responsive.setWidth(14),
                ),
              ),
          ],
        ),

        SizedBox(height: responsive.setHeight(8)),

        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(color: textColor, fontSize: responsive.setWidth(14)),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            isDense: true,
            filled: false,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(width: 1.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: isError ? ColorLight.error : labelColor,
                width: 1.0,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: isError ? ColorLight.error : textColor,
                width: 1.0,
              ),
            ),
            // Explicitly removing any elevation or shadow
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: labelColor.withValues(alpha: 0.5),
                width: 1.0,
              ),
            ),
          ),
        ),

        SizedBox(height: responsive.setHeight(24)),
      ],
    );
  }

  // Custom stepper UI for checkout process
  Widget _buildCheckoutStepper(ResponsiveUiConfig responsive, bool isDarkMode) {
    final activeColor = isDarkMode ? Colors.white : Colors.black;
    final inactiveColor =
        isDarkMode ? ColorDark.inputLabel : ColorLight.inputLabel;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Step 1 - Location
        Container(
          width: responsive.setWidth(24),
          height: responsive.setWidth(24),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentStep >= 0 ? activeColor : Colors.transparent,
            border: Border.all(
              color: _currentStep >= 0 ? activeColor : inactiveColor,
              width: 1.0,
            ),
          ),
          child: Icon(
            Icons.location_on,
            color:
                _currentStep >= 0
                    ? (isDarkMode
                        ? ColorDark.background
                        : ColorLight.background)
                    : inactiveColor,
            size: responsive.setWidth(14),
          ),
        ),

        // Five dots instead of one larger dot
        ..._buildDotSeparator(responsive, inactiveColor, 5),

        // Step 2 - Payment
        Container(
          width: responsive.setWidth(24),
          height: responsive.setWidth(24),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentStep >= 1 ? activeColor : Colors.transparent,
            border: Border.all(
              color: _currentStep >= 1 ? activeColor : inactiveColor,
              width: 1.0,
            ),
          ),
          child: Icon(
            Icons.credit_card,
            color:
                _currentStep >= 1
                    ? (isDarkMode
                        ? ColorDark.background
                        : ColorLight.background)
                    : inactiveColor,
            size: responsive.setWidth(14),
          ),
        ),

        // Five dots instead of one larger dot
        ..._buildDotSeparator(responsive, inactiveColor, 5),

        // Step 3 - Confirmation
        Container(
          width: responsive.setWidth(24),
          height: responsive.setWidth(24),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentStep >= 2 ? activeColor : Colors.transparent,
            border: Border.all(
              color: _currentStep >= 2 ? activeColor : inactiveColor,
              width: 1.0,
            ),
          ),
          child: Icon(
            Icons.check,
            color:
                _currentStep >= 2
                    ? (isDarkMode
                        ? ColorDark.background
                        : ColorLight.background)
                    : inactiveColor,
            size: responsive.setWidth(14),
          ),
        ),
      ],
    );
  }

  // Helper method to create the dot separators
  List<Widget> _buildDotSeparator(
    ResponsiveUiConfig responsive,
    Color color,
    int count,
  ) {
    return List.generate(
      count,
      (index) => Container(
        margin: EdgeInsets.symmetric(
          horizontal: responsive.setWidth(
            8,
          ), // Increased from 4 to 8 for more space
        ),
        width: responsive.setWidth(4),
        height: responsive.setWidth(4),
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }

  // Building shipping method selection
  Widget _buildShippingMethodSection(
    ResponsiveUiConfig responsive,
    bool isDarkMode,
    Color titleColor,
    Color subtitleColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shipping method',
          style: TextStyle(
            fontSize: responsive.setWidth(18),
            fontWeight: FontWeight.w600,
            color: titleColor,
          ),
        ),

        SizedBox(height: responsive.setHeight(16)),

        // Shipping method options
        ...List.generate(_shippingMethods.length, (index) {
          final method = _shippingMethods[index];
          final isSelected = _selectedShippingMethod == index;

          return Padding(
            padding: EdgeInsets.only(bottom: responsive.setHeight(16)),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedShippingMethod = index;
                });
              },
              borderRadius: BorderRadius.circular(responsive.setWidth(8)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Radio button
                  Container(
                    margin: EdgeInsets.only(top: responsive.setHeight(2)),
                    width: responsive.setWidth(20),
                    height: responsive.setWidth(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            isSelected
                                ? (isDarkMode
                                    ? ColorDark.success
                                    : ColorLight.success)
                                : (isDarkMode
                                    ? ColorDark.inputLabel
                                    : ColorLight.inputLabel),
                        width: 2,
                      ),
                    ),
                    child:
                        isSelected
                            ? Center(
                              child: Container(
                                width: responsive.setWidth(12),
                                height: responsive.setWidth(12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      isDarkMode
                                          ? ColorDark.success
                                          : ColorLight.success,
                                ),
                              ),
                            )
                            : null,
                  ),

                  SizedBox(width: responsive.setWidth(12)),

                  // Method details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              method.title,
                              style: TextStyle(
                                fontSize: responsive.setWidth(16),
                                fontWeight: FontWeight.w600,
                                color: titleColor,
                              ),
                            ),
                            SizedBox(width: responsive.setWidth(12)),
                            Text(
                              method.subtitle,
                              style: TextStyle(
                                fontSize: responsive.setWidth(14),
                                color: titleColor,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: responsive.setHeight(4)),

                        Text(
                          method.description,
                          style: TextStyle(
                            fontSize: responsive.setWidth(12),
                            color: subtitleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  // Building coupon code section
  Widget _buildCouponCodeSection(
    ResponsiveUiConfig responsive,
    bool isDarkMode,
    Color titleColor,
    Color inputLabelColor,
    Color backgroundColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Coupon Code',
          style: TextStyle(
            fontSize: responsive.setWidth(18),
            fontWeight: FontWeight.w600,
            color: titleColor,
          ),
        ),

        SizedBox(height: responsive.setHeight(16)),

        // Coupon input with validate button
        Container(
          decoration: BoxDecoration(
            color:
                isDarkMode
                    ? ColorDark.inputBackground
                    : ColorLight.inputBackground,
            borderRadius: BorderRadius.circular(responsive.setWidth(4)),
          ),
          child: Row(
            children: [
              // Input field
              Expanded(
                child: TextField(
                  controller: _couponController,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: responsive.setWidth(14),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Have a code? type it here...',
                    hintStyle: TextStyle(
                      color: inputLabelColor,
                      fontSize: responsive.setWidth(14),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: responsive.setWidth(16),
                      vertical: responsive.setHeight(14),
                    ),
                  ),
                ),
              ),

              // Validate button
              TextButton(
                onPressed: () {
                  // Coupon validation logic
                  if (_couponController.text.isNotEmpty) {
                    // Validate coupon
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Validating coupon: ${_couponController.text}',
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor:
                      isDarkMode ? ColorDark.info : ColorLight.info,
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.setWidth(16),
                    vertical: responsive.setHeight(14),
                  ),
                ),
                child: Text(
                  'Validate',
                  style: TextStyle(
                    fontSize: responsive.setWidth(14),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Building billing address section
  Widget _buildBillingAddressSection(
    ResponsiveUiConfig responsive,
    bool isDarkMode,
    Color titleColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Billing Address',
          style: TextStyle(
            fontSize: responsive.setWidth(18),
            fontWeight: FontWeight.w600,
            color: titleColor,
          ),
        ),

        SizedBox(height: responsive.setHeight(16)),

        // Checkbox to copy shipping address
        InkWell(
          onTap: () {
            setState(() {
              _copyAddressFromShipping = !_copyAddressFromShipping;
            });
          },
          child: Row(
            children: [
              SizedBox(
                width: responsive.setWidth(24),
                height: responsive.setWidth(24),
                child: Checkbox(
                  value: _copyAddressFromShipping,
                  onChanged: (value) {
                    setState(() {
                      _copyAddressFromShipping = value ?? false;
                    });
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  activeColor:
                      isDarkMode ? ColorDark.success : ColorLight.success,
                ),
              ),

              SizedBox(width: responsive.setWidth(12)),

              Text(
                'Copy address data from shipping',
                style: TextStyle(
                  color: titleColor,
                  fontSize: responsive.setWidth(14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Model class for shipping method
class ShippingMethod {
  final String title;
  final String subtitle;
  final String description;
  final double price;

  ShippingMethod({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.price,
  });
}
