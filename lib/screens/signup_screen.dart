import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/custom_text_field.dart';
import '../utils/responsive.dart';
import '../utils/text_styles.dart';
import 'shop_page_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeProvider.setTheme(
                isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.screenWidth(context) * 0.1,
                ),
                child: Column(
                  children: [
                    // Centered "Sign Up" text at top
                    Text(
                      'Sign Up',
                      style: AppTextStyles.bodyLarge(context).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Responsive.screenHeight(context) * 0.05),

                    // Left-aligned "Sign Up" text
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     'Sign Up',
                    //     style: AppTextStyles.bodyMedium(context),
                    //   ),
                    // ),
                    // SizedBox(height: Responsive.screenHeight(context) * 0.05),

                    // Form fields
                    CustomTextField(
                      label: 'First Name',
                      keyboardType: TextInputType.name,
                      initialValue: authProvider.firstName,
                      onChanged: (value) => authProvider.setFirstName(value),
                    ),
                    SizedBox(height: Responsive.screenHeight(context) * 0.02),

                    CustomTextField(
                      label: 'Last Name',
                      keyboardType: TextInputType.name,
                      initialValue: authProvider.lastName,
                      onChanged: (value) => authProvider.setLastName(value),
                    ),
                    SizedBox(height: Responsive.screenHeight(context) * 0.02),
                    CustomTextField(
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      initialValue: authProvider.email,
                      onChanged: (value) => authProvider.setEmail(value),
                    ),
                    SizedBox(height: Responsive.screenHeight(context) * 0.02),
                    CustomTextField(
                      label: 'Enter Password',
                      isPasswordField: true,
                      obscureText: authProvider.obscurePassword,
                      onVisibilityToggle: () =>
                          authProvider.togglePasswordVisibility(),
                      onChanged: (value) => authProvider.setPassword(value),
                      isValid: authProvider.password.isEmpty
                          ? null
                          : authProvider.passwordValid,
                    ),
                    SizedBox(height: Responsive.screenHeight(context) * 0.02),
                    CustomTextField(
                      label: 'Confirm Password',
                      isPasswordField: true,
                      obscureText: authProvider.obscureConfirmPassword,
                      onVisibilityToggle: () =>
                          authProvider.toggleConfirmPasswordVisibility(),
                      onChanged: (value) =>
                          authProvider.setConfirmPassword(value),
                      isValid: authProvider.confirmPassword.isEmpty
                          ? null
                          : authProvider.confirmPassword ==
                              authProvider.password,
                    ),
                    SizedBox(height: Responsive.screenHeight(context) * 0.03),

                    // Sign Up button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: authProvider.isLoading ||
                                !authProvider.passwordValid ||
                                authProvider.confirmPassword !=
                                    authProvider.password
                            ? null
                            : () async {
                                await authProvider.signup();
                                if (context.mounted) {
                                  // Navigate to ShopPage after successful signup
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ShopPage(),
                                    ),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: Responsive.screenHeight(context) * 0.02,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: authProvider.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.purple)
                            : Text(
                                'Sign Up',
                                style:
                                    AppTextStyles.labelLarge(context).copyWith(
                                  fontSize:
                                      Responsive.responsiveFontSize(context),
                                  fontWeight: FontWeight.w600,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // "Already have an account? Login" text fixed at bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: AppTextStyles.labelLarge(context).copyWith(
                    color: Colors.grey,
                    fontSize: Responsive.responsiveFontSize(context) * 0.9,
                  ),
                  children: [
                    TextSpan(
                      text: "Login",
                      style: AppTextStyles.labelLarge(context).copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .clearFields();
                                return const LoginScreen();
                              },
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
