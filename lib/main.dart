import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glok/controllers/hive_controller.dart';
import 'package:glok/modules/auth_module/binding.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/modules/auth_module/view.dart';
import 'package:glok/utils/meta_assets.dart';
import 'package:glok/utils/meta_colors.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme().apply(
            bodyColor: MetaColors.primaryText,
            displayColor: MetaColors.primaryText),
        primaryColor: MetaColors.primary,
        dividerColor: MetaColors.dividerColor,
        secondaryHeaderColor: MetaColors.secondaryText,
        primaryTextTheme: GoogleFonts.poppinsTextTheme().apply(
            bodyColor: MetaColors.primaryText,
            displayColor: MetaColors.primaryText),
        primarySwatch: createMaterialColor(MetaColors.primary),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool splash = true;
  @override
  void initState() {
    super.initState();
    Get.put(HiveController());
    AuthBinding().dependencies();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        splash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return splash
        ? Scaffold(
            body: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: BoxDecoration(
            
                gradient: LinearGradient(colors: [
              Get.theme.primaryColor,
              Get.theme.primaryColor.withOpacity(0.9)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(MetaAssets.splashOverlay),
                Center(child: SvgPicture.asset(MetaAssets.logoWhite))
              ],
            ),
          ))
        : AuthView();
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
