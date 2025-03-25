# This branch is under development


# Maintenance Admin App

A Maintenance project created in flutter using Bloc.
https://youtube.com/shorts/rs2adxjSkg4


## Features Implemented:

* Intro
* Login
* Home
* UnassignedJobs
* AssignedJobs
* CompletedJobs
* Employees
* Routing
* Dio
* pretty_dio_logger (For Logging)
* Flutter Secure Storage
* Bloc (State Management)//assigned jobs, completed jobs, employees


### Future Features and Fixes:

* assigned jobs, completed jobs, employees,home page (design change)
* login error fix(while receiving multiple error msg)

### Libraries & Tools Used
* pinput: ^3.0.1
* flutter_bloc: ^8.1.3
* dio: ^5.3.3
* pretty_dio_logger: ^1.3.1
* flutter_secure_storage: ^9.0.0
* intl: ^0.18.1

### Folder Structure
Here is the folder structure we have been using in this project

```
lib/
|- domain/
|- pages/
|- providers/
|- services/
```

```
1- domain - Contains all the network related files.
2- pages - Contains the UI.
3- providers - State management, has cubits and their states for each screen, contains sub directory for each screen. 
4- services- Contains color constants.
```

