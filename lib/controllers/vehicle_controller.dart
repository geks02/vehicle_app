// lib/controllers/vehicle_controller.dart
import '../models/vehicle.dart';
import '../services/database_helper.dart';

class VehicleController {
  Future<List<Vehicle>> fetchVehicles() async {
    return await DatabaseHelper.instance.getAllVehicles();
  }

  Future<void> addVehicle(Vehicle vehicle) async {
    await DatabaseHelper.instance.insertVehicle(vehicle);
  }

  Future<void> deleteVehicle(int id) async {
    await DatabaseHelper.instance.deleteVehicle(id);
  }

  Future<void> updateVehicle(Vehicle vehicle) async {
    await DatabaseHelper.instance.updateVehicle(vehicle);
  }

  String getColorCoding(Vehicle vehicle) {
    if (vehicle.fuelEfficiency >= 15 && vehicle.age <= 5) {
      return 'green';
    } else if (vehicle.fuelEfficiency >= 15 && vehicle.age > 5) {
      return 'amber';
    } else {
      return 'red';
    }
  }
}
