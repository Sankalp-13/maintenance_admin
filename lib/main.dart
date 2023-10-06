import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maintenance_admin/pages/assigned_jobs_page.dart';
import 'package:maintenance_admin/pages/completed_jobs_page.dart';
import 'package:maintenance_admin/pages/employees_page.dart';
import 'package:maintenance_admin/pages/home_page.dart';
import 'package:maintenance_admin/pages/intro_page.dart';
import 'package:maintenance_admin/pages/unassigned_jobs_page.dart';
import 'package:maintenance_admin/providers/assigned_jobs/assigned_jobs_cubit.dart';
import 'package:maintenance_admin/providers/completed_jobs/completed_jobs_cubit.dart';
import 'package:maintenance_admin/providers/employees/employees_cubit.dart';
import 'package:maintenance_admin/providers/login/login_cubit.dart';
import 'package:maintenance_admin/providers/unassigned_jobs/unassigned_jobs_cubit.dart';
import 'package:maintenance_admin/services/colors.dart';
import 'package:flutter/services.dart';

Widget _defaultHome = const IntroPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  // bool result = await SharedService.hasOtpTokens();
  // if (result) {
  //   _defaultHome = const HomePage();
  // }

  final storage = const FlutterSecureStorage();
  await storage.containsKey(key: "accessToken").then((value) {
    if (value) {
      _defaultHome = const HomePage();
    } else {
      /// This statement does not do anything since we already initialized at _defaultHome with IntroPage
      _defaultHome = const IntroPage();
    }
  });
  SystemChrome
      .setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) =>
      runApp(MultiBlocProvider(
        providers: [
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(),
          ),
          BlocProvider<UnassignedJobCubit>(
            create: (context) => UnassignedJobCubit(),
          ),
          BlocProvider<AssignedJobCubit>(
            create: (context) => AssignedJobCubit(),
          ),
          BlocProvider<CompletedJobCubit>(
            create: (context) => CompletedJobCubit(),
          ),
          BlocProvider<EmployeesCubit>(
            create: (context) => EmployeesCubit(),
          ),
        ],
        // Running the App widget
        child: const MyApp(),
      )));
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var routes = {
      '/': (context) => _defaultHome,
      '/login': (context) => const IntroPage(),
      '/home': (context) => const HomePage(),
      '/unassignedJobs': (context) => const UnassignedJobsPage(),
      '/assignedJobs': (context) => const AssignedJobsPage(),
      '/completedJobs': (context) => const CompletedJobsPage(),
      '/employeesPage': (context) => const EmployeesPage(),
    };

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Maintenance Admin',
        theme: ThemeData(
          fontFamily: 'General Sans',
          primarySwatch: getMaterialColor(ColorConstants.mainThemeColor),
        ),
        // routes: {
        //   '/': (context) => _defaultHome,
        //   '/login': (context) => const IntroPage(),
        //   '/home': (context) => const HomePage(),
        //   '/unassignedJobs': (context) => const UnassignedJobsPage(),
        //   '/assignedJobs': (context) => const AssignedJobsPage(),
        //   '/completedJobs': (context) => const CompletedJobsPage(),
        //   '/employeesPage': (context) => const EmployeesPage(),
        // },
        onGenerateRoute: (settings) {
          return CupertinoPageRoute(
              builder: (context) => routes[settings.name]!(context));
        }


      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
