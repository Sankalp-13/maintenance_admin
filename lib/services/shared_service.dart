import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:maintenance_admin/models/non_assigned_response_model.dart';


import '../models/login_response_model.dart';
import '../models/otp_response_model.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var isCacheKeyExist =
    await APICacheManager().isAPICacheKeyExist("login_id");

    return isCacheKeyExist;
  }

  static Future<LoginResponseModel?> loginDetails() async {
    var isCacheKeyExist =
    await APICacheManager().isAPICacheKeyExist("login_id");

    if (isCacheKeyExist) {
      var cacheData = await APICacheManager().getCacheData("login_id");

      return loginResponseJson(cacheData.syncData);
    }
    return null;
  }

  static Future<void> setLoginDetails(
      LoginResponseModel loginResponse,
      ) async {
    APICacheDBModel cacheModel = APICacheDBModel(
      key: "login_id",
      syncData: jsonEncode(loginResponse.toJson()),
    );

    await APICacheManager().addCacheData(cacheModel);
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("login_id");
    await APICacheManager().deleteCache("otp_tokens");
    await APICacheManager().deleteCache("student_data");
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
          (route) => false,
    );
  }




  static Future<void> setTokenDetails(OtpResponseModel otpResponseModel) async{
    APICacheDBModel cacheModel = APICacheDBModel(
      key: "otp_tokens",
      syncData: jsonEncode(otpResponseModel.toJson()),
    );

    await APICacheManager().addCacheData(cacheModel);
    await APICacheManager().deleteCache("login_id");

  }

  static Future<OtpResponseModel?> otpDetails() async {
    var isCacheKeyExist =
    await APICacheManager().isAPICacheKeyExist("otp_tokens");

    if (isCacheKeyExist) {
      var cacheData = await APICacheManager().getCacheData("otp_tokens");

      return otpResponseJson(cacheData.syncData);
    }
    return null;
  }

  static Future<bool> hasOtpTokens() async {
    var isCacheKeyExist =
    await APICacheManager().isAPICacheKeyExist("otp_tokens");

    return isCacheKeyExist;
  }



  //
  static Future<void> setStudent(List<NonAssignedJobs>  nonAssignedJobs) async{
    APICacheDBModel cacheModel = APICacheDBModel(
      key: "non_assigned_job",
      syncData: json.encode(nonAssignedJobs.map((nonAssignedJob) => nonAssignedJob.toJson()).toList()),
    );
    await APICacheManager().addCacheData(cacheModel);

  }
  //
  // static Future<bool> hasStudentData() async {
  //   var isCacheKeyExist =
  //   await APICacheManager().isAPICacheKeyExist("student_data");
  //
  //   return isCacheKeyExist;
  // }
  //
  static Future<List<NonAssignedJobs> ?> nonAssignedJobDetails() async {
    var isCacheKeyExist =
    await APICacheManager().isAPICacheKeyExist("non_assigned_job");

    if (isCacheKeyExist) {
      var cacheData = await APICacheManager().getCacheData("non_assigned_job");

      return nonAssignedJobs(cacheData.syncData);
    }
    return null;
  }

}