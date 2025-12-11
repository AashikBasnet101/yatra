import 'package:flutter/material.dart';
import 'package:newprojectfirebase/features/widgets/custom_elevated_button.dart';
import 'package:newprojectfirebase/features/widgets/custom_textformfield.dart';
import 'package:newprojectfirebase/otp.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "Forgot Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text(
                "Find your account",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),

              const Text(
                "Enter your registered phone number.\nWe’ll send you a verification code.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),

              const SizedBox(height: 40),

              // Phone input using CustomTextform
              CustomTextform(
                labelText: "Phone number",
                keyboardType: TextInputType.phone,
                onChanged: (value) {},
              ),

              const Spacer(),

              // Send code button using CustomElevatedButton
              CustomElevatedButton(
                width: double.infinity,
                height: 50,
                backgroundColor: const Color(0xFF5B8FB9),
                borderRadius: 12,
                child: const Text("Send Code", style: TextStyle(fontSize: 16)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ResetOtp()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
