import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final double height;
  final double borderRadius;
  final double? width;
  final double? borderWidth;
  final Color backgroundColor;
  final Color? borderColor;
  final Widget body;
  final void Function() onPressed;

  const ButtonWidget(
      {super.key,
      required this.height,
      required this.borderRadius,
      this.width,
      this.borderWidth,
      this.borderColor,
      required this.backgroundColor,
      required this.body,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: borderColor == null || borderWidth == null
                  ? BorderSide.none
                  : BorderSide(
                      color: borderColor!,
                      width: borderWidth!,
                    ),
            ),
            minimumSize: Size.zero, // This removes the padding
            padding: EdgeInsets.symmetric(horizontal: 5),
          ),
          onPressed: () => onPressed(),
          child: body),
    );
  }
}
