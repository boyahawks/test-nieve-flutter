import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_nieve/components/auth/login_register_view.dart';
import 'package:test_nieve/components/global/buttom_sheet.dart';
import 'package:test_nieve/components/home/home_model.dart';
import 'package:test_nieve/utils/app_data.dart';
import 'package:test_nieve/utils/toast.dart';
import 'package:test_nieve/utils/utility.dart';
import 'package:test_nieve/widget/card_custom.dart';
import 'package:test_nieve/widget/text_form_field_group.dart';
import 'package:test_nieve/widget/text_label.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference usersRepo =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  var dataUser = <HomeModel>[].obs;

  var nama = TextEditingController().obs;
  var email = TextEditingController().obs;
  var emailBeforeEdit = TextEditingController().obs;
  var nohp = TextEditingController().obs;

  void startLoad() {
    getDataUser();
  }

  void getDataUser() async {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<HomeModel> tampungUser = [];
      for (var doc in querySnapshot.docs) {
        tampungUser.add(HomeModel(
          nama: doc["nama"],
          email: doc["email"],
          nohp: '${doc["nohp"]}',
        ));
      }
      dataUser.value = tampungUser;
      dataUser.refresh();
    });
  }

  void clearAll() {
    nama.value.text = "";
    email.value.text = "";
    nohp.value.text = "";
  }

  void addEditUser({required bool status}) {
    String judul = !status ? "Add User" : "Edit User";
    String textButton = !status ? "Add" : "Edit";
    ButtonSheetController().validasiButtonSheet(
        judul, addEditScreen(), "addEditUser", textButton, () async {
      UtilsAlert.loadingSimpanData(Get.context!, "Loading");
      if (!status) {
        if (nama.value.text != "" ||
            email.value.text != "" ||
            nohp.value.text != "") {
          usersRepo.add({
            'nama': nama.value.text,
            'email': email.value.text,
            'nohp': nohp.value.text
          }).then((value) {
            Get.back();
            Get.back();
            clearAll();
            UtilsAlert.showToast("Berhasil tambah data");
            getDataUser();
          }).catchError((error) {
            UtilsAlert.showToast(error);
          });
        } else {
          UtilsAlert.showToast("Harap lengkapi form terlebih dahulu");
        }
      } else {
        if (nama.value.text != "" ||
            email.value.text != "" ||
            nohp.value.text != "") {
          final getDataEmail = await usersRepo
              .where('email', isEqualTo: emailBeforeEdit.value.text)
              .get();
          if (getDataEmail.docs.isEmpty) {
            UtilsAlert.showToast("Email tidak tersedia");
            Get.back();
            Get.back();
          } else {
            final firstDocSnapshot = getDataEmail.docs.first;
            await firstDocSnapshot.reference.update({
              'email': email.value.text,
              'nama': nama.value.text,
              'nohp': nohp.value.text
            });
            Get.back();
            Get.back();
            clearAll();
            UtilsAlert.showToast("Berhasil edit data");
            getDataUser();
          }
        } else {
          UtilsAlert.showToast("Harap lengkapi form terlebih dahulu");
        }
      }
    });
  }

  Widget addEditScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                      text: "Nama",
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
                      controller: nama.value,
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
                      controller: email.value,
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
            height: 60.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: TextLabel(
                      text: "Nomor Hp",
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
                      controller: nohp.value,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: false),
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
      ],
    );
  }

  void deleteData(email) {
    ButtonSheetController().validasiButtonSheet(
        "Hapus Data",
        TextLabel(text: "Apakah kamu yakin hapus data $email"),
        "hapus_data",
        "Hapus", () async {
      UtilsAlert.loadingSimpanData(Get.context!, "Hapus data...");
      final getDataEmail =
          await usersRepo.where('email', isEqualTo: email).get();
      if (getDataEmail.docs.isEmpty) {
        UtilsAlert.showToast("Email tidak tersedia");
        Get.back();
        Get.back();
      } else {
        final firstDocSnapshot = getDataEmail.docs.first;
        await firstDocSnapshot.reference.delete();
        Get.back();
        Get.back();
        clearAll();
        UtilsAlert.showToast("Berhasil hapus data");
        getDataUser();
      }
    });
  }

  void logout() {
    ButtonSheetController().validasiButtonSheet(
        "Keluar",
        TextLabel(text: "Apakah kamu yakin keluar akun ?"),
        "logout",
        "Keluar", () async {
      await _firebaseAuth.signOut();
      AppData.email = "";
      AppData.uuid = "";
      Get.offAll(LoginRegister());
    });
  }
}
