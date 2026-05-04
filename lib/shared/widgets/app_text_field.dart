import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
  });

  final String label;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      style: AppTextStyles.body,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.caption,
        prefixIcon: prefixIcon == null ? null : Icon(prefixIcon, size: 18),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.backgroundElevated,
        errorStyle: AppTextStyles.caption.copyWith(color: AppColors.accentRed),
        enabledBorder: _border(AppColors.borderSubtle, 1),
        focusedBorder: _border(AppColors.accentSaber, 1.5),
        errorBorder: _border(AppColors.accentRed, 1),
        focusedErrorBorder: _border(AppColors.accentRed, 1.5),
      ),
    );
  }

  OutlineInputBorder _border(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
