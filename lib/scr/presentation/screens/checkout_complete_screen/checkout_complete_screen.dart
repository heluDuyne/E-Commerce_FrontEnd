import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:e_commerce_frontend/scr/core/utils/app_route/app_router.gr.dart';

@RoutePage()
class CheckoutCompleteScreen extends StatelessWidget {
  const CheckoutCompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);

    return Scaffold(
      backgroundColor:
          isDarkMode ? ColorDark.background : ColorLight.background,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor:
            isDarkMode ? ColorDark.background : ColorLight.background,
        elevation: 0,
        leadingWidth: responsive.setWidth(55),
        leading: Padding(
          padding: EdgeInsets.only(left: responsive.setWidth(20)),
          child: Container(
            width: responsive.setWidth(32),
            height: responsive.setWidth(32),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDarkMode ? ColorDark.background : ColorLight.background,
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
                Icons.chevron_left,
                color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
                size: responsive.setWidth(20),
              ),
              onPressed: () => context.router.pop(),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ),
        title: Text(
          'Check out',
          style: TextStyle(
            color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
            fontSize: responsive.setWidth(16),
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(responsive.setWidth(24)),
          child: Column(
            children: [
              // Checkout stepper
              _buildCheckoutStepper(responsive, isDarkMode),

              SizedBox(height: responsive.setHeight(40)),

              // Order Completed title
              Text(
                'Order Completed',
                style: TextStyle(
                  color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
                  fontSize: responsive.setWidth(24),
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: responsive.setHeight(40)),

              // Shopping bag with checkmark icon
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  // Shopping bag icon
                  Container(
                    width: responsive.setWidth(80),
                    height: responsive.setWidth(80),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: responsive.setWidth(80),
                      color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
                    ),
                  ),

                  // Checkmark in circle
                  Container(
                    width: responsive.setWidth(40),
                    height: responsive.setWidth(40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
                    ),
                    child: Icon(
                      Icons.check,
                      color: isDarkMode ? ColorDark.background : ColorLight.background,
                      size: responsive.setWidth(24),
                    ),
                  ),
                ],
              ),

              SizedBox(height: responsive.setHeight(40)),

              // Thank you message
              Text(
                'Thank you for your purchase.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
                  fontSize: responsive.setWidth(16),
                ),
              ),

              SizedBox(height: responsive.setHeight(8)),

              // View order message
              Text(
                'You can view your order in \'My Orders\' section.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
                  fontSize: responsive.setWidth(16),
                ),
              ),

              // Spacer to push button to bottom
              SizedBox(height: responsive.setHeight(120)),

              // Continue shopping button
              SizedBox(
                width: double.infinity,
                height: responsive.setHeight(50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode ? ColorDark.buttonBackground : ColorLight.buttonBackground,
                    foregroundColor: isDarkMode ? ColorDark.buttonText : ColorLight.buttonText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    context.router.popUntil((route) => route.isFirst);
                  },
                  child: Text(
                    'Continue shopping',
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

  Widget _buildCheckoutStepper(ResponsiveUiConfig responsive, bool isDarkMode) {
    final activeColor = Colors.black; // Always black regardless of theme
    final inactiveColor = isDarkMode ? ColorDark.inputLabel : ColorLight.inputLabel;
    final activeIconColor = Colors.white; // White icon color for active steps

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Step 1 - Location (completed)
        Container(
          width: responsive.setWidth(24),
          height: responsive.setWidth(24),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: activeColor,
            border: Border.all(
              color: activeColor,
              width: 1.0,
            ),
          ),
          child: Icon(
            Icons.location_on,
            color: activeIconColor,
            size: responsive.setWidth(14),
          ),
        ),

        // Five dots separator
        ..._buildDotSeparator(responsive, inactiveColor, 5),

        // Step 2 - Payment (completed)
        Container(
          width: responsive.setWidth(24),
          height: responsive.setWidth(24),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: activeColor,
            border: Border.all(
              color: activeColor,
              width: 1.0,
            ),
          ),
          child: Icon(
            Icons.credit_card,
            color: activeIconColor,
            size: responsive.setWidth(14),
          ),
        ),

        // Five dots separator
        ..._buildDotSeparator(responsive, inactiveColor, 5),

        // Step 3 - Confirmation (completed)
        Container(
          width: responsive.setWidth(24),
          height: responsive.setWidth(24),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: activeColor,
            border: Border.all(
              color: activeColor,
              width: 1.0,
            ),
          ),
          child: Icon(
            Icons.check,
            color: activeIconColor,
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
          horizontal: responsive.setWidth(8),
        ),
        width: responsive.setWidth(4),
        height: responsive.setWidth(4),
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}