import 'package:flutter/material.dart';
import 'package:newprojectfirebase/signup_screen.dart';
import 'package:newprojectfirebase/ui.dart';
import 'package:provider/provider.dart';
import 'features/providers/auth_provider.dart';


class GoogleSignout extends StatelessWidget {
  const GoogleSignout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Sign out"),
          onPressed: () async {
            await Provider.of<AuthProvider>(context, listen: false).signOut();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
        ),
      ),
    );
  }
}
