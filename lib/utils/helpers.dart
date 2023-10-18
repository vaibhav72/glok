import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

List<String> pageTitleList = ["Movie Star", "TV Star", "Singer", "Influencer"];

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
      this.color,
      required this.onPressed,
      this.loading = false});
  Color? color;
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
            color: color ?? Theme.of(context).primaryColor,
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

showSnackBar({required String message, String? title, bool isError = true}) {
  Get.snackbar(title ?? '', message,
      backgroundColor: isError ? Colors.red : Colors.green);
}

Future<ImageSource?> showImageSourceSelector() async {
  ImageSource? value = await Get.bottomSheet<ImageSource>(
    Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Camera'),
            onTap: () {
              Get.back(result: ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Gallery'),
            onTap: () {
              Get.back(result: ImageSource.gallery);
            },
          ),
        ],
      ),
    ),
    backgroundColor: Colors.transparent,
  );
  return value;
}

Future<bool?> selectVideoOrPhoto() async {
  bool? isVideo = await Get.bottomSheet<bool>(
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  height: 6,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Get.theme.dividerColor,
                      borderRadius: BorderRadius.circular(40)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Upload",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                // SizedBox(
                //   height: 16,
                // ),
                Divider(),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Get.back(result: false);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        MetaAssets.photosIcon,
                        // height: 28,
                        // width: 28,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "New Photo",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Get.back(result: true);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        MetaAssets.videoIcon,
                        // height: 28,
                        // width: 28,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "New Video",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
  return isVideo;
}

//email validator
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter email';
  }
  final RegExp nameExp = RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'); //r'^[A-Za-z ]+$'
  if (!nameExp.hasMatch(value)) {
    return 'Please enter valid email';
  }
  return null;
}

String getFileExtension(String filePath) {
  try {
    int index = filePath.lastIndexOf('.');
    return filePath.substring(index + 1);
  } catch (e) {
    return '';
  }
}

Text getPercentageDifference(double percentage) {
  return Text(
    "${percentage.isNegative ? "-" : "+"}${percentage.abs().toStringAsFixed(0)}% than last week",
    style: TextStyle(
        fontSize: 12, color: percentage.isNegative ? Colors.red : Colors.green),
  );
}

String getCurrency(double amount) {
  return NumberFormat.currency(
          locale: "en_IN", symbol: "\u20b9", decimalDigits: 0)
      .format(amount);
}
