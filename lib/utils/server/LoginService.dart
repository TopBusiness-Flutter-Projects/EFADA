// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dio/dio.dart' as DIO;
import 'package:get/get.dart';
import 'package:efada/controller/system_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:efada/utils/FunctinsData.dart';
import 'package:efada/utils/apis/Apis.dart';
import 'package:efada/utils/exception/DioException.dart';

class Login {
  final String email;
  final String password;

  Login(this.email, this.password);

  Future<String> getLogin(BuildContext context) async {
    bool isSuccess = false;
    dynamic id;
    dynamic rule;
    dynamic schoolId;
    String image;
    dynamic isAdministrator;
    dynamic zoom;
    dynamic token;
    dynamic studentId;
    dynamic message;
    dynamic fullName;
    dynamic phone;

    bool isNullOrEmpty(Object o) => o == null || o == "";

    try {
      DIO.Dio dio = DIO.Dio();
      DIO.Response response =
          await dio.get(InfixApi.login(email, password)).catchError((e) {
        message = DioExceptions.fromDioError(e).toString();
        print('DIO ERROR: $message');
      });
      if (response.statusCode == 200) {
         print(response.data);
        var user = response.data;
        isSuccess = user['success'];
        message = user['message'];
        id = user['data']['user']['id'];
        rule = user['data']['user']['role_id'];
        schoolId = user['data']['user']['school_id'];
        isAdministrator = user['data']['user']['is_administrator'];
        token = user['data']['accessToken'];
        fullName = user['data']['user']['full_name'] ?? "";
        phone = user['data']['user']['phone_number'] ?? "";
        print("DADADADA${rule}");


        if (rule == 2 || rule == "2") {
          studentId = user['data']['userDetails']['id'];
          print("Student => $studentId");
        }

        zoom = "0";

        if (rule == 1 || rule == 4 || rule == 5) {
          image = isNullOrEmpty(user['data']['userDetails']['staff_photo'])
              ? 'public/uploads/staff/demo/staff.jpg'
              : user['data']['userDetails']['staff_photo'].toString();
        } else if (rule == 2) {
          image = isNullOrEmpty(user['data']['userDetails']['student_photo'])
              ? 'public/uploads/staff/demo/staff.jpg'
              : user['data']['userDetails']['student_photo'].toString();
        } else if (rule == 3) {
          image = isNullOrEmpty(user['data']['userDetails']['guardian_photo'])
              ? 'public/uploads/staff/demo/staff.jpg'
              : user['data']['userDetails']['guardian_photo'].toString();
        }
        if (isSuccess) {

          saveBooleanValue('isLogged', isSuccess);
          saveStringValue('email', email);
          saveStringValue('phone', phone);
          saveStringValue('full_name', fullName);
          saveStringValue('password', password);
          saveStringValue('id', '$id');
          saveStringValue('rule', '$rule');
          saveStringValue('schoolId', '$schoolId');
          saveStringValue('image', '$image');
          saveStringValue('isAdministrator', '$isAdministrator');
          saveStringValue('lang', 'en');
          saveStringValue('token', token.toString());
          saveStringValue('zoom', zoom.toString());
          if (rule == 2 || rule == "2") {
            saveIntValue('studentId', int.parse(studentId.toString()));
          }

          print('Statusxzczxczxcz');

          final SystemController _systemController =
              Get.put(SystemController());
          await _systemController.getSystemSettings();
          print("Sdfsd");
          AppFunction.getFunctions(context, rule.toString(), zoom.toString());
        }
        return message;
      }
    } catch (e) {
      print(e);
      print(message);
    }
    return message;
  }

  Future<bool> saveBooleanValue(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(key, value);
  }

  Future<bool> saveStringValue(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(key, value);
  }

  Future<bool> saveIntValue(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(key, value);
  }
}
