import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String imagePath;
  final String text;
  const MyButton({super.key, required this.onTap, required this.imagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE2DDFF),
                ),
                height: 60,
                width: 60,
                child: SvgPicture.asset(
                  imagePath,
                ),
              ),
            ),
          ],
        ),
        Text(text),
      ],
    );
  }
}
