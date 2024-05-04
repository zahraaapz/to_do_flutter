import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 0)
class ToDoModel extends HiveObject {
  @HiveField(0)
  int id = -1;
  @HiveField(1)
  String title;
  @HiveField(2)
  String des;

  @HiveField(3)
  ToDoColor color; 
   @HiveField(4)
  DateTime dateTime=DateTime.now();

  ToDoModel({
    required this.des,
    required this.dateTime,
    required this.title,
    required this.color,
  });
}

@HiveType(typeId: 1)
enum ToDoColor {
  @HiveField(0)
  blue(0xffbbdefb),
  @HiveField(1)
  pink(0xfff48fb1),
  @HiveField(2)
  green(0xff1de9b6),
  @HiveField(3)
  purple(0xff7e57c2);

  final int code;

  const ToDoColor(this.code);
}
