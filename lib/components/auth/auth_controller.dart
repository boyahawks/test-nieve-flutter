import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:test_nieve/components/home/home_view.dart';
import 'package:test_nieve/utils/app_data.dart';
import 'package:test_nieve/utils/toast.dart';
import './auth.dart';

class AuthController extends GetxController {
  var email = TextEditingController().obs;
  var password = TextEditingController().obs;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  var screenAuth = false.obs;

  var showPassword = false.obs;

  void authAction() async {
    if (!screenAuth.value) {
      UtilsAlert.loadingSimpanData(Get.context!, "Sedang memuat...");
      try {
        var credential = await _firebaseAuth.signInWithEmailAndPassword(
            email: email.value.text, password: password.value.text);
        var uuid = credential.user!.uid;
        if (uuid != "") {
          AppData.email = email.value.text;
          AppData.uuid = uuid;
          Get.back();
          UtilsAlert.showToast("Selamat Datang");
          Get.offAll(Home());
        }
      } on FirebaseAuthException catch (e) {
        print(e);
        UtilsAlert.showToast("Kombinasi Email dan Password salah !");
        Get.back();
      }
    } else {
      UtilsAlert.loadingSimpanData(Get.context!, "Sedang memuat...");
      try {
        var userCredential = await _firebaseAuth
          ..createUserWithEmailAndPassword(
              email: email.value.text, password: password.value.text);
        var uuidUser = userCredential.currentUser!.uid;
        var emailUser = userCredential.currentUser!.email;
        if (uuidUser != "" && emailUser != "") {
          Get.back();
          UtilsAlert.showToast("Akun berhasil registrasi");
          screenAuth.value = false;
          screenAuth.refresh();
        }
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    }
  }
}
