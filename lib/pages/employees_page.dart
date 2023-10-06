import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_admin/providers/employees/employees_cubit.dart';
import 'package:maintenance_admin/providers/employees/employees_state.dart';
import 'package:maintenance_admin/services/colors.dart';
import 'package:intl/intl.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({Key? key}) : super(key: key);

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.mainThemeColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            DateFormat('d MMMM y').format(DateTime.now()),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 23),
          ),
          SizedBox(
            height: screenHeight * 0.01 + 2,
          ),
          Container(
            width: screenWidth,
            height: screenHeight * 0.9,
            decoration: const BoxDecoration(
              color: Colors.white, // Set box color to white
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                // Add rounded corners to the top left
                topRight:
                Radius.circular(20), // Add rounded corners to the top right
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Column(
              children: [
                // Padding(
                //   padding:
                //       EdgeInsets.only(left: 16.0, top: screenHeight * 0.03 + 8,bottom: 8),
                //   child: const Align(
                //       alignment: Alignment.bottomLeft,
                //       child: Text(
                //         "Assigned Jobs",
                //         style: TextStyle(
                //             fontSize: 19, fontWeight: FontWeight.w600),
                //       )),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0,bottom: 10),
                  child: TapRegion(
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    child: TextField(
                      style: TextStyle(
                          fontSize: 20.0,
                          // height: 0.0,
                          color: Colors.black
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: editingController,
                      decoration: const InputDecoration(
                        // labelText: "Assigned Jobs",
                        // labelStyle:
                        //     TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                        hintText: "Employees",
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                BlocConsumer<EmployeesCubit, EmployeesState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is EmployeesLoadingState) {
                        BlocProvider.of<EmployeesCubit>(context)
                            .getEmp();
                        return Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: ColorConstants.mainThemeColor,
                            ),
                          ),
                        );
                      }
                      if (state is EmployeesLoadedState) {
                        return Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: state.response.length,
                              itemBuilder: (BuildContext context, int index) {
                             if (editingController
                                    .text.isEmpty) {

                                  return Container(
                                    margin: const EdgeInsets.only(
                                        left: 16, right: 16, bottom: 16),
                                    // height: 125,
                                    decoration: BoxDecoration(
                                      //   boxShadow:  [
                                      //   BoxShadow(
                                      //     color:
                                      //     ColorConstants.lightThemeColor,
                                      //     spreadRadius: 1,
                                      //     blurRadius: 10,
                                      //     offset: Offset(
                                      //         0,
                                      //         0))
                                      // ],
                                      color: ColorConstants.lightThemeColor,
                                      // Set box color to white
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(16),
                                        // Add rounded corners to the top left
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.only(bottom: 3.0),
                                          child: Text("Name: ${state.response[index].name!}",style: TextStyle(fontSize: 20,),),
                                        ),
                                        subtitle: Text("Phone no: ${state.response[index].phone!}\nEmail: ${state.response[index].email!}",style: TextStyle(fontSize: 15,)),
                                      ),
                                    ),
                                  );
                                }else if(state.response[index].name!.toLowerCase().contains(editingController.text)||state.response[index].phone!.contains(editingController.text)){
                               return Container(
                                 margin: const EdgeInsets.only(
                                     left: 16, right: 16, bottom: 16),
                                 // height: 125,
                                 decoration: BoxDecoration(
                                   //   boxShadow:  [
                                   //   BoxShadow(
                                   //     color:
                                   //     ColorConstants.lightThemeColor,
                                   //     spreadRadius: 1,
                                   //     blurRadius: 10,
                                   //     offset: Offset(
                                   //         0,
                                   //         0))
                                   // ],
                                   color: ColorConstants.lightThemeColor,
                                   // Set box color to white
                                   borderRadius: const BorderRadius.all(
                                     Radius.circular(16),
                                     // Add rounded corners to the top left
                                   ),
                                 ),
                                 child: Padding(
                                   padding: const EdgeInsets.all(16.0),
                                   child: ListTile(
                                     title: Padding(
                                       padding: const EdgeInsets.only(bottom: 3.0),
                                       child: Text("Name: ${state.response[index].name!}",style: TextStyle(fontSize: 20,),),
                                     ),
                                     subtitle: Text("Phone no: ${state.response[index].phone!}\nEmail: ${state.response[index].email!}",style: TextStyle(fontSize: 15,)),
                                   ),
                                 ),
                               );
                                }else{
                                  return Container();
                                }
                              }),
                        );
                      }
                      return Container();
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
