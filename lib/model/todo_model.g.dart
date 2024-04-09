// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoModelAdapter extends TypeAdapter<ToDoModel> {
  @override
  final int typeId = 0;

  @override
  ToDoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDoModel(
  
      des: fields[2] as String,
      title: fields[1] as String,
      color: fields[3] as ToDoColor,
    );
  }

  @override
  void write(BinaryWriter writer, ToDoModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.des)
      ..writeByte(3)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ToDoColorAdapter extends TypeAdapter<ToDoColor> {
  @override
  final int typeId = 1;

  @override
  ToDoColor read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ToDoColor.blue;
      case 1:
        return ToDoColor.pink;
      case 2:
        return ToDoColor.green;
      case 3:
        return ToDoColor.purple;
      default:
        return ToDoColor.blue;
    }
  }

  @override
  void write(BinaryWriter writer, ToDoColor obj) {
    switch (obj) {
      case ToDoColor.blue:
        writer.writeByte(0);
        break;
      case ToDoColor.pink:
        writer.writeByte(1);
        break;
      case ToDoColor.green:
        writer.writeByte(2);
        break;
      case ToDoColor.purple:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoColorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
