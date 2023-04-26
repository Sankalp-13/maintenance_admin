import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../config.dart';
import '../models/otp_request_model.dart';
import '../services/api_service.dart';
import '../services/shared_service.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key );


  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? otp;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#283B71"),
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(
            key: globalFormKey,
            child: _otpUI(context),
          ),
        ),
      ),
    );
  }

  Widget _otpUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/img.png",
                    fit: BoxFit.contain,
                    width: 150,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Text(
              "OTP",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "OTP",
              "OTP",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'OTP can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                otp = onSavedVal,
              },
              initialValue: "",
              prefixIcon: const Icon(Icons.person),
              showPrefixIcon: true,
              obscureText: false,
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Submit",
              () async {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });

                  var loginDetails = await SharedService.loginDetails();

                  OtpRequestModel model = OtpRequestModel(
                    otpId: loginDetails?.otpId,
                    otp: int.parse(otp!),
                  );

                  APIService.otp(model).then(
                    (otpResponse) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (otpResponse) {
                        setState(() {
                          isApiCallProcess = true;
                        });
                        APIService.getNonAssignedJobs().then(
                              (response) {

                            if (response) {
                              setState(() {isApiCallProcess = false;});
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/home',
                                    (route) => false,
                                  );
                            } else {
                              FormHelper.showSimpleAlertDialog(
                                context,
                                Config.appName,
                                "Something went wrong:(",
                                "OK",
                                    () {
                                      setState(() {
                                        isApiCallProcess = true;
                                      });
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          },
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "Invalid OTP",
                          "OK",
                          () {Navigator.of(context).pop();},
                        );
                      }
                    },
                  );
                }
              },
              btnColor: HexColor("283B71"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

}
