import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:roomeasy/api/constant/constant.dart';
import 'package:roomeasy/api/services/base/baseModel.dart';
import 'package:roomeasy/form/login/login.dart';
import 'package:roomeasy/form/register/register.dart';
import 'package:roomeasy/form/user/user_change_avatar.dart';
import 'package:roomeasy/form/user/user_change_password.dart';
import 'package:roomeasy/form/user/user_update.dart';
import 'package:roomeasy/model/auth/profile.dart';
import 'package:roomeasy/model/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices extends BaseService {
  static AuthProfileModel? user;

  AuthProfileModel? getCurrentUserState() {
    return user;
  }

  Future<ResponseModel<String>> login(
      {required LoginFormModel formData}) async {
    try {
      final uri = Uri.http(Apiconstants.getBaseURL(),
          '${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/login');
      final res = await post(uri: uri, body: formData.toMap());
      if (!res.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${uri.toString()} code:${res.code} message:${res.message}");
      }

      String token = res.data != null ? res.data!['token'] : '';

      var instance = await SharedPreferences.getInstance();
      instance.setString(Apiconstants.authToken, token);

      return ResponseModel<String>(
          code: res.code, message: res.message, data: token);
    } catch (e) {
      return ResponseModel<String>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<String>> register(
      {required RegisterFormModel formData}) async {
    try {
      final uri = Uri.http(Apiconstants.getBaseURL(),
          '${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/register');

      final res = await post(uri: uri, body: formData.toMap());
      if (!res.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${uri.toString()} code:${res.code} message:${res.message}");
      }

      String token = res.data != null ? res.data!['token'] : '';

      var instance = await SharedPreferences.getInstance();
      instance.setString(Apiconstants.authToken, token);

      return ResponseModel<String>(
          code: res.code, message: res.message, data: token);
    } catch (e) {
      return ResponseModel<String>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<AuthProfileModel>> getMe() async {
    try {
      final uri = Uri.http(Apiconstants.getBaseURL(),
          "${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/me");

      var response = await get(uri: uri);
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${uri.toString()} code:${response.code} message:${response.message}");
      }

      if (response.data != null) {
        user = AuthProfileModel.fromMap(response.data!);
      }

      return ResponseModel<AuthProfileModel>(
        code: response.code,
        message: response.message,
        data: response.data != null
            ? AuthProfileModel.fromMap(response.data!)
            : null,
      );
    } catch (e) {
      debugPrint("Error in api.service.auth.getMe: ${e.toString()}");
      return ResponseModel<AuthProfileModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel<AuthProfileModel>> getUserProfile(
      {required String userId}) async {
    try {
      final uri = Uri.http(
          Apiconstants.getBaseURL(),
          "${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/profile",
          {"userId": userId});

      var response = await get(uri: uri);
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${uri.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel<AuthProfileModel>(
        code: response.code,
        message: response.message,
        data: response.data != null
            ? AuthProfileModel.fromMap(response.data!)
            : null,
      );
    } catch (e) {
      debugPrint("Error in api.service.auth.getUserProfile: ${e.toString()}");
      return ResponseModel<AuthProfileModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel> updateProfile(UserUpdateFormModel formdata) async {
    try {
      final url = Uri.http(Apiconstants.getBaseURL(),
          "${Apiconstants.apiVersion}${Apiconstants.userEndpoint}");

      var response = await put(uri: url, body: formdata.toMap());
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel(
          code: response.code, message: response.message, data: null);
    } catch (e) {
      debugPrint("Error in api.service.auth.updateProfile: ${e.toString()}");
      return ResponseModel<AuthProfileModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel> updateAvatar(UserChangeAvatarFormModel formdata) async {
    try {
      final url = Uri.http(Apiconstants.getBaseURL(),
          "${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/avatar");

      var response = await patch(uri: url, body: formdata.toMap());
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel(
          code: response.code, message: response.message, data: null);
    } catch (e) {
      debugPrint("Error in api.service.auth.updateAvatar: ${e.toString()}");
      return ResponseModel<AuthProfileModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<ResponseModel> changePassword(
      UserChangePassWordFormModel formdata) async {
    try {
      final url = Uri.http(Apiconstants.getBaseURL(),
          "${Apiconstants.apiVersion}${Apiconstants.userEndpoint}/password");

      var response = await patch(uri: url, body: formdata.toMap());
      if (!response.code.toString().startsWith('2')) {
        debugPrint(
            "[APIService] ${url.toString()} code:${response.code} message:${response.message}");
      }

      return ResponseModel(
          code: response.code, message: response.message, data: null);
    } catch (e) {
      debugPrint("Error in api.service.auth.changePassword: ${e.toString()}");
      return ResponseModel<AuthProfileModel>(
        code: 500,
        message: e.toString(),
        data: null,
      );
    }
  }
}
