// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityPromotion _$CommunityPromotionFromJson(Map<String, dynamic> json) {
  return CommunityPromotion()
    ..topic_max = json['topic_max'] as num
    ..member_max = json['member_max'] as num;
}

Map<String, dynamic> _$CommunityPromotionToJson(CommunityPromotion instance) =>
    <String, dynamic>{
      'topic_max': instance.topic_max,
      'member_max': instance.member_max
    };
