// lib/views/edit_vehicle_screen.dart
import 'package:flutter/material.dart';
import '../controllers/vehicle_controller.dart';
import '../models/vehicle.dart';

class EditVehicleScreen extends StatefulWidget {
  final Vehicle vehicle;

  EditVehicleScreen({required this.vehicle});

  @override
  _EditVehicleScreenState createState() => _EditVehicleScreenState();
}

class _EditVehicleScreenState extends State<EditVehicleScreen> {
  final _nameController = TextEditingController();
  final _fuelEfficiencyController = TextEditingController();
  final _ageController = TextEditingController();

  final VehicleController _vehicleController = VehicleController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.vehicle.name;
    _fuelEfficiencyController.text = widget.vehicle.fuelEfficiency.toString();
    _ageController.text = widget.vehicle.age.toString();
  }

  void _editVehicle() async {
    final name = _nameController.text;
    final fuelEfficiency = double.tryParse(_fuelEfficiencyController.text) ?? 0.0;
    final age = int.tryParse(_ageController.text) ?? 0;

    if (name.isEmpty || fuelEfficiency <= 0 || age <= 0) {
      return;
    }

    Vehicle updatedVehicle = Vehicle(
      id: widget.vehicle.id,
      name: name,
      fuelEfficiency: fuelEfficiency,
      age: age,
    );

    await _vehicleController.updateVehicle(updatedVehicle);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Vehicle')),
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
              onPressed: _editVehicle,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
