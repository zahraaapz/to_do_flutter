import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/model/todo_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

final box=Hive.box<ToDoModel>(todoBox);

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
      appBar: AppBar(
        title:const Text('TODOs'),
        actions: [IconButton(onPressed: (){}, icon:const Icon(Icons.add_circle_rounded))],
      ),
      body:Column(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal:8.0),
          child: Text('My ToDo Items',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
        ),
          Expanded(child: 
          ValueListenableBuilder<Box<ToDoModel>>(valueListenable:box.listenable(),
           builder:(context, value, child) {
             
                 final list=value.values.toList();
                 if (list.isEmpty) {
                 return  const Text('List is Empty');
                 } else {
                   return ListView.builder(
                    itemCount: list.length,
                    itemBuilder:(context, index) {
                     
                       list[index].id=box.keyAt(index);

                      return GestureDetector(
                        onTap: (){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.black,
                            action: SnackBarAction(label: 'Edit', onPressed: (){}),
                            content:Text(list[index].des)));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          
                          child: Dismissible(
                            background: Container(
                              padding: const EdgeInsets.all(12),
                              color: Colors.red,child: const Icon(Icons.delete),),
                            dismissThresholds: const {DismissDirection.endToStart:0.3},
                            onDismissed: (direction) {
                              if (direction==DismissDirection.endToStart) {
                                box.delete(list[index].id);
                                
                              } 
                            },
                            key: ValueKey<int>(list[index].id), child:Container() ),
                        ),
                      );
                   },);
                 }











           },))
      ],)
    ));
  }
}