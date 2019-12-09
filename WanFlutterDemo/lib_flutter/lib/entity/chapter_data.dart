

import 'package:json_annotation/json_annotation.dart';
import 'package:lib_flutter/entity/chapter_item.dart';

part 'chapter_data.g.dart';
@JsonSerializable()
class ChapterData{
  ChapterData();
  List<ChapterItem> data;

  factory ChapterData.fromJson(Map<String, dynamic> json) => _$ChapterDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterDataToJson(this);
}