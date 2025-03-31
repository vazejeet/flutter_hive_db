import 'package:flutter/material.dart';
import 'package:flutter_hive_db/addtodo.dart';
import 'package:flutter_hive_db/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Box todoBox = Hive.box<Todo>('todo');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Todo list',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: ValueListenableBuilder(
            valueListenable: todoBox.listenable(),
            builder: (context, Box box, widget) {
              if (box.isEmpty) {
                return Center(child: Text('No todo available'));
              } else {
                return ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      Todo todo = box.getAt(index);
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              todo.title,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: todo.isCompleted
                                      ? Colors.green
                                      : Colors.black),
                            ),
                            leading: Checkbox(
                                value: todo.isCompleted,
                                onChanged: (value) {
                                  Todo newTodo = Todo(
                                    title: todo.title,
                                    isCompleted: value!,
                                  );
                                  box.putAt(index, newTodo);
                                }),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                box.deleteAt(index);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Todo deleted Successfully !"),
                                ));
                              },
                            ),
                          ),
                          Divider(),
                        ],
                      );
                      
                    });
              }
            }),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Addtodo()));
            }),
      ),
    );
  }
}
