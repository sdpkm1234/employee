
import 'package:employee_data/utils/app_image.dart';
import 'package:employee_data/utils/app_img_const.dart';
import 'package:employee_data/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'employee.dart';
import 'employee_cubit.dart';
import 'employee_addorupdate.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Employee List',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.blue),
      body:
          BlocBuilder<EmployeeCubit, EmployeeState>(builder: (context, state) {
        if (state.isLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text(
                  'Loading employees...',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          );
        }

        if (state.employees.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppImage.svg(AppImgConst.icNoData),
              ],
            ),
          );
        }
        DateTime today = DateTime.now();
        List<Employee> currentEmployees = [];
        List<Employee> formerEmployees = [];

        for (var employee in state.employees) {
          if (employee.end.isEmpty ||
              DateTime.parse(employee.end).isAfter(today)) {
            currentEmployees.add(employee);
          } else {
            formerEmployees.add(employee);
          }
        }

        return ListView(
          children: [
            // Current Employees Section
            if (currentEmployees.isNotEmpty) ...[
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.grey3, // Background color
                ),

                alignment: Alignment
                    .centerLeft, // Centers child vertically and horizontally

                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Current Employees',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              ...List.generate(
                currentEmployees.length,
                (index) => Column(
                  children: [
                    _buildEmployeeTile(currentEmployees[index]),
                    if (index < currentEmployees.length - 1)
                      Divider(), // Add divider except after the last item
                  ],
                ),
              ),
            ],

            // Former Employees Section
            if (formerEmployees.isNotEmpty) ...[
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.grey3, // Background color
                ),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Former Employees',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              ...List.generate(
                formerEmployees.length,
                (index) => Column(
                  children: [
                    _buildEmployeeTile(formerEmployees[index]),
                    if (index < formerEmployees.length - 1)
                      Divider(), // Add divider except after the last item
                  ],
                ),
              ),
            ],
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.blue,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => EmployeeDialog(),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildEmployeeTile(Employee employee) {
    return Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const ScrollMotion(),
          children: [
            CustomSlidableAction(
              padding: const EdgeInsets.only(top: 10),
              // An action can be bigger than the others.
              flex: 1,
              onPressed: (BuildContext context) {
                Slidable.of(context)?.close();

                Future.microtask(() {
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EmployeeDialog(employee: employee)),
                    );
                  }
                });
              },

              child: Icon(Icons.edit, color: Colors.blue),
            ),
            CustomSlidableAction(
              padding: const EdgeInsets.only(top: 10),
              flex: 1,
              onPressed: (BuildContext context) {
                Future.microtask(() {
                  if (context.mounted) {
                    context.read<EmployeeCubit>().deleteEmployee(employee.id!);
                  }
                });
              },
              child: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
        child: ListTile(
          title: Text(employee.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          // subtitle: Text(employee.role),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(employee.role,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: AppColors.grey2)),
              Text('From ${employee.start}',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: AppColors.grey2)),
            ],
          ),
        ));
  }
}
