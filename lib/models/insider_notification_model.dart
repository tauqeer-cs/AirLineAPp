import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'insider_notification_model.g.dart';

@JsonSerializable()
class InsiderNotificationModel extends Equatable{
  const InsiderNotificationModel({
    this.badge,
    this.imageUrl,
    this.source,
    this.title,
    this.message,
    this.mutableContent,
    this.threadId,
  });

  final String? badge;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final String? source;
  final String? title;
  final String? message;
  @JsonKey(name: 'mutable-content')
  final String? mutableContent;
  final String? threadId;

  @override
  // TODO: implement props
  List<Object?> get props => [badge,
    imageUrl,
    source,
    title,
    message,
    mutableContent,
    threadId,];

  factory InsiderNotificationModel.fromJson(Map<String, dynamic> json) => _$InsiderNotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$InsiderNotificationModelToJson(this);
}

@JsonSerializable()
class Channel extends Equatable{
  const Channel({
    this.channelName,
    this.importance,
    this.ledColor,
    this.sound,
    this.id,
    this.isBadgeEnabled,
    this.isVibrationEnabled,
    this.isVisibleOnLockScreen,
  });

  final String? channelName;
  final String? importance;
  final String? ledColor;
  final String? sound;
  final String? id;
  final String? isBadgeEnabled;
  final String? isVibrationEnabled;
  final String? isVisibleOnLockScreen;

  @override
  // TODO: implement props
  List<Object?> get props => [channelName,
    importance,
    ledColor,
    sound,
    id,
    isBadgeEnabled,
    isVibrationEnabled,
    isVisibleOnLockScreen,];

  factory Channel.fromJson(Map<String, dynamic> json) => _$ChannelFromJson(json);
  Map<String, dynamic> toJson() => _$ChannelToJson(this);
}
