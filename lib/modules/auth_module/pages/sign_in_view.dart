import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:glok/modules/auth_module/controller.dart';
import 'package:glok/utils/helpers.dart';
import 'package:glok/utils/meta_assets.dart';

class SignInView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(bottom: 25),
                    child: Image.asset(
                      MetaAssets.logoPurple,
                      height: 70,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(bottom: 55),
                    child: Text(
                      "Log in to continue connecting with your favorite celebrities.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Log In or Sign Up",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF737373),
                          ),
                        ),
                      ),
                      Expanded(child: Divider())
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 33),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          "Mobile Number",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                      ),
                      TextFormField(
                        controller: controller.numberController,
                        validator: (value) {
                          if (value!.trim().length != 10) {
                            return "Enter a valid mobile number";
                          }
                          return null;
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        decoration: formDecoration(
                            "Mobile Number", "Enter Mobile Number"),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),
                SliverToBoxAdapter(
                    child: CustomButton(
                  onPressed: () {
                    controller.handleLoginOTP();
                  },
                  title: "Continue",
                )),
              ],
            ),
          ),
        ));
  }
}
