// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insider_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsiderNotificationModel _$InsiderNotificationModelFromJson(
        Map<String, dynamic> json) =>
    InsiderNotificationModel(
      badge: json['badge'] as String?,
      imageUrl: json['image_url'] as String?,
      source: json['source'] as String?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      mutableContent: json['mutable-content'] as String?,
      threadId: json['threadId'] as String?,
    );

Map<String, dynamic> _$InsiderNotificationModelToJson(
    InsiderNotificationModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('badge', instance.badge);
  writeNotNull('image_url', instance.imageUrl);
  writeNotNull('source', instance.source);
  writeNotNull('title', instance.title);
  writeNotNull('message', instance.message);
  writeNotNull('mutable-content', instance.mutableContent);
  writeNotNull('threadId', instance.threadId);
  return val;
}

Channel _$ChannelFromJson(Map<String, dynamic> json) => Channel(
      channelName: json['channelName'] as String?,
      importance: json['importance'] as String?,
      ledColor: json['ledColor'] as String?,
      sound: json['sound'] as String?,
      id: json['id'] as String?,
      isBadgeEnabled: json['isBadgeEnabled'] as String?,
      isVibrationEnabled: json['isVibrationEnabled'] as String?,
      isVisibleOnLockScreen: json['isVisibleOnLockScreen'] as String?,
    );

Map<String, dynamic> _$ChannelToJson(Channel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('channelName', instance.channelName);
  writeNotNull('importance', instance.importance);
  writeNotNull('ledColor', instance.ledColor);
  writeNotNull('sound', instance.sound);
  writeNotNull('id', instance.id);
  writeNotNull('isBadgeEnabled', instance.isBadgeEnabled);
  writeNotNull('isVibrationEnabled', instance.isVibrationEnabled);
  writeNotNull('isVisibleOnLockScreen', instance.isVisibleOnLockScreen);
  return val;
}
