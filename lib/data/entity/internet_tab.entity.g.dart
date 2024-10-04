// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internet_tab.entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InternetTabEntityAdapter extends TypeAdapter<InternetTabEntity> {
  @override
  final int typeId = 0;

  @override
  InternetTabEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InternetTabEntity(
      title: fields[0] == null ? '' : fields[0] as String,
      url: fields[1] == null ? '' : fields[1] as String,
      faviconPath: fields[2] == null ? '' : fields[2] as String,
      tabId: fields[3] == null ? '' : fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InternetTabEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.faviconPath)
      ..writeByte(3)
      ..write(obj.tabId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InternetTabEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
