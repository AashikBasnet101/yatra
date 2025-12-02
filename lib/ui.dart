import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/providers/auth_provider.dart';
import 'signout.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: authProvider.isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    bool success =
                        await authProvider.signInWithGoogle();

                    if (success) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GoogleSignout(),
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/google_logo.png",
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 48),
                      const Text("Sign in with Google"),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
