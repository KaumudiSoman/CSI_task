import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskComppleted,
      required this.onChanged,
      required this.deleteFunction});
  final String taskName;
  final bool taskComppleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: const Color.fromARGB(222, 208, 130, 27),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Checkbox(
                value: taskComppleted,
                onChanged: onChanged,
                activeColor: const Color.fromARGB(244, 236, 235, 235),
              ),
              Text(taskName,
                  style: TextStyle(
                      decoration: taskComppleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none))
            ],
          ),
        ),
      ),
    );
  }
}
