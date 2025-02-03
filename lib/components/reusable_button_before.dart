import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String imagePath;
  final double textSize;

  const ReusableButton({
    required this.text,
    required this.onPressed,
    required this.imagePath,
    this.textSize = 16.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
          minimumSize: Size(double.infinity, 70), // Make height 70
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 30,
              width: 30,
            ),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: textSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'WorkSans',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
