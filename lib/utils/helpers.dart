import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:glok/utils/meta_colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.loading = false});

  final String title;
  void Function()? onPressed;
  bool? loading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading! ? null : onPressed,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(80)),
        child: Center(
          child: loading!
              ? const CircularProgressIndicator()
              : Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
        ),
      ),
    );
  }
}

class CustomButtonWithChild extends StatelessWidget {
  CustomButtonWithChild(
      {super.key,
      required this.child,
      required this.onPressed,
      this.loading = false});

  final Widget child;
  void Function()? onPressed;
  bool? loading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading! ? null : onPressed,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(80)),
        child: Center(
          child: loading! ? const CircularProgressIndicator() : child,
        ),
      ),
    );
  }
}

InputDecoration formDecoration(String label, String hintText) {
  return InputDecoration(
    hintText: hintText,
    labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
    // labelText: label,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Get.theme.dividerColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Get.theme.dividerColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Get.theme.primaryColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.red),
    ),
    errorStyle: TextStyle(color: Colors.red),
  );
}

InputDecoration searchFormDecoration(String label, String hintText,
    {Widget? prefix, bool isLight = false}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: Get.theme.dividerColor),
    prefixIcon: Padding(
      padding: const EdgeInsets.all(3.0).copyWith(left: 12),
      child: prefix,
    ),
    contentPadding: EdgeInsets.zero,

    prefixIconConstraints: BoxConstraints.tight(Size(32, 32)),
    labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
    // labelText: label,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(80),
      borderSide: BorderSide(color: Get.theme.dividerColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(80),
      borderSide: BorderSide(color: Get.theme.dividerColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(80),
      borderSide: BorderSide(
          color: isLight ? Get.theme.primaryColor : Get.theme.dividerColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(80),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(80),
      borderSide: BorderSide(color: Colors.red),
    ),
    errorStyle: TextStyle(color: Colors.red),
  );
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 9, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = MetaColors.dividerColor
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
