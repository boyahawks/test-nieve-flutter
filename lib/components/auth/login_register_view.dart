import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_nieve/components/auth/auth_controller.dart';
import 'package:test_nieve/utils/utility.dart';
import 'package:test_nieve/widget/button.dart';
import 'package:test_nieve/widget/card_custom.dart';
import 'package:test_nieve/widget/main_scaffold.dart';
import 'package:test_nieve/widget/text_form_field_group.dart';
import 'package:test_nieve/widget/text_label.dart';

class LoginRegister extends StatefulWidget {
  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  var controller = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      type: "default",
      returnOnWillpop: true,
      backFunction: () {},
      content: Obx(
        () => Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: TextLabel(
                  text: !controller.screenAuth.value
                      ? "Login Account"
                      : "Register Account",
                  size: 30.0,
                  color: Utility.primaryDefault,
                  align: TextAlign.center,
                  weigh: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: Utility.large,
              ),
              CardCustom(
                colorBg: Utility.grey2,
                radiusBorder: Utility.borderStyle1,
                colorBorder: Utility.grey2,
                widgetCardCustom: SizedBox(
                  height: 60.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: TextLabel(
                            text: "Email",
                            weigh: FontWeight.bold,
                            color: Utility.grey1,
                          ),
                        ),
                        SizedBox(
                          height: Utility.verySmall,
                        ),
                        SizedBox(
                          height: 20,
                          child: TextFieldMain(
                            controller: controller.email.value,
                            statusCardCustom: false,
                            statusIconLeft: false,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Utility.medium,
              ),
              CardCustom(
                colorBg: Utility.grey2,
                radiusBorder: Utility.borderStyle1,
                colorBorder: Utility.grey2,
                widgetCardCustom: SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: TextLabel(
                            text: "Password",
                            weigh: FontWeight.bold,
                            color: Utility.grey1,
                          ),
                        ),
                        SizedBox(
                          height: Utility.verySmall,
                        ),
                        SizedBox(
                          height: 20,
                          child: TextFieldPassword(
                            controller: controller.password.value,
                            statusCardCustom: false,
                            obscureController: controller.showPassword.value,
                            onTap: () {
                              setState(() {
                                controller.showPassword.value =
                                    !controller.showPassword.value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Utility.large,
              ),
              Button1(
                colorBtn: Utility.primaryDefault,
                colorText: Utility.baseColor2,
                textBtn: !controller.screenAuth.value ? "Login" : "Register",
                style: 1,
                onTap: () => controller.authAction(),
              ),
              SizedBox(
                height: Utility.large,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    controller.screenAuth.value = !controller.screenAuth.value;
                  });
                },
                child: Center(
                  child: TextLabel(
                      text: !controller.screenAuth.value
                          ? "Don't have an account?"
                          : "Login Page"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
