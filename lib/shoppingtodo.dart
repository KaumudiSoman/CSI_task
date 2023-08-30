import 'package:csi_app/database.dart';
import 'package:csi_app/dialogbox.dart';
import 'package:csi_app/todotile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShoppingToDo extends StatefulWidget {
  ShoppingToDo({Key? key}) : super(key: key);

  @override
  State<ShoppingToDo> createState() => ShoppingList();
}

class ShoppingList extends State<ShoppingToDo> {
  final _shoppingBox = Hive.box("shoppingbox");
  ShoppingData sd = ShoppingData();

  final _controller = TextEditingController();

  void initState() {
    super.initState();

    if (_shoppingBox.get("ShoppingTasks") == null) {
      sd.createInitialData();
    } else {
      sd.loadData();
    }
  }

  checkBoxChanged(bool? value, int index) {
    setState(() {
      sd.shoppingToDo[index][1] = !sd.shoppingToDo[index][1];
    });
    sd.updateData();
  }

  void addNewTask() {
    setState(() {
      sd.shoppingToDo.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    sd.updateData();
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
      sd.shoppingToDo.removeAt(index);
    });
    sd.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping"),
        backgroundColor: const Color.fromARGB(222, 208, 130, 27),
      ),
      backgroundColor: const Color.fromARGB(244, 236, 235, 235),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: const Color.fromARGB(222, 208, 130, 27),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: sd.shoppingToDo.length,
          itemBuilder: (context, index) {
            return ToDoTile(
                taskName: sd.shoppingToDo[index][0],
                taskComppleted: sd.shoppingToDo[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask(index));
          }),
    );
  }
}
