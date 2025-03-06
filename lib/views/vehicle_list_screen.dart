// lib/views/vehicle_list_screen.dart
import 'package:flutter/material.dart';
import '../controllers/vehicle_controller.dart';
import '../models/vehicle.dart';
import 'add_vehicle_screen.dart';
import 'edit_vehicle_screen.dart';

class VehicleListScreen extends StatefulWidget {
  @override
  _VehicleListScreenState createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  List<Vehicle> vehicles = [];
  final VehicleController _vehicleController = VehicleController();

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  _loadVehicles() async {
    List<Vehicle> loadedVehicles = await _vehicleController.fetchVehicles();
    setState(() {
      vehicles = loadedVehicles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vehicles')),
      body: ListView.builder(
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          final vehicle = vehicles[index];
          String colorCoding = _vehicleController.getColorCoding(vehicle);

          Color backgroundColor = colorCoding == 'green'
              ? Colors.green
              : colorCoding == 'amber'
              ? Colors.amber
              : Colors.red;

          return Card(
            color: backgroundColor,
            child: ListTile(
              title: Text(vehicle.name),
              subtitle: Text('Fuel Efficiency: ${vehicle.fuelEfficiency} km/l, Age: ${vehicle.age} years'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Edit Button
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () async {
                      bool? refresh = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditVehicleScreen(vehicle: vehicle)),
                      );
                      if (refresh == true) {
                        _loadVehicles();
                      }
                    },
                  ),
                  // Delete Button
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.white),
                    onPressed: () async {
                      await _vehicleController.deleteVehicle(vehicle.id!);
                      _loadVehicles();  // Refresh the list after deleting the vehicle
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? refresh = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddVehicleScreen()),
          );
          if (refresh == true) {
            _loadVehicles();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
