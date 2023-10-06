import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maintenance_admin/services/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
    // double h = MediaQuery.of(context).size.height / 844.24;
    // double w = MediaQuery.of(context).size.width / 390.11;
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
            // margin: const EdgeInsets.only(top: 90), // Add margin for the gap
            // padding: const EdgeInsets.fromLTRB(16, 36, 16, 16),
            // Add padding for content spacing
            decoration: const BoxDecoration(
              color: Colors.white, // Set box color to white
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                // Add rounded corners to the top left
                topRight:
                    Radius.circular(32), // Add rounded corners to the top right
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Stack(
              children: [
                // Positioned(
                //   top: screenHeight*0.25,
                //   left: 1 * w,
                //   child: Patch().a,
                // ),
                // Positioned(top: screenHeight*0.01, left: -80 * w, child: Patch().b),
                // Positioned(
                //   top: 372.3 * h,
                //   left: 1 * w,
                //   child: Patch().c,
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 36, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Align text to the left
                    children: [
                      const Text(
                        'Welome Admin1,',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 20),
                      // Add spacing below the heading
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SquareButton(
                            label: 'Assigned Jobs',
                            widgetHeight: screenHeight * 0.148,
                            widgetWidth: screenWidth * 0.43,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/assignedJobs',
                              );
                            },
                          ),
                          SquareButton(
                            label: 'Unassigned Jobs',
                            widgetHeight: screenHeight * 0.148,
                            widgetWidth: screenWidth * 0.43,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/unassignedJobs',
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SquareButton(
                            label: 'Completed Jobs',
                            widgetHeight: screenHeight * 0.148,
                            widgetWidth: screenWidth * 0.917,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/completedJobs',
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.082),
                      const Text(
                        'Others',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              CircularButton(
                                label: 'Attendance',
                                iconAddress: "assets/icons/attendance_icon.png",
                                onPress: () {},
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                          Column(
                            children: [
                              CircularButton(
                                label: 'Available employees',
                                iconAddress: "assets/icons/emp_icon.png",
                                onPress: () { Navigator.pushNamed(
                                  context,
                                  '/employeesPage',
                                );},
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                          Column(
                            children: [
                              CircularButton(
                                label: 'My Profile',
                                iconAddress: "assets/icons/profile_icon.png",
                                onPress: () {},
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Add spacer to push the button to the bottom
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SquareButton extends StatefulWidget {
  final String label;
  final double widgetHeight;
  final double widgetWidth;
  final void Function() onPressed;

  const SquareButton({
    required this.label,
    required this.widgetHeight,
    required this.widgetWidth,
    required this.onPressed,
  });

  @override
  State<SquareButton> createState() => _SquareButtonState();
}

class _SquareButtonState extends State<SquareButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.widgetHeight,
          width: widget.widgetWidth,
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(100),
              backgroundColor: ColorConstants.lightThemeColor,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(24.0), // Adjust the value as needed
              ),
            ),
            child: null,
            // child: Text(
            //   widget.label,
            //   style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            // ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          widget.label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class CircularButton extends StatelessWidget {
  final String label;
  final String iconAddress;
  final void Function() onPress;

  const CircularButton(
      {super.key,
      required this.label,
      required this.iconAddress,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(10),
            backgroundColor: const Color(0xFF5A4EAB),
            shape: const CircleBorder(),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ImageIcon(
              AssetImage(iconAddress),
              size: 32,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
