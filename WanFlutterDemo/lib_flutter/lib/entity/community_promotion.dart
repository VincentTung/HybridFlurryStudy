import 'package:json_annotation/json_annotation.dart';
// user.g.dart 将在我们运行生成命令后自动生成
part 'community_promotion.g.dart';
@JsonSerializable()
class CommunityPromotion{
  CommunityPromotion();
  num topic_max;
  num member_max;

  factory CommunityPromotion.fromJson(Map<String, dynamic> json) => _$CommunityPromotionFromJson(json);
  Map<String, dynamic> toJson() => _$CommunityPromotionToJson(this);

}