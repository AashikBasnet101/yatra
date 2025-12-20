import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newprojectfirebase/core/constants/string_const.dart';
import 'package:newprojectfirebase/features/auth/bloc/auth_bloc.dart';
import 'package:newprojectfirebase/features/auth/bloc/auth_event.dart';
import 'package:newprojectfirebase/features/auth/bloc/auth_state.dart';
import 'package:newprojectfirebase/features/auth/model/user.dart';
import 'package:newprojectfirebase/features/widgets/custom_snackbar.dart';
import 'package:newprojectfirebase/login_screen.dart';
import 'package:newprojectfirebase/features/providers/auth_provider.dart';
import 'package:newprojectfirebase/features/widgets/custom_elevated_button.dart';
import 'package:newprojectfirebase/features/widgets/custom_textformfield.dart';
import 'package:newprojectfirebase/signout.dart';
import 'package:newprojectfirebase/utils/route_generator.dart';
import 'package:newprojectfirebase/utils/routes.dart';
import 'package:newprojectfirebase/verify_identity.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
 String? name , address , emailAddress , password ;

  @override
 
  Widget build(BuildContext context) {
  


    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state){ 
            if (state is AuthErrorState) {
      displaySnackBar(context, state.message);
    }

    if (state is AuthLoadedState) {
      RouteGenerator.navigateToPageWithoutStack(
  context,
  Routes.verifyIdentityRoute,
);

    }},
 
          child:  Column(
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
                    onChanged: (val) {
                      name = val;
                    },
                  ),
                ],
              ),
          
              const SizedBox(height: 12),
          
              // ---------------- Address --------------------
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
                    onChanged: (val) {
                      address =val;
                    },
                  ),
                ],
              ),
          
              
          
           const SizedBox(height: 12),
          
           Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStrings.email,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
          
                  CustomTextform(
                    labelText: AppStrings.enterEmail,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      emailAddress = val;
                    },
                  ),
                ],
              ),
          
           const SizedBox(height: 12),
          
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
                    onChanged: (val) {
                      password = val;
                    },
                  ),
                ],
              ),
          
              const SizedBox(height: 20),
          
              // ---------------- Proceed Button ----------------
              CustomElevatedButton(
            width: double.infinity,
            backgroundColor: const Color(0xFF3D8DB5),
            onPressed: (){
          
          
              User user=User(
                name: name,
                address: address,
                email: emailAddress,
                password: password,
                profileUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Salman_Khan_in_2023_%281%29_%28cropped%29.jpg/250px-Salman_Khan_in_2023_%281%29_%28cropped%29.jpg",
              identity: Identity(
                type: "passport",
                url: "https://imgv2-2-f.scribdassets.com/img/document/692140141/original/7de1429d40/1?v=1")
              );
              
              context.read<AuthBloc>().add(SignupEvent(user)) ;
              
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => VerifyIdentityScreen(),
            //   ),
            // );
          },
            child:  Text(
            AppStrings.proceed,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          ),
          
          
             
          
              // ---------------- Login Info ----------------
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                  },
                  child: const Text(
                    AppStrings.loginInfo,
                    style: TextStyle(
                      color: Color.fromARGB(255, 92, 88, 88),
                      fontSize: 15,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ),
          
              const SizedBox(height: 10),
          
          
              Row(
                children: const [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
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
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
          
               const SizedBox(height: 10),
          
              // ---------------- Google Sign-Up Button ----------------
              // CustomElevatedButton(
              //   width: double.infinity,
              //   backgroundColor: Colors.white,
              //   foregroundColor: Colors.black,
              //   onPressed: auth.isLoading
              //       ? null
              //       : () async {
              //           bool ok = await auth.signInWithGoogle();
              //           if (ok) {
              //             Navigator.pushReplacement(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (_) => const GoogleSignout(),
              //               ),
              //             );
              //           } else {
              //             ScaffoldMessenger.of(context).showSnackBar(
              //               const SnackBar(
              //                 content: Text("Google Sign-Up Failed"),
              //               ),
              //             );
              //           }
              //         },
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Image.asset("assets/google_logo.png", width: 22, height: 22),
              //       const SizedBox(width: 10),
              //       const Text("Sign in with Google"),
              //     ],
              //   ),
              // ),
            ],
            
          ),
        ),
      ),
    );
  }
}