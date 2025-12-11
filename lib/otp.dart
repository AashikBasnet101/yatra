import 'package:flutter/material.dart';
import 'package:newprojectfirebase/features/widgets/custom_elevated_button.dart';
import 'package:newprojectfirebase/features/widgets/custom_textformfield.dart';

class ResetOtp extends StatefulWidget {
  const ResetOtp({super.key});

  @override
  State<ResetOtp> createState() => _ResetOtpNewState();
}

class _ResetOtpNewState extends State<ResetOtp> {
  List<String> otp = ["", "", "", ""];

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
                  const SizedBox(width:16),
                  const Text(
                    "Verify Code",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text(
                "Enter code",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 10),

              const Text(
                "Enter the 4-digit code sent to your phone number.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),

              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (i) => _otpBox(i)),
              ),

              const Spacer(),

              const Center(
                child: Text(
                  "Didn't receive code? Wait 30s",
                  style: TextStyle(color: Colors.black54),
                ),
              ),

              const SizedBox(height: 20),

              CustomElevatedButton(
                width: double.infinity,
                height: 50,
                backgroundColor: const Color(0xFF5B8FB9),
                borderRadius: 12,
                child: const Text("Verify", style: TextStyle(fontSize: 16)),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget _otpBox(int index) {
    return SizedBox(
      width: 60,
      height: 60,
      child: CustomTextform(
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.isNotEmpty) {
            otp[index] = value;
            if (index < 3) FocusScope.of(context).nextFocus();
          }
        },
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
