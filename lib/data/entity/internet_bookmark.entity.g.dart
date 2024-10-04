// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internet_bookmark.entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InternetBookmarkEntityAdapter
    extends TypeAdapter<InternetBookmarkEntity> {
  @override
  final int typeId = 2;

  @override
  InternetBookmarkEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InternetBookmarkEntity(
      title: fields[0] == null ? '' : fields[0] as String,
      url: fields[1] == null ? '' : fields[1] as String,
      faviconPath: fields[2] == null ? '' : fields[2] as String,
      isImportant: fields[3] == null ? false : fields[3] as bool,
      bookmarkId: fields[4] == null ? '' : fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InternetBookmarkEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.faviconPath)
      ..writeByte(3)
      ..write(obj.isImportant)
      ..writeByte(4)
      ..write(obj.bookmarkId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InternetBookmarkEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
