// lib/views/add_vehicle_screen.dart
import 'package:flutter/material.dart';
import '../controllers/vehicle_controller.dart';
import '../models/vehicle.dart';

class AddVehicleScreen extends StatefulWidget {
  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _nameController = TextEditingController();
  final _fuelEfficiencyController = TextEditingController();
  final _ageController = TextEditingController();

  final VehicleController _vehicleController = VehicleController();

  void _addVehicle() async {
    final name = _nameController.text;
    final fuelEfficiency = double.tryParse(_fuelEfficiencyController.text) ?? 0.0;
    final age = int.tryParse(_ageController.text) ?? 0;

    if (name.isEmpty || fuelEfficiency <= 0 || age <= 0) {
      return;
    }

    Vehicle vehicle = Vehicle(name: name, fuelEfficiency: fuelEfficiency, age: age);
    await _vehicleController.addVehicle(vehicle);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Vehicle')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Vehicle Name'),
            ),
            TextField(
              controller: _fuelEfficiencyController,
              decoration: InputDecoration(labelText: 'Fuel Efficiency (km/l)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age (years)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addVehicle,
              child: Text('Add Vehicle'),
            ),
          ],
        ),
      ),
    );
  }
}
