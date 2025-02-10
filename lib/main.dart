import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'employee_cubit.dart';
import 'employee_list.dart';

void main() {
  // runApp(const MyApp());

  runApp(
    BlocProvider(
      create: (_) => EmployeeCubit()..loadEmployees(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Employee List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: EmployeeScreen(),
    );


  }
}


