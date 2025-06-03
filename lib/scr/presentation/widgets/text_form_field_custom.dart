import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:flutter/material.dart';

class TextFormFieldCustom extends TextFormField {
  TextFormFieldCustom({
    super.key,
    required String label,
    required String placeholder,
    super.initialValue,
    super.controller,
    required bool isDarkMode,
    required ResponsiveUiConfig responsive,
    FormFieldValidator<String>? validator,
    super.keyboardType,
    super.obscureText,
    int? maxLines,
    super.readOnly,
    super.onChanged,
  }) : super(
         decoration: InputDecoration(
           labelText: label,
           hintText: placeholder,
           hintStyle:
               isDarkMode
                   ? const TextStyle(color: Colors.white24, fontSize: 13)
                   : const TextStyle(color: Colors.black26, fontSize: 13),
           filled: true,
           fillColor: isDarkMode ? Colors.white60 : Colors.grey[50],
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(12),
             borderSide: BorderSide.none,
           ),
           contentPadding: EdgeInsets.symmetric(
             horizontal: responsive.setWidth(16),
             vertical: responsive.setHeight(16),
           ),
         ),
         validator:
             validator ??
             (value) {
               if (value == null || value.isEmpty) {
                 return 'Please enter $label';
               }
               return null;
             },
         maxLines: maxLines ?? 1,
       );
}
