// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlarmEntityAdapter extends TypeAdapter<AlarmEntity> {
  @override
  final int typeId = 0;

  @override
  AlarmEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlarmEntity(
      checkInOpen: fields[0] == null ? true : fields[0] as bool,
      checkOutOpen: fields[1] == null ? true : fields[1] as bool,
      checkInHour: fields[2] == null ? 0 : fields[2] as int,
      checkOutHour: fields[3] == null ? 0 : fields[3] as int,
      checkInMinute: fields[4] == null ? 0 : fields[4] as int,
      checkOutMinute: fields[5] == null ? 0 : fields[5] as int,
      checkInDays: fields[6] == null ? [] : (fields[6] as List).cast<int>(),
      checkOutDays: fields[7] == null ? [] : (fields[7] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, AlarmEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.checkInOpen)
      ..writeByte(1)
      ..write(obj.checkOutOpen)
      ..writeByte(2)
      ..write(obj.checkInHour)
      ..writeByte(3)
      ..write(obj.checkOutHour)
      ..writeByte(4)
      ..write(obj.checkInMinute)
      ..writeByte(5)
      ..write(obj.checkOutMinute)
      ..writeByte(6)
      ..write(obj.checkInDays)
      ..writeByte(7)
      ..write(obj.checkOutDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
