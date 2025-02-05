import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;

  const MyButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    required this.fontSize,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 98, // Tentukan lebar sesuai dengan yang diinginkan
      height: 27, // Tentukan tinggi sesuai dengan yang diinginkan
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10), // Sesuaikan padding
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color, // Gunakan warna yang diinginkan (misalnya Color(0xFFFF6F61))
        borderRadius: BorderRadius.circular(8), // Sesuaikan radius jika diperlukan
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 9, // Menyesuaikan tinggi teks
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 6, // Menggunakan fontSize yang diberikan
                    fontFamily: 'Montserrat', // Font yang diinginkan
                    fontWeight: fontWeight, // Font weight yang diberikan
                    height: 1, // Mengatur jarak antar baris teks
                    letterSpacing: 1.50, // Menambahkan jarak antar huruf
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
