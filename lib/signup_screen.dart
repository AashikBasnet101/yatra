import 'package:flutter/material.dart';
import 'package:newprojectfirebase/core/constants/string_const.dart';
import 'package:newprojectfirebase/features/providers/auth_provider.dart';
import 'package:newprojectfirebase/features/widgets/custom_elevated_button.dart';
import 'package:newprojectfirebase/features/widgets/custom_textformfield.dart';
import 'package:newprojectfirebase/signout.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- Logo ----------------
            Center(
              child: SizedBox(
                height: 180,
                width: MediaQuery.of(context).size.width * 0.80,
                child: Image.asset("assets/yatra.png"),
              ),
            ),

            const SizedBox(height: 10),

            // ---------------- Titles ----------------
            Center(
              child: Text(
                AppStrings.getStarted,
                style: const TextStyle(
                  color: Color(0xFF3D8DB5),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Center(
              child: Text(
                AppStrings.subtitle,
                style: const TextStyle(fontSize: 15, color: Color(0xA0161411)),
              ),
            ),

            const SizedBox(height: 20),

            // ---------------- Name ----------------
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                CustomTextform(
                  labelText: AppStrings.enterName,
                  onChanged: (val) {},
                ),
              ],
            ),

            // ---------------- Address ----------------
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.address,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                CustomTextform(
                  labelText: AppStrings.enterAddress,
                  onChanged: (val) {},
                ),
              ],
            ),

            // ---------------- Phone ----------------
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
                  keyboardType: TextInputType.phone,
                  onChanged: (val) {},
                ),
              ],
            ),

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

            const SizedBox(height: 20),

            // ---------------- Proceed Button ----------------
            CustomElevatedButton(
              width: double.infinity,
              backgroundColor: const Color(0xFF3D8DB5),
              onPressed: auth.isLoading ? null : () {},
              child: auth.isLoading
                  ? const CircularProgressIndicator()
                  : Text(AppStrings.proceed),
            ),

            const SizedBox(height: 16),

            // ---------------- Login Info ----------------
            Center(
              child: Text(
                AppStrings.loginInfo,
                style: const TextStyle(color: Color(0xFF897760)),
              ),
            ),

            const SizedBox(height: 20),

            // ---------------- Google Sign-In Button ----------------
            CustomElevatedButton(
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
                  Image.asset("assets/google_logo.png", width: 22, height: 22),
                  const SizedBox(width: 10),
                  const Text("Sign in with Google"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
