import 'package:csi_app/database.dart';
import 'package:csi_app/dialogbox.dart';
import 'package:csi_app/todotile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HealthToDo extends StatefulWidget {
  HealthToDo({Key? key}) : super(key: key);

  @override
  State<HealthToDo> createState() => HealthList();
}

class HealthList extends State<HealthToDo> {
  final _healthBox = Hive.box("healthbox");
  HealthData hd = HealthData();

  final _controller = TextEditingController();

  void initState() {
    super.initState();

    if (_healthBox.get("HealthTasks") == null) {
      hd.createInitialData();
    } else {
      hd.loadData();
    }
  }

  checkBoxChanged(bool? value, int index) {
    setState(() {
      hd.healthToDo[index][1] = !hd.healthToDo[index][1];
    });
    hd.updateData();
  }

  void addNewTask() {
    setState(() {
      hd.healthToDo.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    hd.updateData();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onAdd: addNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      hd.healthToDo.removeAt(index);
    });
    hd.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health"),
        backgroundColor: const Color.fromARGB(222, 208, 130, 27),
      ),
      backgroundColor: const Color.fromARGB(244, 236, 235, 235),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: const Color.fromARGB(222, 208, 130, 27),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: hd.healthToDo.length,
          itemBuilder: (context, index) {
            return ToDoTile(
                taskName: hd.healthToDo[index][0],
                taskComppleted: hd.healthToDo[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask(index));
          }),
    );
  }
}
