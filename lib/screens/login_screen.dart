import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/custom_text_field.dart';
import '../utils/responsive.dart';
import '../utils/text_styles.dart';
import 'shop_page_screen.dart'; 

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    // Centered "Login" text at top
                    Text(
                      'Login',
                      style: AppTextStyles.bodyLarge(context).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Responsive.screenHeight(context) * 0.05),

                    // Left-aligned "Login" text
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Login',
                        style: AppTextStyles.bodyMedium(context),
                      ),
                    ),
                    SizedBox(height: Responsive.screenHeight(context) * 0.05),

                    // Form fields
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

                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Navigate to forgot password screen
                        },
                        child: Text(
                          'Forgot Password?',
                          style: AppTextStyles.labelLarge(context).copyWith(
                            color: const Color(0xFFFFFFFF),
                            fontSize: Responsive.responsiveFontSize(context) * 0.9,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.screenHeight(context) * 0.03),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            authProvider.isLoading || !authProvider.passwordValid
                                ? null
                                : () async {
                                    await authProvider.login();
                                    // Navigate to ShopPage after successful login
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const ShopPage(),
                                      ),
                                    );

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
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Login',
                                style: AppTextStyles.labelLarge(context).copyWith(
                                  fontSize: Responsive.responsiveFontSize(context),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // "Don't own an account? Signup" text fixed at bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Center(
              child: Text.rich(
                TextSpan(
                  text: "Don't own an account? ",
                  style: AppTextStyles.labelLarge(context).copyWith(
                    color: Colors.grey,
                    fontSize: Responsive.responsiveFontSize(context) * 0.9,
                  ),
                  children: [
                    TextSpan(
                      text: "Signup",
                      style: AppTextStyles.labelLarge(context).copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                      // To add navigation:
                      // recognizer: TapGestureRecognizer()
                      //   ..onTap = () {
                      //     Navigator.push(context, MaterialPageRoute(
                      //       builder: (context) => SignupScreen()));
                      //   },
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