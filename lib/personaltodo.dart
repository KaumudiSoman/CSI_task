import 'package:csi_app/database.dart';
import 'package:csi_app/dialogbox.dart';
import 'package:csi_app/todotile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PersonalToDo extends StatefulWidget {
  const PersonalToDo({Key? key}) : super(key: key);

  @override
  State<PersonalToDo> createState() => PersonalList();
}

class PersonalList extends State<PersonalToDo> {
  final _personalBox = Hive.box("personalbox");
  PersonalData pd = PersonalData();

  final _controller = TextEditingController();

  void initState() {
    super.initState();

    if (_personalBox.get("PersonalTasks") == null) {
      pd.createInitialData();
    } else {
      pd.loadData();
    }
  }

  checkBoxChanged(bool? value, int index) {
    setState(() {
      pd.personalToDo[index][1] = !pd.personalToDo[index][1];
    });
    pd.updateData();
  }

  void addNewTask() {
    setState(() {
      pd.personalToDo.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    pd.updateData();
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
      pd.personalToDo.removeAt(index);
    });
    pd.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal"),
        backgroundColor: const Color.fromARGB(222, 208, 130, 27),
      ),
      backgroundColor: const Color.fromARGB(244, 236, 235, 235),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: const Color.fromARGB(222, 208, 130, 27),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: pd.personalToDo.length,
          itemBuilder: (context, index) {
            return ToDoTile(
                taskName: pd.personalToDo[index][0],
                taskComppleted: pd.personalToDo[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask(index));
          }),
    );
  }
}
