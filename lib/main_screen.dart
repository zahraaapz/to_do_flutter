import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/model/todo_model.dart';
import 'package:to_do_list/new_todo_screen.dart';

import 'service/service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

final box = Hive.box<ToDoModel>(todoBox);

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('TODOs'),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ToDoFormScreen(
                                toDoModel: ToDoModel(
                                   dateTime:DateTime.now(), des: '', title: '', color: ToDoColor.blue)),
                          ));
                    },
                    icon: const Icon(Icons.add_circle_rounded))
              ],
            ),
            body: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'My ToDo Items',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                    child: ValueListenableBuilder<Box<ToDoModel>>(
                  valueListenable: box.listenable(),
                  builder: (context, value, child) {
                    final list = value.values.toList();
                    if (list.isEmpty) {
                      return const Center(child:Text('List is Empty'));
                    } else {
                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          list[index].id = box.keyAt(index);

                          return Item(toDo: list[index]);
                        },
                      );
                    }
                  },
                ))
              ],
            )));
  }
}

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.toDo,
  });

  final toDo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            action: SnackBarAction(
                label: 'Edit',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ToDoFormScreen(toDoModel: toDo),
                      ));
                }),
            content: Text(toDo.des)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Dismissible(
            confirmDismiss: (direction) async =>
                direction == DismissDirection.endToStart,
            background: Container(
              padding: const EdgeInsets.all(12),
              color: Colors.red,
              child: const Icon(Icons.delete),
            ),
            dismissThresholds: const {DismissDirection.endToStart: 0.3},
            onDismissed: (direction) async {
              if (direction == DismissDirection.endToStart) {
              await NotifHelper().cancelNotif(toDo.id);
               box.delete(toDo.id);
                

              
              }
            },
            key: ValueKey<int>(toDo.id),
            child: Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                   
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.edit_note,
                            size: 24, color: Color(toDo.color.code)),
                      ),
                      Text(
                        toDo.title,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(toDo.color.code)),
                      ),
                       const Spacer(),
                      Builder(
                        builder:(context) {
                          final dateString=DateFormat('dd/mm/yyyy   hh:mm').format(toDo.dateTime);
                          return Text(dateString);
                        },)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      toDo.des,
                      textAlign: TextAlign.justify,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider()
                ],
              ),
            )),
      ),
    );
  }
}
