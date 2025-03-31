import 'package:flutter/material.dart';
import 'package:flutter_hive_db/todo.dart';
import 'package:hive/hive.dart';

class Addtodo extends StatelessWidget {
  TextEditingController titlecontroller = TextEditingController();
  Box todoBox = Hive.box<Todo>('todo');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            'Add task',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: titlecontroller,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue
                  ),
                  child: GestureDetector(
                      onTap: () {
                        if (titlecontroller.text != '') {
                          Todo newtodo = Todo(
                            title: titlecontroller.text,
                            isCompleted: false,
                          );
                          todoBox.add(newtodo);
                          Navigator.pop(context);
                        }
                      },
                      child: Center(
                        child: Text(
                          "Add task",
                          style: TextStyle(color: Colors.white,fontSize: 20),
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
