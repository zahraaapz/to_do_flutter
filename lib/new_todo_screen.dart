import 'package:flutter/material.dart';
import 'package:to_do_list/main_screen.dart';
import 'package:to_do_list/model/todo_model.dart';

late ToDoColor _selectColor;

class ToDoFormScreen extends StatelessWidget {
  const ToDoFormScreen({super.key, required this.toDoModel});

  final ToDoModel toDoModel;
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: toDoModel.title);
    final desController = TextEditingController(text: toDoModel.des);
    _selectColor = toDoModel.color;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo Form'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.keyboard_arrow_left_outlined)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const ToDoColorSelector(),
              SizedBox(height: 12,),
              TextField(
                controller: titleController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              SizedBox(height: 12,),

              TextField(
                controller: desController,
                textInputAction: TextInputAction.newline,
                maxLines: 8,
                decoration: const InputDecoration(hintText: 'Description'),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (titleController.text.isEmpty) {
              
            } else {
                 toDoModel.title=titleController.text.trim();
            toDoModel.des=desController.text.trim();
            toDoModel.color=_selectColor;

            if (toDoModel.isInBox) {
              toDoModel.save();
            } else {
              box.add(toDoModel);
            }
            }
         Navigator.pop(context);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}

class ToDoColorSelector extends StatefulWidget {
  const ToDoColorSelector({super.key});

  @override
  State<ToDoColorSelector> createState() => _ToDoColorSelectorState();
}

class _ToDoColorSelectorState extends State<ToDoColorSelector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ColorItem(
          onTap: () {
            setState(() {
              _selectColor = ToDoColor.blue;
            });
          },
          isSelect: _selectColor == ToDoColor.blue,
          colorCode: ToDoColor.blue.code,
        ),
        ColorItem(
          onTap: () {
            setState(() {
              _selectColor = ToDoColor.pink;
            });
          },
          isSelect: _selectColor == ToDoColor.pink,
          colorCode: ToDoColor.pink.code,
        ),
        ColorItem(
          onTap: () {
            setState(() {
              _selectColor = ToDoColor.purple;
            });
          },
          isSelect: _selectColor == ToDoColor.purple,
          colorCode: ToDoColor.purple.code,
        ),
        ColorItem(
          onTap: () {
            setState(() {
              _selectColor = ToDoColor.green;
            });
          },
          isSelect: _selectColor == ToDoColor.green,
          colorCode: ToDoColor.green.code,
        ),
      ],
    );
  }
}

class ColorItem extends StatelessWidget {
  const ColorItem({
    super.key,
    required this.onTap,
    required this.isSelect,
    required this.colorCode,
  });

  final Function() onTap;
  final bool isSelect;
  final int colorCode;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(3),
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Color(colorCode)),
        child: isSelect ? const Icon(Icons.check,color: Colors.white,) : null,
      ),
    );
  }
}
