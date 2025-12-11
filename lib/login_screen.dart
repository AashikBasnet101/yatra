import 'package:flutter/material.dart';
import 'package:newprojectfirebase/core/constants/string_const.dart';
import 'package:newprojectfirebase/features/providers/auth_provider.dart';
import 'package:newprojectfirebase/features/widgets/custom_elevated_button.dart';
import 'package:newprojectfirebase/features/widgets/custom_textformfield.dart';
import 'package:newprojectfirebase/forgot_password.dart';
import 'package:newprojectfirebase/signout.dart';
import 'package:newprojectfirebase/signup_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ---------------- Logo / Image ----------------
            Center(
              child: SizedBox(
                height: 180,
                width: MediaQuery.of(context).size.width * 0.80,
                child: Image.asset("assets/yatra.png"),
              ),
            ),

            const SizedBox(height: 20),

            // ---------------- Titles ----------------
            Text(
              'Welcome Back',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF3D8DB5),
                fontSize: 22,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Once more, destiny calls you forth.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xA0161411),
                fontSize: 14,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w400,
                height: 1.71,
              ),
            ),

            const SizedBox(height: 30),

            // ---------------- phone ----------------
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.phone,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                CustomTextform(
                  labelText: AppStrings.enterPhone,
                  onChanged: (val) {},
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ---------------- Password ----------------
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.password,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                CustomTextform(
                  labelText: AppStrings.enterPassword,
                  obscureText: true,
                  onChanged: (val) {},
                ),
              ],
            ),

            // ---------------- Forgot Password ----------------
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: GestureDetector(
                  onTap: () {
              
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 92, 88, 88),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ---------------- Login Button ----------------
            CustomElevatedButton(
              width: double.infinity,
              backgroundColor: const Color(0xFF3D8DB5),
              onPressed: auth.isLoading ? null : () {},
              child: auth.isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      AppStrings.login,
                      style: TextStyle(
                        fontSize: 16, // 👈 Set font size here
                        fontWeight: FontWeight.w500, // optional
                      ),
                    ),
            ),

            const SizedBox(height: 6),

            // ---------------- Sign Up Info ----------------
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()),
                  );
                },
                child: const Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(
                    color: Color.fromARGB(255, 92, 88, 88),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                ],
              ),
            ),

            // ---------------- Google Sign-In Button ----------------
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomElevatedButton(
                width: double.infinity,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                onPressed: auth.isLoading
                    ? null
                    : () async {
                        bool ok = await auth.signInWithGoogle();
                        if (ok) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const GoogleSignout(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Google Sign-In Failed"),
                            ),
                          );
                        }
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/google_logo.png",
                      width: 22,
                      height: 22,
                    ),
                    const SizedBox(width: 10),
                    const Text("Sign In with Google"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
