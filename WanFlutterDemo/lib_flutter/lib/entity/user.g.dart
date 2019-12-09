// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..username = json['username'] as String
    ..website = json['website'] as String
    ..github = json['github'] as String
    ..psn = json['psn'] as String
    ..avatar_normal = json['avatar_normal'] as String
    ..avatar_large = json['avatar_large'] as String
    ..avatar_mini = json['avatar_mini'] as String
    ..location = json['location'] as String
    ..btc = json['btc'] as String
    ..id = json['id'] as int
    ..bio = json['bio'] as String
    ..url = json['url'] as String
    ..tagline = json['tagline'] as String
    ..twitter = json['twitter'] as String
    ..created = json['created'] as num
    ..status = json['status'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'website': instance.website,
      'github': instance.github,
      'psn': instance.psn,
      'avatar_normal': instance.avatar_normal,
      'avatar_large': instance.avatar_large,
      'avatar_mini': instance.avatar_mini,
      'location': instance.location,
      'btc': instance.btc,
      'id': instance.id,
      'bio': instance.bio,
      'url': instance.url,
      'tagline': instance.tagline,
      'twitter': instance.twitter,
      'created': instance.created,
      'status': instance.status
    };
