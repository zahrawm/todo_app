import 'package:flutter/material.dart';
import 'package:my_todo_app/todo/todo_module.dart';

class TodoCardWidget extends StatelessWidget {
  final TodoModel todoModel;

  final Function(String, bool) update;
  const TodoCardWidget({
    Key? key,
    required this.todoModel,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          onChanged: (value) {
            print(value);
            update(todoModel.id, value!);
          },
          value: todoModel.status,
        ),
        title: Text(todoModel.taskName),
        subtitle: Text(
          todoModel.dueDate,
          style:
              const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        trailing: (Text(
          todoModel.type,
          style: TextStyle(
              color: todoColor(todoModel.type), fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}

Color todoColor(String value) {
  switch (value) {
    case "Learning":
      return Colors.blue;
    case "Personal":
      return Colors.amber;
    case "Cooking":
      return Colors.cyan;
    case "Work":
      return Colors.greenAccent;
    case "WishList":
      return Colors.pink;
    default:
      return Colors.black;
  }
}
