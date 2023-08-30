import 'package:hive_flutter/hive_flutter.dart';

class WorkData {
  List workToDo = [];

  final _workBox = Hive.box("workbox");

  void createInitialData() {
    workToDo = [
      ["Complete CSI Task", false]
    ];
  }

  void loadData() {
    workToDo = _workBox.get("WorkTasks") ?? "";
  }

  void updateData() {
    _workBox.put("WorkTasks", workToDo);
  }
}

class PersonalData {
  List personalToDo = [];

  final _personalBox = Hive.box("personalbox");

  void createInitialData() {
    personalToDo = [
      ["Call Someone", false],
    ];
  }

  void loadData() {
    personalToDo = _personalBox.get("PersonalTasks") ?? "";
  }

  void updateData() {
    _personalBox.put("PersonalTasks", personalToDo);
  }
}

class ShoppingData {
  List shoppingToDo = [];

  final _shoppingBox = Hive.box("shoppingbox");

  void createInitialData() {
    shoppingToDo = [
      ["Place D-Mart order", false]
    ];
  }

  void loadData() {
    shoppingToDo = _shoppingBox.get("ShoppingTasks") ?? "";
  }

  void updateData() {
    _shoppingBox.put("ShoppingTasks", shoppingToDo);
  }
}

class HealthData {
  List healthToDo = [];

  final _healthBox = Hive.box("healthbox");

  void createInitialData() {
    healthToDo = [
      ["Drink Water", false]
    ];
  }

  void loadData() {
    healthToDo = _healthBox.get("HealthTasks") ?? "";
  }

  void updateData() {
    _healthBox.put("HealthTasks", healthToDo);
  }
}
