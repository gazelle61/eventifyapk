import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tryflutter/pages/signup_page.dart';
import 'dart:developer';
import '../services/auth_service.dart';
import '../widgets/my_text_button.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text_field.dart';
import 'event_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = AuthService();
  final _password = TextEditingController();
  final _email = TextEditingController();
  bool isLoading = false;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;

  @override
  void dispose() {
    _password.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      appBar: AppBar(
        title: Text(
          "",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextField(
                hintText: "email",
                isObsecure: false,
                controller: _email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email cannot be empty";
                  } else if (!value.contains("@gmail.com")) {
                    return "Email must be a valid @gmail.com address";
                  }
                  return null;
                },
              ),
              SizedBox(height: 13),
              MyTextField(
                hintText: "password",
                isObsecure: true,
                controller: _password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password cannot be empty";
                  } else if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              MyButton(
                text: "login",
                color: Colors.blue,
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;

                  setState(() {
                    _isEmailValid = email.endsWith("@gmail.com");
                    _isPasswordValid = password.length >= 6;
                  });

                  if (_isEmailValid && _isPasswordValid) {
                    final user = await _auth.loginUserWithEmailAndPassword(email, password);
                    if (user != null) {
                      log("User Logged In");
                      Get.snackbar(
                        "Success",
                        "Login successful!",
                        backgroundColor: const Color.fromARGB(255, 127, 222, 130),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        duration: Duration(seconds: 3),
                      );
                      goToHome(context);
                    } else {
                      Get.snackbar(
                        "Error",
                        "Login failed. Please try again.",
                        backgroundColor: const Color.fromARGB(255, 246, 142, 135),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        duration: Duration(seconds: 3),
                      );
                    }
                  } else {
                    if (!_isEmailValid) {
                      Get.snackbar(
                        "Invalid Email",
                        "Please use a valid email ending with @gmail.com.",
                        backgroundColor: const Color.fromARGB(255, 246, 142, 135),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        duration: Duration(seconds: 3),
                      );
                    } else if (!_isPasswordValid) {
                      Get.snackbar(
                        "Invalid Password",
                        "Password must be at least 6 characters.",
                        backgroundColor: const Color.fromARGB(255, 246, 142, 135),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        duration: Duration(seconds: 3),
                      );
                    }
                  }
                },
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: 10),
              Text(
                "or login with",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Atur posisi ke kiri tanpa jarak antar ikon
                children: [
                  MyTextButton(
                    onPressed: () async {
                      final user = await _auth.loginWithGoogle();
                      if (user?.user != null) {
                        log("User Logged In with Google");
                        showSnackbar(context, "Login with Google successful!");
                        goToHome(context);
                      } else {
                        showSnackbar(context, "Google login failed.");
                      }
                    },
                    imagePath: 'assets/images/gugel.png',
                  ),
                  MyTextButton(
                    onPressed: () async {
                      // Implement Facebook login function
                    },
                    imagePath: 'assets/images/fb.png',
                  ),
                  MyTextButton(
                    onPressed: () async {
                      // Implement Twitter login function
                    },
                    imagePath: 'assets/images/x.png',
                  ),
                  MyTextButton(
                    onPressed: () async {
                      // Implement other login function
                    },
                    imagePath: 'assets/images/ip.png',
                  ),
                ],
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "don't have an account?",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () => goToSignup(context),
                    child: Text(
                      "sign up",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToSignup(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignupPage()),
      );

  void goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EventView()),
      );

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
