import 'package:csi_app/database.dart';
import 'package:csi_app/dialogbox.dart';
import 'package:csi_app/todotile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WorkToDo extends StatefulWidget {
  WorkToDo({Key? key}) : super(key: key);

  @override
  State<WorkToDo> createState() => WorkList();
}

class WorkList extends State<WorkToDo> {
  final _workBox = Hive.box("workbox");
  WorkData wd = WorkData();

  final _controller = TextEditingController();

  void initState() {
    super.initState();

    if (_workBox.get("WorkTasks") == null) {
      wd.createInitialData();
    } else {
      wd.loadData();
    }
  }

  checkBoxChanged(bool? value, int index) {
    setState(() {
      wd.workToDo[index][1] = !wd.workToDo[index][1];
    });
    wd.updateData();
  }

  void addNewTask() {
    setState(() {
      wd.workToDo.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    wd.updateData();
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
      wd.workToDo.removeAt(index);
    });
    wd.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Work"),
        backgroundColor: const Color.fromARGB(222, 208, 130, 27),
      ),
      backgroundColor: const Color.fromARGB(244, 236, 235, 235),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: const Color.fromARGB(222, 208, 130, 27),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: wd.workToDo.length,
          itemBuilder: (context, index) {
            return ToDoTile(
                taskName: wd.workToDo[index][0],
                taskComppleted: wd.workToDo[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask(index));
          }),
    );
  }
}
