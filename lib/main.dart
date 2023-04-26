import 'package:flutter/material.dart';
import 'package:maintenance_admin/pages/home_page.dart';
import 'package:maintenance_admin/pages/login_page.dart';
import 'package:maintenance_admin/pages/otp_page.dart';
import 'package:maintenance_admin/services/shared_service.dart';

Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool result = await SharedService.hasOtpTokens();
  if (result) {
    _defaultHome = const HomePage();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maintenance Admin',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => _defaultHome,
        '/login' : (context)=> const LoginPage(),
        '/home':(context)=> const HomePage(),
        '/otp' : (context)=> const OtpPage(),

      },
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
