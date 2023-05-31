import 'package:flutter/material.dart';
import 'package:my_todo_app/todo/todo_module.dart';

class NewTaskPage extends StatefulWidget {
  final Function(TodoModel) addTodo;
  const NewTaskPage({
    Key? key,
    required this.addTodo,
  }) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  TextEditingController taskController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();

  String dropDownValue = "Work";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: const Text("New Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What is to be done?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: taskController,
                    decoration:
                        const InputDecoration(hintText: "Enter your task "),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Due Date",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: dueDateController,
                    decoration:
                        const InputDecoration(hintText: "Due date not set "),
                  ),
                ),
                Expanded(
                  child: IconButton(
                      onPressed: () async {
                        DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100));
                        dueDateController.text =
                            date.toString().substring(0, 10);
                      },
                      icon: const Icon(Icons.calendar_month)),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Add to List",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton(
                isExpanded: true,
                value: dropDownValue,
                items: [
                  const DropdownMenuItem(value: "Work", child: Text("Work")),
                  const DropdownMenuItem(
                      value: "Personal", child: Text("Personal")),
                  const DropdownMenuItem(
                      value: "Shopping", child: Text("Shopping")),
                  const DropdownMenuItem(
                      value: "WishList", child: Text("WishList")),
                ],
                onChanged: (value) {
                  dropDownValue = value!;
                  setState(() {});
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.addTodo(
            TodoModel(
              id: DateTime.now().toString(),
              dueDate: dueDateController.text,
              status: false,
              taskName: taskController.text,
              type: dropDownValue,
            ),
          );
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.check,
        ),
      ),
    );
  }
}
