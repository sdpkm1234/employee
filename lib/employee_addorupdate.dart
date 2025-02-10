
import 'package:employee_data/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'employee.dart';
import 'employee_cubit.dart';

class EmployeeDialog extends StatefulWidget {
  final Employee? employee;
  EmployeeDialog({super.key, this.employee});

  @override
  State<EmployeeDialog> createState() => _EmployeeDialogState();
}

class _EmployeeDialogState extends State<EmployeeDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;

  late TextEditingController _startdateController;

  late TextEditingController _enddateController;
  String? _selectedRole;
  final List<String> _roles = [
    'Product designer',
    'Flutter developer',
    'QA Tester',
    'Product Owner'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _startdateController.dispose();
    _enddateController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _nameController = TextEditingController(text: widget.employee?.name ?? '');
    _startdateController =
        TextEditingController(text: widget.employee?.start ?? '');
    _enddateController =
        TextEditingController(text: widget.employee?.end ?? '');
    // _selectedRole=widget.employee?.role ?? '';

    if (widget.employee?.role != null &&
        _roles.contains(widget.employee!.role)) {
      _selectedRole = widget.employee!.role;
    } else {
      _selectedRole = null; // Set to null if invalid or not found
    }
    super.initState();
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Add Employee Details',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.blue),
      body: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Employee name',
                      prefixIcon:
                          Icon(Icons.person_outlined, color: Colors.blue),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: AppColors.grey1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: AppColors.grey1,
                          width: 2.0,
                        ),
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(
                          r'^[a-zA-Z\s]+$')), // Allow only letters and spaces
                    ],
                    style: TextStyle(fontWeight: FontWeight.bold),
                    validator: (value) => value!.isEmpty ? 'Enter name' : null,
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Select role',
                      prefixIcon: Icon(Icons.card_travel, color: Colors.blue),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: AppColors.grey1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: AppColors.grey1,
                          width: 2.0,
                        ),
                      ),
                    ),
                    value: _selectedRole,
                    items: _roles.map((String role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Select a role' : null,
                  ),
                  SizedBox(height: 20.0),
                  Row(children: [
                    Expanded(
                      child: TextFormField(
                        controller: _startdateController,
                        decoration: InputDecoration(
                          labelText: 'Start',
                          prefixIcon:
                              Icon(Icons.calendar_today, color: Colors.blue),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: AppColors.grey1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: AppColors.grey1,
                              width: 2.0,
                            ),
                          ),
                        ),
                        style: TextStyle(fontSize: 12),
                        readOnly: true,
                        onTap: () => _selectDate(context, 'start'),
                        validator: (value) =>
                            value!.isEmpty ? 'Select a date' : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _enddateController,
                        decoration: InputDecoration(
                          labelText: 'End',
                          prefixIcon:
                              Icon(Icons.calendar_today, color: Colors.blue),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: AppColors.grey1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: AppColors.grey1,
                              width: 2.0,
                            ),
                          ),
                        ),
                        style: TextStyle(fontSize: 12),
                        readOnly: true,
                        onTap: () => _selectDate(context, 'end'),
                      ),
                    )
                  ]),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
        Divider(height: 1, color: Colors.grey),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bgCancel,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel', style: TextStyle(color: Colors.blue)),
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bgSave,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final emp = Employee(
                        id: widget.employee?.id,
                        name: _nameController.text,
                        role: _selectedRole.toString(),
                        start: _startdateController.text,
                        end: _enddateController.text,
                      );
                      if (widget.employee == null) {
                        context.read<EmployeeCubit>().addEmployee(emp);
                      } else {
                        context.read<EmployeeCubit>().updateEmployee(emp);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> _selectDate(BuildContext context, String type) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        type == 'start'
            ? _startdateController.text =
                DateFormat('yyyy-MM-dd').format(picked)
            : _enddateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
}
