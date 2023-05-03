import 'dart:convert';

import 'package:test_nieve/utils/local_storage.dart';

class AppData {
  // SET

  // BOOL

  // static set statusAbsensi(bool value) =>
  //     LocalStorage.saveToDisk('statusAbsensi', value);

  // STRING

  static set uuid(String value) => LocalStorage.saveToDisk('uuid', value);

  static set email(String value) => LocalStorage.saveToDisk('email', value);

  // LIST

  // static set informasiLogin(List<LoginModel>? value) {
  //   if (value != null) {
  //     List<String> listString = value.map((e) => e.toJson()).toList();
  //     LocalStorage.saveToDisk('informasiLogin', listString);
  //   } else {
  //     LocalStorage.saveToDisk('informasiLogin', null);
  //   }
  // }

  // // GET

  // BOOL

  // static bool get statusAbsensi {
  //   if (LocalStorage.getFromDisk('statusAbsensi') != null) {
  //     return LocalStorage.getFromDisk('statusAbsensi');
  //   }
  //   return false;
  // }

  // STRING

  static String get uuid {
    if (LocalStorage.getFromDisk('uuid') != null) {
      return LocalStorage.getFromDisk('uuid');
    }
    return "";
  }

  static String get email {
    if (LocalStorage.getFromDisk('email') != null) {
      return LocalStorage.getFromDisk('email');
    }
    return "";
  }

  // LIST

  // static List<LoginModel>? get informasiLogin {
  //   if (LocalStorage.getFromDisk('informasiLogin') != null) {
  //     List<String> listData = LocalStorage.getFromDisk('informasiLogin');
  //     return listData.map((e) => LoginModel.fromMap(jsonDecode(e))).toList();
  //   }
  //   return null;
  // }

  // CLEAR ALL DATA

  static void clearAllData() =>
      LocalStorage.removeFromDisk(null, clearAll: true);
}
