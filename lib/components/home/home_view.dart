import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_nieve/components/home/home_controller.dart';
import 'package:test_nieve/utils/utility.dart';
import 'package:test_nieve/widget/button.dart';
import 'package:test_nieve/widget/card_custom.dart';
import 'package:test_nieve/widget/main_scaffold.dart';
import 'package:test_nieve/widget/text_label.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controller = Get.put(HomeController());

  @override
  void initState() {
    controller.getDataUser();
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
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 15,
                child: Center(
                    child: TextLabel(
                  text: "Data Pengguna",
                  weigh: FontWeight.bold,
                  size: Utility.large,
                  decoration: TextDecoration.underline,
                )),
              ),
              Expanded(
                flex: 80,
                child: ListView.builder(
                    itemCount: controller.dataUser.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var nama = controller.dataUser[index].nama;
                      var email = controller.dataUser[index].email;
                      var nohp = controller.dataUser[index].nohp;
                      return Column(
                        children: [
                          CardCustom(
                            colorBg: Utility.baseColor2,
                            radiusBorder: Utility.borderStyle1,
                            colorBorder: Utility.baseColor1,
                            widgetCardCustom: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 80,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextLabel(
                                            text: nama,
                                            weigh: FontWeight.bold,
                                          ),
                                          const SizedBox(
                                            height: 3.0,
                                          ),
                                          TextLabel(
                                            text: email,
                                            weigh: FontWeight.bold,
                                          ),
                                          const SizedBox(
                                            height: 3.0,
                                          ),
                                          TextLabel(
                                            text: nohp,
                                            weigh: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 20,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                controller.nama.value.text =
                                                    nama!;
                                                controller.email.value.text =
                                                    email!;
                                                controller.emailBeforeEdit.value
                                                    .text = email;
                                                controller.nohp.value.text =
                                                    nohp!;
                                                controller.addEditUser(
                                                    status: true);
                                              });
                                            },
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.green,
                                              size: Utility.extraLarge,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          InkWell(
                                            onTap: () =>
                                                controller.deleteData(email),
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: Utility.extraLarge,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          )
                        ],
                      );
                    }),
              ),
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 3.0),
                            child: Button1(
                              textBtn: "Add User",
                              colorBtn: Utility.primaryDefault,
                              colorText: Utility.baseColor2,
                              onTap: () =>
                                  controller.addEditUser(status: false),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Button1(
                              textBtn: "Keluar",
                              colorBtn: Colors.red,
                              colorText: Utility.baseColor2,
                              onTap: () => controller.logout(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
