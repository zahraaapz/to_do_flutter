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


ToDoModel({
  required this.id,
  required this.des,
  required this.title,
  required this.color,
});
}


@HiveType(typeId: 1)
enum  ToDoColor{


  @HiveField(0)
blue(11111),
  @HiveField(1)
pink(22222),
  @HiveField(2)
green(1),
  @HiveField(3)
purple(1);

final int code;

  const ToDoColor(this.code);


  
}