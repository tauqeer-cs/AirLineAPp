// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 5;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      userName: fields[0] as String?,
      email: fields[1] as String?,
      contactNo: fields[2] as String?,
      authenticated: fields[3] as bool?,
      token: fields[4] as String?,
      fullName: fields[5] as String?,
      message: fields[6] as String?,
      address: fields[7] as String?,
      postcode: fields[8] as String?,
      countryCode: fields[9] as String?,
      avatarUrl: fields[10] as String?,
      uuid: fields[12] as String?,
      location: fields[11] as String?,
      currentBalance: fields[13] as double?,
      isAccountActive: fields[14] as bool?,
      walletAddress: fields[15] as String?,
      accountExpiryDate: fields[16] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.contactNo)
      ..writeByte(3)
      ..write(obj.authenticated)
      ..writeByte(4)
      ..write(obj.token)
      ..writeByte(5)
      ..write(obj.fullName)
      ..writeByte(6)
      ..write(obj.message)
      ..writeByte(7)
      ..write(obj.address)
      ..writeByte(8)
      ..write(obj.postcode)
      ..writeByte(9)
      ..write(obj.countryCode)
      ..writeByte(10)
      ..write(obj.avatarUrl)
      ..writeByte(11)
      ..write(obj.location)
      ..writeByte(12)
      ..write(obj.uuid)
      ..writeByte(13)
      ..write(obj.currentBalance)
      ..writeByte(14)
      ..write(obj.isAccountActive)
      ..writeByte(15)
      ..write(obj.walletAddress)
      ..writeByte(16)
      ..write(obj.accountExpiryDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserStatusAdapter extends TypeAdapter<UserStatus> {
  @override
  final int typeId = 1;

  @override
  UserStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UserStatus.Inactive;
      case 1:
        return UserStatus.Active;
      case 2:
        return UserStatus.Suspend;
      case 3:
        return UserStatus.Delete;
      default:
        return UserStatus.Inactive;
    }
  }

  @override
  void write(BinaryWriter writer, UserStatus obj) {
    switch (obj) {
      case UserStatus.Inactive:
        writer.writeByte(0);
        break;
      case UserStatus.Active:
        writer.writeByte(1);
        break;
      case UserStatus.Suspend:
        writer.writeByte(2);
        break;
      case UserStatus.Delete:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      contactNo: json['contactNo'] as String?,
      authenticated: json['authenticated'] as bool?,
      token: json['token'] as String?,
      fullName: json['fullName'] as String?,
      message: json['message'] as String?,
      address: json['address'] as String?,
      postcode: json['postcode'] as String?,
      countryCode: json['countryCode'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      uuid: json['uuid'] as String?,
      location: json['location'] as String?,
      currentBalance: (json['currentBalance'] as num?)?.toDouble(),
      isAccountActive: json['isAccountActive'] as bool?,
      walletAddress: json['walletAddress'] as String?,
      accountExpiryDate: json['accountExpiryDate'] == null
          ? null
          : DateTime.parse(json['accountExpiryDate'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userName', instance.userName);
  writeNotNull('email', instance.email);
  writeNotNull('contactNo', instance.contactNo);
  writeNotNull('authenticated', instance.authenticated);
  writeNotNull('token', instance.token);
  writeNotNull('fullName', instance.fullName);
  writeNotNull('message', instance.message);
  writeNotNull('address', instance.address);
  writeNotNull('postcode', instance.postcode);
  writeNotNull('countryCode', instance.countryCode);
  writeNotNull('avatarUrl', instance.avatarUrl);
  writeNotNull('location', instance.location);
  writeNotNull('uuid', instance.uuid);
  writeNotNull('currentBalance', instance.currentBalance);
  writeNotNull('isAccountActive', instance.isAccountActive);
  writeNotNull('walletAddress', instance.walletAddress);
  writeNotNull(
      'accountExpiryDate', instance.accountExpiryDate?.toIso8601String());
  return val;
}
