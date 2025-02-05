import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final bool isObsecure;
  final TextEditingController? controller;
  final String? Function(String?)? validator; // Validator function

  const MyTextField({
    super.key,
    required this.hintText,
    required this.isObsecure,
    this.controller,
    this.validator,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight( // Biar tinggi otomatis menyesuaikan isi
      child: Container(
        width: 300, 
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(6.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0), // Padding lebih kecil
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Biar nggak makan banyak ruang
          children: [
            TextField(
              controller: widget.controller,
              onChanged: (value) {
                if (widget.validator != null) {
                  setState(() {
                    errorText = widget.validator!(value);
                  });
                }
              },
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12,
                  color: Colors.white,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 6.0, // Lebih kecil
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: errorText == null
                        ? const Color.fromARGB(255, 87, 159, 89)
                        : const Color.fromARGB(255, 192, 82, 75),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: errorText == null ? const Color.fromARGB(0, 0, 0, 0) : Colors.red,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                color: Colors.white,
              ),
              obscureText: widget.isObsecure,
            ),

            if (errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  errorText!,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.red,
                    fontSize: 10,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
