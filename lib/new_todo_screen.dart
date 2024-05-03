import 'package:flutter/material.dart';
import 'package:to_do_list/helper.dart';
import 'package:to_do_list/main_screen.dart';
import 'package:to_do_list/model/todo_model.dart';

late ToDoColor _selectColor;

class ToDoFormScreen extends StatefulWidget {
  const ToDoFormScreen({super.key, required this.toDoModel});

  final ToDoModel toDoModel;

  @override
  State<ToDoFormScreen> createState() => _ToDoFormScreenState();
}

class _ToDoFormScreenState extends State<ToDoFormScreen> {

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.toDoModel.title);
    final desController = TextEditingController(text: widget.toDoModel.des);
    _selectColor = widget.toDoModel.color;
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
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: titleController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: desController,
                textInputAction: TextInputAction.newline,
                maxLines: 8,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const Text('Select date & time'),
                  IconButton(
                      onPressed: () async {
                        await showDatePicker(
                                context: context,
                                firstDate: DateTime.now().toLocal(),
                                initialDate:DateTime.now().toLocal() ,
                                lastDate: DateTime.now().add(const Duration(days: 1000)))
                            .then((value) {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(value!),
                          ).then((val) {
                            NotifHelper().setNotification(
                                value, widget.toDoModel.id, val!.hour, val.minute);
                            print(value.toString());
                            print(val.toString());
                          });
                        });
                      },
                      icon: const Icon(Icons.calendar_today)),
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (titleController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.black,
                  content: Text('Field is empty')));
            } else {
              widget.toDoModel.title = titleController.text.trim();
              widget.toDoModel.des = desController.text.trim();
              widget.toDoModel.color = _selectColor;

              if (widget.toDoModel.isInBox) {
                widget.toDoModel.save();
              } else {
                box.add(widget.toDoModel);
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
        child: isSelect
            ? const Icon(
                Icons.check,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
