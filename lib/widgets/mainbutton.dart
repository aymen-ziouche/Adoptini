import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool hasCircularBorder;

  const MainButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.hasCircularBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: hasCircularBorder ? BorderRadius.circular(20) : null,
      ),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
