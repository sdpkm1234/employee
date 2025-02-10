import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import 'employee.dart';
import 'package:path/path.dart';

class EmployeeState {
  final bool isLoading;
  final List<Employee> employees;

  EmployeeState({required this.isLoading, required this.employees});
}

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit() : super(EmployeeState(isLoading: true, employees: []));

  Future<Database> get database async {
    final dbPath = await getDatabasesPath();

    return openDatabase(
      join(dbPath, 'employees.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE employees(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, role TEXT,start TEXT,end TEXT)');
      },
      version: 4,
    );
  }

  Future<void> loadEmployees() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('employees');
    emit(EmployeeState(
        isLoading: false,
        employees: maps.map((e) => Employee.fromMap(e)).toList()));
    log('DATA: $maps');
  }

  void addEmployee(Employee employee) async {
    final db = await database;
    await db.insert('employees', employee.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    loadEmployees();
  }

  void updateEmployee(Employee employee) async {
    final db = await database;
    await db.update('employees', employee.toMap(),
        where: 'id = ?', whereArgs: [employee.id]);
    loadEmployees();
  }

  void deleteEmployee(int id) async {
    final db = await database;
    await db.delete('employees', where: 'id = ?', whereArgs: [id]);
    loadEmployees();
  }
}
