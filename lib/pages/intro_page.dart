import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_admin/providers/login/login_cubit.dart';
import 'package:maintenance_admin/providers/login/login_states.dart';
import 'package:maintenance_admin/services/colors.dart';

import 'package:pinput/pinput.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  late Animation<Color?> animation;
  late AnimationController controller;
  String otp="";
  String otpId="";

  PageController _pageController = PageController(initialPage: 0);
  TextEditingController emailController = TextEditingController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      // Check if we are not on the last page
      _pageController.nextPage(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.ease,
      );
      setState(() {
        _currentPage++;
      });
    }
  }
  void _previousPage() {
    if (_currentPage >=0) {
      // Check if we are not on the last page
      _pageController.previousPage(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.ease,
      );
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation =
    ColorTween(begin: ColorConstants.mainThemeColor, end: Colors.white)
        .animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
  }

  void animateColor() {
    controller.forward();
  }

  bool selected = false;
  bool introAniOver = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: animation.value,
      body: SingleChildScrollView(
        reverse: true,
        scrollDirection: introAniOver ? Axis.vertical : Axis.horizontal,
        padding: EdgeInsets.only(bottom: keyboardHeight/1.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
                visible: !selected,
                child: const Text(
                  "Clean Room\nClean Life",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w500),
                )),
            Visibility(
                visible: !selected,
                child: const SizedBox(
                  height: 25,
                )),
            Visibility(
                visible: !selected,
                child: const Text(
                  "Book cleaners at the comfort\nof your room",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w400),
                )),
            Image.asset(
              "assets/images/maintenance_intro.png",
              width: screenWidth,
              height: screenHeight * 0.6,
            ),
            Visibility(
              visible: !selected,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: SizedBox(
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            )),
                        backgroundColor:
                         MaterialStatePropertyAll(ColorConstants.lightWidgetColor),
                        foregroundColor: MaterialStatePropertyAll(
                            ColorConstants.mainThemeColor),
                        textStyle: const MaterialStatePropertyAll(TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w500))),
                    onPressed: () {
                      animateColor();
                      setState(() {
                        selected = !selected;
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text("Get Started"),
                    ),
                  ),
                ),
              ),
            ),
            BlocConsumer<LoginCubit,LoginState>(
              listener:(context,state){
                if (state is LoginErrorState) {
                  SnackBar snackBar = SnackBar(
                    content: Text(state.error),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if(state is OtpSentState){
                  otpId=state.response.data["otpId"];
                }
                if(state is OtpVerifiedState){
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacementNamed(
                      context,
                      '/home',
                    );
                  });
                }
                if( state is InvalidEmailState){

                  _previousPage();
                  SnackBar snackBar = SnackBar(
                    content: Text(state.errorMsg),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              builder: (context,state) {
                return AnimatedContainer(
                  onEnd: () {
                    setState(() {
                      introAniOver = true;
                    });
                  },
                  curve: Curves.easeIn,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      color: ColorConstants.mainThemeColor,
                      borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(32))),
                  duration: const Duration(milliseconds: 500),
                  width: screenWidth,
                  height: selected ? screenHeight * 0.4 : 0,
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // Add your widgets for each page here
                      buildInfo(),
                      buildLogin(screenWidth),
                      buildOtp(screenWidth,keyboardHeight)
                    ],
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  Column buildOtp(double screenWidth,double keyboardHeight) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      // border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    // bool _isButtonDisabled = false;
    // int _secondsRemaining = 30;
    // void _startTimer() {
    //   setState(() {
    //     _isButtonDisabled = true;
    //     _secondsRemaining = 30;
    //   });
    //
    //   Timer.periodic(const Duration(seconds: 1), (timer) {
    //     setState(() {
    //       _secondsRemaining--;
    //
    //       if (_secondsRemaining == 0) {
    //         _isButtonDisabled = false;
    //         timer.cancel();
    //       }
    //     });
    //   });
    // }


    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "Enter Verification Code",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),
        ),
        const Text(
          "We have sent you a 6 digit verification code on",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),
        ),
        const Text(
          "qblocksupervisor@vit.ac.in",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300),
        ),
        // const SizedBox(height: 50,),
        Pinput(
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          length: 6,
          // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
          onCompleted: (pin) => otp=pin,
          cursor: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 9),
                width: 22,
                height: 1,
                color: const Color.fromRGBO(234, 239, 243, 1),
              ),
            ],
          ),
        ),
        const Text(
          "0:29",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          width: screenWidth * 0.8,
          child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    )),
                backgroundColor:  MaterialStatePropertyAll(ColorConstants.lightWidgetColor),
                foregroundColor:
                MaterialStatePropertyAll(ColorConstants.mainThemeColor),
                textStyle: const MaterialStatePropertyAll(
                    TextStyle(fontSize: 23, fontWeight: FontWeight.w500))),
            onPressed: () {
              BlocProvider.of<LoginCubit>(context).otp(otpId, int.parse(otp));
              // _nextPage();
              // Navigator.pushNamed(
              //   context,
              //   '/home',
              // );
            },
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text("Login"),
            ),
          ),
        ),
      ],
    );
  }

  Column buildLogin(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: SizedBox(
            width: screenWidth * 0.8,
            child: TapRegion(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              child: TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  suffixIcon: SizedBox(
                      height: 20,
                      width: 20,
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                      )),
                  label: Text("Vit Email Address"),
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: screenWidth * 0.8,
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      )),
                  backgroundColor: MaterialStatePropertyAll(ColorConstants.lightWidgetColor),
                  foregroundColor:
                  MaterialStatePropertyAll(ColorConstants.mainThemeColor),
                  textStyle: const MaterialStatePropertyAll(
                      TextStyle(fontSize: 23, fontWeight: FontWeight.w500))),
              onPressed: () {
                print(emailController.text);
                BlocProvider.of<LoginCubit>(context).login(emailController.text);
                _nextPage();
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("Get OTP"),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column buildInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Flexible(child: SizedBox(height: screenHeight*0.04,)),
        const Flexible(
            child: Text(
              "Admin Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            )),
        // Flexible(child: SizedBox(height: screenHeight*0.04,)),
        const Flexible(
          fit: FlexFit.tight,
          child: Text(
            "Accept cleaning requests from the\nusers and take the employee\nattendance at your fingertips",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
        Flexible(
          child: Align(
              alignment: Alignment.bottomRight,
              child: TextButton.icon(
                style: const ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: () {
                  _nextPage();
                },
                label: Icon(
                  Icons.arrow_circle_right,
                  color: ColorConstants.highlightColor,
                ),
                icon: const Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )),
        )
      ],
    );
  }
}
