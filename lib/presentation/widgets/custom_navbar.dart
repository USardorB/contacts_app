import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNavbar extends StatelessWidget {
  final String iconPath;
  final int index;
  final int selectedIndex;

  const CustomNavbar(
      {super.key,
      required this.iconPath,
      required this.index,
      required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIndex == index;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color:
            isSelected ? Colors.deepPurpleAccent.shade100 : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        iconPath,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          isSelected ? Colors.white : Colors.black,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
