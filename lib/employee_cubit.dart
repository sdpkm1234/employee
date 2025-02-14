
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'employee.dart';

class EmployeeState {
  final bool isLoading;
  final List<Employee> employees;

  EmployeeState({required this.isLoading, required this.employees});
}


class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit() : super(EmployeeState(isLoading: true, employees: []));

  final Box<Employee> employeeBox = Hive.box<Employee>('employees');

  void loadEmployees() async {
    emit(EmployeeState(isLoading: true, employees: [])); // Show loading
    await Future.delayed(Duration(seconds: 2)); // Simulate API delay
    final employees = employeeBox.values.toList();
    emit(EmployeeState(isLoading: false, employees: employees)); // Load data
  }

  void addEmployee(Employee employee) async {
    await employeeBox.add(employee);
    loadEmployees(); // Refresh state
  }

  void updateEmployee(Employee employee) async {
    int index = employeeBox.values.toList().indexWhere((e) => e.id == employee.id);
    if (index != -1) {
      await employeeBox.putAt(index, employee);
    }
    loadEmployees();
  }

  void deleteEmployee(int index) async {
    await employeeBox.deleteAt(index);
    loadEmployees();
  }
}

