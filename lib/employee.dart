class Employee {
  final int? id;
  final String name;
  final String role;
  final String start;
  final String end;

  Employee(
      {this.id,
      required this.name,
      required this.role,
      required this.start,
      required this.end});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'role': role, 'start': start, 'end': end};
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
        id: map['id'],
        name: map['name'],
        role: map['role'],
        start: map['start'],
        end: map['end']);
  }
}
