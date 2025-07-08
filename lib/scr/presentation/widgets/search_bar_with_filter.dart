import 'package:flutter/material.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';

class SearchBarWithFilter extends StatefulWidget {
  final String? hintText;
  final Function(String)? onSearchChanged;
  final VoidCallback? onSearchTap;
  final VoidCallback? onFilterTap;
  final TextEditingController? searchController;
  final FocusNode? searchFocusNode;
  final bool readOnly;

  const SearchBarWithFilter({
    super.key,
    this.hintText = "Search",
    this.onSearchChanged,
    this.onSearchTap,
    this.onFilterTap,
    this.searchController,
    this.searchFocusNode,
    this.readOnly = false,
  });

  @override
  State<SearchBarWithFilter> createState() => _SearchBarWithFilterState();
}

class _SearchBarWithFilterState extends State<SearchBarWithFilter> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.searchController ?? TextEditingController();
    _focusNode = widget.searchFocusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.searchController == null) {
      _controller.dispose();
    }
    if (widget.searchFocusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);

    final backgroundColor =
        isDarkMode ? ColorDark.inputBackground : ColorLight.inputBackground;
    final hintColor = isDarkMode ? ColorDark.inputHint : ColorLight.inputHint;
    final iconColor =
        isDarkMode ? ColorDark.iconSecondary : ColorLight.iconSecondary;
    final textColor = isDarkMode ? ColorDark.inputText : ColorLight.inputText;

    // Search bar dimensions
    final height = responsive.setHeight(48);
    final searchBorderRadius = responsive.setWidth(
      50,
    ); 
    final filterBorderRadius = responsive.setWidth(
      16,
    ); 
    final fontSize = responsive.setWidth(14);
    final iconSize = responsive.setWidth(22);
    final horizontalPadding = responsive.setWidth(16);
    final verticalPadding = responsive.setHeight(14);
    final spaceBetween = responsive.setWidth(20);
    final filterButtonSize = responsive.setWidth(48);

    final boxShadow = [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: 8,
        spreadRadius: 0,
        offset: const Offset(0, 2),
      ),
    ];

    return Row(
      children: [
        // Search Bar
        Expanded(
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(searchBorderRadius),
              boxShadow: boxShadow,
            ),
            child: Row(
              children: [
                // Search Icon
                Padding(
                  padding: EdgeInsets.only(
                    left: horizontalPadding,
                    right: responsive.setWidth(10),
                  ),
                  child: Icon(Icons.search, color: iconColor, size: iconSize),
                ),

                // Search TextField
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    onChanged: widget.onSearchChanged,
                    onTap: widget.onSearchTap,
                    readOnly: widget.readOnly,
                    style: TextStyle(fontSize: fontSize, color: textColor),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        fontSize: fontSize,
                        color: hintColor,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: verticalPadding,
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      filled: false,
                    ),
                  ),
                ),

                // Right padding
                SizedBox(width: horizontalPadding),
              ],
            ),
          ),
        ),

        SizedBox(width: spaceBetween),

        // Filter Button
        Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(filterBorderRadius),
          elevation: 2,
          shadowColor: Colors.black.withValues(alpha: 0.1),
          child: InkWell(
            onTap: widget.onFilterTap,
            borderRadius: BorderRadius.circular(filterBorderRadius),
            child: Container(
              height: filterButtonSize,
              width: filterButtonSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(filterBorderRadius),
              ),
              child: Center(
                child: Icon(
                  Icons.tune,
                  size: responsive.setWidth(24),
                  color: iconColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
