import 'package:flutter/material.dart ';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../config.dart';
import '../models/non_assigned_response_model.dart';
import '../services/api_service.dart';
import '../services/shared_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isApiCallProcess = false;
  String adminName = "ADMIN";
  List<NonAssignedJobs>? nonAssignedJobDetail;
  int itemCount = 0;

  // var student;
  // late StudentResponseModel studentResponseModel;
  void setHome() {
    setState(() {
      isApiCallProcess = true;
    });

    APIService.getNonAssignedJobs().then(
      (response) {
        setState(() {
          stud().then((value) =>
              isApiCallProcess = false); //remove then if doesn't work
        });

        if (response) {
        } else {
          FormHelper.showSimpleAlertDialog(
            context,
            Config.appName,
            "Something went wrong:(",
            "OK",
            () {
              Navigator.of(context).pop();
            },
          );
        }
      },
    );
  }

  @override
  void initState() {
    setHome();
  }

  Future<void> stud() async {
    nonAssignedJobDetail = await SharedService.nonAssignedJobDetails();
    // setState(() {
    //   studentName = studentDetails?.name as String;
    // });
  }

  @override
  Widget build(BuildContext context) {
    //POPULATING LIST
    setState(() {
      stud().then(
          (value) => isApiCallProcess = false); //remove then if doesn't work
    });

    itemCount = nonAssignedJobDetail != null ? nonAssignedJobDetail!.length : 0;

    print("--------------------------------------");
    print(itemCount);

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#283B71"),
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 30, bottom: 5, top: 50),
                child: Text(
                  'Hey',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, bottom: 30, top: 5),
                child: Text(
                  adminName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, bottom: 15, top: 100),
                child: Text(
                  'Unassigned Jobs: ',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 450,
                width: double.infinity,
                child: itemCount > 0
                    ? Scrollbar(
                        child: ListView.separated(
                          padding: const EdgeInsets.only(left: 10),
                          itemCount: itemCount,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 50,
                              child: Center(
                                child: Row(
                                  children: <Widget>[
                                    const SizedBox(
                                      width: 1,
                                    ),
                                    Text(
                                      'ID: ${nonAssignedJobDetail![index].id}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Date : ${nonAssignedJobDetail![index].time!.substring(0, nonAssignedJobDetail![index].time!.length - 14)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        ),
                      )
                    : Center(
                        child: Container(
                          alignment: const Alignment(0.0, -1.0),
                          child: const Text(
                            "No Items",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
