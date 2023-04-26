import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maintenance_admin/services/shared_service.dart';
import '../../config.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/otp_request_model.dart';
import '../models/otp_response_model.dart';
import '../models/non_assigned_response_model.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model,) async {
    // try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };

      var url = Uri.http(
        Config.apiURL,
        Config.loginAPI,
      );

      var response = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(model.toJson()),
      );

      print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
      print(response.statusCode);

      if (response.statusCode == 201) {
        await SharedService.setLoginDetails(
          loginResponseJson(
            response.body,
          ),
        );

        return true;
      } else {
        return false;
      }
    // }catch(e){
    //   print("banana\n\n\n");
    //   print(e);
    //   return false;
    // }

  }

  static Future<bool> otp(OtpRequestModel model,) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.otpAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 201) {
      await SharedService.setTokenDetails(
        otpResponseJson(
          response.body,
        ),
      );

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> getNonAssignedJobs() async {

    var tokenDetails = await SharedService.otpDetails();
    String? token = tokenDetails?.accessToken;
    print("--------------------------------------------------------------------------------");
    print(token);
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
//; charset=UTF-8
    var url = Uri.http(
      Config.apiURL,
      Config.nonAssignedJobAPI,
    );

    // var response = await client.post(
    //   url,
    //   headers: requestHeaders,
    //   body: jsonEncode(model.toJson()),
    // );

   var response = await http.get(url,headers: requestHeaders);
   print(response.body);
    print(response.statusCode);
    // print(response.body);


    if (response.statusCode == 200) {
      await SharedService.setStudent(
        nonAssignedJobs(
          response.body,
        ),
      );

      return true;
    } else {
      return false;
    }
  }



  // static Future<bool> newJob(NewCleaningRequestModel model,) async {
  //   var tokenDetails = await SharedService.otpDetails();
  //   String? token = tokenDetails?.accessToken;
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //
  //   var url = Uri.http(
  //     Config.apiURL,
  //     Config.newJobAPI,
  //   );
  //
  //   var response = await client.post(
  //     url,
  //     headers: requestHeaders,
  //     body: jsonEncode(model.toJson()),
  //   );
  //
  //   if (response.statusCode == 201) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }


}