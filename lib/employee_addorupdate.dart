
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'employee.dart';
import 'employee_cubit.dart';

class EmployeeDialog extends StatefulWidget {
  final Employee? employee;
  final int? index;

  const EmployeeDialog({super.key, this.employee,this.index});

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
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner'
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee?.name ?? '');
    _startdateController = TextEditingController(text: widget.employee?.start ?? '');
    _enddateController = TextEditingController(text: widget.employee?.end ?? '');

    _selectedRole = widget.employee?.role != null && _roles.contains(widget.employee!.role)
        ? widget.employee!.role
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Employee Details',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Employee Name',
                      prefixIcon: const Icon(Icons.person_outlined, color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]+$')),
                    ],
                    validator: (value) => value!.isEmpty ? 'Enter name' : null,
                  ),
                  const SizedBox(height: 20.0),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Select Role',
                      prefixIcon: const Icon(Icons.card_travel, color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
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
                    validator: (value) => value == null ? 'Select a role' : null,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _startdateController,
                          decoration: InputDecoration(
                            labelText: 'Start Date',
                            prefixIcon: const Icon(Icons.calendar_today, color: Colors.blue),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          readOnly: true,
                          onTap: () => _selectDate(context, 'start'),
                          validator: (value) => value!.isEmpty ? 'Select a date' : null,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.arrow_forward_outlined, color: Colors.blue),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _enddateController,
                          decoration: InputDecoration(
                            labelText: 'End Date',
                            prefixIcon: const Icon(Icons.calendar_today, color: Colors.blue),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          readOnly: true,
                          onTap: () => _selectDate(context, 'end'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                onPressed: _saveEmployee,
                child: const Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
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
        if (type == 'start') {
          _startdateController.text = DateFormat('yyyy-MM-dd').format(picked);
        } else {
          _enddateController.text = DateFormat('yyyy-MM-dd').format(picked);
        }
      });
    }
  }

  void _saveEmployee() {
    if (_formKey.currentState!.validate()) {
      final newEmployee = Employee(
        id: widget.employee?.id, // Hive automatically manages IDs
        name: _nameController.text,
        role: _selectedRole.toString(),
        start: _startdateController.text,
        end: _enddateController.text,
      );

      final employeeCubit = context.read<EmployeeCubit>();

      if (widget.employee == null) {
        employeeCubit.addEmployee(newEmployee);
      } else {
        employeeCubit.updateEmployee(newEmployee);
      }

      Navigator.pop(context);
    }
  }
}