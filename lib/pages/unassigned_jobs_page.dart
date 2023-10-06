import 'package:flutter/material.dart ';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:maintenance_admin/providers/unassigned_jobs/unassigned_jobs_cubit.dart';
import 'package:maintenance_admin/providers/unassigned_jobs/unassigned_jobs_states.dart';
import 'package:maintenance_admin/services/colors.dart';

class UnassignedJobsPage extends StatefulWidget {
  const UnassignedJobsPage({Key? key}) : super(key: key);

  @override
  State<UnassignedJobsPage> createState() => _UnassignedJobsPageState();
}

class _UnassignedJobsPageState extends State<UnassignedJobsPage> {
  bool itemSelected = false;
  int? selectedjob;
  int? selectedCleanerIndex;
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
            style: TextStyle(
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
                Padding(
                  padding:
                      EdgeInsets.only(left: 16.0, top: screenHeight * 0.03 + 8),
                  child: const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Unassigned Jobs",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w600),
                      )),
                ),
                BlocConsumer<UnassignedJobCubit, UnassignedJobState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is UnassignedJobLoadingState) {
                        BlocProvider.of<UnassignedJobCubit>(context)
                            .getUnassignedJobsAndCleaners();
                        return Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: ColorConstants.mainThemeColor,
                            ),
                          ),
                        );
                      }
                      if (state is UnassignedJobLoadedState) {
                        return Expanded(
                          child: Stack(
                            // fit: StackFit.expand,
                            // fit: StackFit.passthrough,
                            // clipBehavior: Clip.none,
                            children: [
                              ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: state.response.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin: const EdgeInsets.only(
                                          left: 16, right: 16, top: 16),
                                      height: 125,
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
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "Room No: ${state.response[index].room?.number}",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "Block Name: ${state.response[index].room?.block}",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            // SizedBox(height: screenHeight*0.005,),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    enableFeedback: true,
                                                    onTap: () {
                                                      selectedjob = index;
                                                      setState(() {
                                                        selectedCleanerIndex = state
                                                            .response[index]
                                                            .assignedCleanerIndex;
                                                        itemSelected = true;
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: ColorConstants
                                                            .lightWidgetAccent,
                                                        border: Border.all(
                                                            width: 0.5,
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(8),
                                                        ),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.black,
                                                            spreadRadius: 1,
                                                            blurRadius: 0,
                                                            offset: Offset(2,
                                                                2), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      height: 32,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                state.response[index].assignedCleanerIndex ==
                                                                        null
                                                                    ? "Assign to"
                                                                    : state
                                                                        .cleaners[state
                                                                            .response[index]
                                                                            .assignedCleanerIndex!]
                                                                        .name!,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  screenWidth *
                                                                      0.04,
                                                            ),
                                                            Transform.translate(
                                                                offset:
                                                                    const Offset(
                                                                        0, -1),
                                                                child: const Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down_rounded,
                                                                    size: 36))
                                                          ],
                                                        ),
                                                      ),
                                                      // width: screenWidth * 0.4,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.06,
                                                ),
                                                ConfirmButton(
                                                  selectionInt: state
                                                      .response[index]
                                                      .assignedCleanerIndex,
                                                  onPressed: () {
                                                    print(state
                                                        .response[index].id!);

                                                    BlocProvider.of<
                                                                UnassignedJobCubit>(
                                                            context)
                                                        .confirmAndRefreshUnassignedJobs(
                                                            state
                                                                .response[index]
                                                                .id!,
                                                            state
                                                                .cleaners[state
                                                                    .response[
                                                                        index]
                                                                    .assignedCleanerIndex!]
                                                                .id!);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: AnimatedContainer(
                                  // padding: const EdgeInsets.only(bottom: 40),
                                  margin: const EdgeInsets.only(
                                      left: 16, right: 16, top: 16),
                                  curve: Curves.fastOutSlowIn,
                                  alignment: Alignment.bottomCenter,
                                  duration: const Duration(milliseconds: 1500),
                                  height: itemSelected ? screenHeight : 0,
                                  decoration: BoxDecoration(
                                    color: ColorConstants.lightWidgetColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      TapRegion(
                                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                                        child: TextField(
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                          controller: editingController,
                                          decoration: InputDecoration(
                                              hintText: "Search",
                                              prefixIcon: Icon(
                                                Icons.search,
                                                color: Colors.black,
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 1),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(16.0))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 1),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(16.0)))),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount: state.cleaners.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              if (editingController
                                                  .text.isEmpty) {
                                                return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    unselectedWidgetColor:
                                                        Colors.black,
                                                  ),
                                                  child: ListTile(
                                                    trailing: Transform.scale(
                                                      scale: 1.5,
                                                      child: Radio(
                                                        activeColor:
                                                            ColorConstants
                                                                .mainThemeColor,
                                                        value: index,
                                                        groupValue:
                                                            selectedCleanerIndex,
                                                        onChanged: (ind) {
                                                          setState(() {
                                                            selectedCleanerIndex =
                                                                ind;
                                                            itemSelected =
                                                                false;
                                                          });
                                                          state
                                                                  .response[
                                                                      selectedjob!]
                                                                  .assignedCleanerIndex =
                                                              selectedCleanerIndex;
                                                          print(
                                                              selectedCleanerIndex);
                                                        },
                                                      ),
                                                    ),
                                                    title: Text(
                                                        state.cleaners[index]
                                                            .name!,
                                                        style: const TextStyle(
                                                            fontSize: 23,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                );
                                              }else if (state.cleaners[index].name!.toLowerCase().contains(editingController.text)){
                                                return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    unselectedWidgetColor:
                                                    Colors.black,
                                                  ),
                                                  child: ListTile(
                                                    trailing: Transform.scale(
                                                      scale: 1.5,
                                                      child: Radio(
                                                        activeColor:
                                                        ColorConstants
                                                            .mainThemeColor,
                                                        value: index,
                                                        groupValue:
                                                        selectedCleanerIndex,
                                                        onChanged: (ind) {
                                                          // FocusManager.instance.primaryFocus?.unfocus();

                                                          setState(() {
                                                            selectedCleanerIndex =
                                                                ind;
                                                            itemSelected =
                                                            false;
                                                          });
                                                          state
                                                              .response[
                                                          selectedjob!]
                                                              .assignedCleanerIndex =
                                                              selectedCleanerIndex;
                                                          print(
                                                              selectedCleanerIndex);
                                                        },
                                                      ),
                                                    ),
                                                    title: Text(
                                                        state.cleaners[index]
                                                            .name!,
                                                        style: const TextStyle(
                                                            fontSize: 23,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500)),
                                                  ),
                                                );
                                              }else{
                                                return Container();
                                              }
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
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

class ConfirmButton extends StatefulWidget {
  ConfirmButton(
      {super.key, required this.onPressed, required this.selectionInt});

  void Function() onPressed;
  bool loading = false;
  int? selectionInt;

  @override
  State<ConfirmButton> createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        enableFeedback: widget.selectionInt == null ? false : true,
        onTapUp: (val) {
          setState(() {
            widget.selectionInt == null
                ? widget.loading = false
                : widget.loading = true;
          });
        },
        onTap:
            //   () {
            // setState(() {
            //   widget.loading = true;
            // });
            widget.onPressed,
        // BlocProvider.of<UnassignedJobCubit>(context).confirmAndRefreshUnassignedJobs(jobId, staffId);
        // },
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstants.lightWidgetColor,
            border: Border.all(width: 0.5, color: Colors.black),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                spreadRadius: 1,
                blurRadius: 0,
                offset: Offset(2, 2), // changes position of shadow
              ),
            ],
          ),
          height: 32,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Center(
              child: widget.loading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: ColorConstants.mainThemeColor,
                      ),
                    )
                  : const Text(
                      "Confirm",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
            ),
          ),
          // width: screenWidth * 0.4,
        ),
      ),
    );
  }
}
