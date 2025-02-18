// lib/models/vehicle.dart
class Vehicle {
  final int? id;
  final String name;
  final double fuelEfficiency;
  final int age;

  Vehicle({
    this.id,
    required this.name,
    required this.fuelEfficiency,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'fuelEfficiency': fuelEfficiency,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'Vehicle{id: $id, name: $name, fuelEfficiency: $fuelEfficiency, age: $age}';
  }
}
