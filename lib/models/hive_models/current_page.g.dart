// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentPageAdapter extends TypeAdapter<CurrentPage> {
  @override
  final int typeId = 10;

  @override
  CurrentPage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentPage(
      page: fields[0] as int,
      pageCount: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentPage obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.page)
      ..writeByte(1)
      ..write(obj.pageCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentPageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
