import 'package:hive_flutter/adapters.dart';

@HiveType(typeId: 0)
class Employee extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String role;

  @HiveField(3)
  String start;

  @HiveField(4)
  String end;

  Employee(
      {this.id,
      required this.name,
      required this.role,
      required this.start,
      required this.end});
}

class EmployeeAdapter extends TypeAdapter<Employee> {
  @override
  final int typeId = 0;

  @override
  Employee read(BinaryReader reader) {
    return Employee(
      id: reader.read(),
      name: reader.read(),
      role: reader.read(),
      start: reader.read(),
      end: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Employee obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.role);
    writer.write(obj.start);
    writer.write(obj.end);
  }
}
