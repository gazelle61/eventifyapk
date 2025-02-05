import 'dart:developer';
import 'package:tryflutter/pages/event_view.dart';
import 'package:tryflutter/pages/login_page.dart';
import 'package:tryflutter/widgets/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _auth = AuthService();
  final _name = TextEditingController();
  final _password = TextEditingController();
  final _email = TextEditingController();

  bool _isEmailValid = true;
  bool _isPasswordValid = true;

  @override
  void dispose() {
    _name.dispose();
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
          style: AppStyles.heading1,
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
                hintText: "name",
                isObsecure: false,
                controller: _name,
              ),
              SizedBox(height: AppStyles.spaceS),
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
              SizedBox(height: AppStyles.spaceS),
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
              SizedBox(height: AppStyles.spaceXL),
              MyButton(
                text: "create account",
                color: AppStyles.textColor,
                onPressed: _signup,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(height: AppStyles.spaceL),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "already have an account?",
                    style: AppStyles.caption,
                  ),
                  SizedBox(width: AppStyles.spaceXS),
                  InkWell(
                    onTap: () => goToLogin(context),
                    child: Text(
                      "login",
                      style: AppStyles.inkwell,
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

  void goToLogin(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginPage()),
  );

  void goToHome(BuildContext context) => Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => EventView()),
  );

  Future<void> _signup() async {
    final email = _email.text;
    final password = _password.text;

    // Validasi email dan password
    setState(() {
      _isEmailValid = email.endsWith("@gmail.com");
      _isPasswordValid = password.length >= 6;
    });

    if (_isEmailValid && _isPasswordValid) {
      final user = await _auth.createUserWithEmailAndPassword(email, password);

      if (user != null) {
        log("User Created Successfully");
        Get.snackbar(
          "Success",
          "Signup successful!",
          backgroundColor: AppStyles.success,
          colorText: AppStyles.backGroundColor,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
        goToHome(context);
      } else {
        Get.snackbar(
          "Error",
          "Signup failed. Please try again.",
          backgroundColor: AppStyles.error,
          colorText: AppStyles.backGroundColor,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
      }
    } else {
      if (!_isEmailValid) {
        Get.snackbar(
          "Invalid Email",
          "Please use a valid email ending with @gmail.com.",
          backgroundColor: AppStyles.error,
          colorText: AppStyles.backGroundColor,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
      } else if (!_isPasswordValid) {
        Get.snackbar(
          "Invalid Password",
          "Password must be at least 6 characters.",
          backgroundColor: AppStyles.error,
          colorText: AppStyles.backGroundColor,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
      }
    }
  }
}