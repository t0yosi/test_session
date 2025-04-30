import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive.dart';
import '../utils/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool showPasswordToggle;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final String? initialValue;
  final bool? isValid;
  final bool isPasswordField;
  final bool obscureText;
  final VoidCallback? onVisibilityToggle;

  const CustomTextField({
    super.key,
    required this.label,
    this.showPasswordToggle = false,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
    this.initialValue,
    this.isPasswordField = false,
    this.obscureText = true,
    this.onVisibilityToggle,
    this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor =  Color(0xFF979797);
    const activeBorderColor = Color(0xFFAB28B2); // #AB28B2 in Color format

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.screenHeight(context) * 0.01,
        // horizontal: Responsive.screenWidth(context) * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Focus(
            onFocusChange: (hasFocus) {}, // Needed for the focus border color
            child: TextFormField(
              initialValue: initialValue,
              keyboardType: keyboardType,
              style: AppTextStyles.bodyLarge(context),
              obscureText: isPasswordField ? obscureText : false,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: GoogleFonts.inter(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color
                      ?.withOpacity(0.6),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(
                    color: activeBorderColor,
                    width: 2.0,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Responsive.screenWidth(context) * 0.04,
                  vertical: Responsive.screenHeight(context) * 0.02,
                ),
                suffixIcon: isPasswordField
                    ? IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: onVisibilityToggle,
                      )
                    : null,
              ),
              onChanged: onChanged,
            ),
          ),
          if (label.toLowerCase().contains('password') && isValid != null)
            Padding(
              padding: EdgeInsets.only(
                  top: Responsive.screenHeight(context) * 0.005),
              child: Text(
                isValid!
                    ? 'Password meets requirements'
                    : 'Password must contain:\n- 8+ characters\n- 1 uppercase\n- 1 lowercase\n- 1 number',
                style: GoogleFonts.inter(
                  fontSize: Responsive.responsiveFontSize(context) * 0.8,
                  color: isValid!
                      ? Colors.green
                      : Theme.of(context).colorScheme.error,
                ),
              ),
            ),
        ],
      ),
    );
  }
}