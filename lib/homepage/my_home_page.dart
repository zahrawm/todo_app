import 'package:flutter/material.dart';
import 'package:my_todo_app/listitems/list.dart';
import 'package:my_todo_app/new_task_page/new_task.dart';
import 'package:my_todo_app/todo/todo_card.dart';

import 'package:my_todo_app/todo/todo_module.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void addTodo(TodoModel todoModel) {
    listOfTodo.add(todoModel);
    if (category == "All List" ||
        category == "Pending" ||
        category == todoModel.type) {
      _templist.add(todoModel);
    }
    setState(() {});
  }

  String category = "Pending";
  updateStatus(String id, bool status) async {
    int index = listOfTodo.indexWhere((element) => element.id == id);
    listOfTodo[index].status = status;
    await Future.delayed(const Duration(milliseconds: 500));

    if (category == "All List") {
      _templist = listOfTodo.toList();
    } else if (category == "Pending") {
      _templist =
          listOfTodo.where((element) => element.status == false).toList();
    } else if (category == "Finished") {
      _templist =
          listOfTodo.where((element) => element.status == true).toList();
    } else {
      _templist =
          listOfTodo.where((element) => element.type == category).toList();
    }
    setState(() {});
  }

  List<TodoModel> listOfTodo = [];
  List<TodoModel> _templist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (child) => NewTaskPage(
                addTodo: addTodo,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("TODO: $category"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              print(value);
              category = value;
              if (category == "All List") {
                _templist = listOfTodo.toList();
              } else if (category == "Pending") {
                _templist = listOfTodo
                    .where((element) => element.status == false)
                    .toList();
              } else if (category == "Finished") {
                _templist = listOfTodo
                    .where((element) => element.status == true)
                    .toList();
              } else {
                _templist = listOfTodo
                    .where((element) => element.type == value)
                    .toList();
              }
              setState(() {});
            },
            itemBuilder: (context) => popUpMenuItemTittleList
                .map(
                  (e) => PopupMenuItem(
                    value: e,
                    child: Text(
                      e,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
      body: ListView(
        children: _templist
            .map(
              (e) => TodoCardWidget(todoModel: e, update: updateStatus),
            )
            .toList(),
      ),
    );
  }
}
