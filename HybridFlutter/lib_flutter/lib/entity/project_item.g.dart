// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectItem _$ProjectItemFromJson(Map<String, dynamic> json) {
  return ProjectItem()
    ..apkLink = json['apkLink'] as String
    ..author = json['author'] as String
    ..chapterId = json['chapterId'] as int
    ..chapterName = json['chapterName'] as String
    ..collect = json['collect'] as bool
    ..courseId = json['courseId'] as int
    ..desc = json['desc'] as String
    ..envelopePic = json['envelopePic'] as String
    ..fresh = json['fresh'] as bool
    ..id = json['id'] as int
    ..link = json['link'] as String
    ..niceDate = json['niceDate'] as String
    ..publishTime = json['publishTime'] as num
    ..superChapterId = json['superChapterId'] as int
    ..superChapterName = json['superChapterName'] as String
    ..title = json['title'] as String
    ..type = json['type'] as int
    ..zan = json['zan'] as int;
}

Map<String, dynamic> _$ProjectItemToJson(ProjectItem instance) =>
    <String, dynamic>{
      'apkLink': instance.apkLink,
      'author': instance.author,
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName,
      'collect': instance.collect,
      'courseId': instance.courseId,
      'desc': instance.desc,
      'envelopePic': instance.envelopePic,
      'fresh': instance.fresh,
      'id': instance.id,
      'link': instance.link,
      'niceDate': instance.niceDate,
      'publishTime': instance.publishTime,
      'superChapterId': instance.superChapterId,
      'superChapterName': instance.superChapterName,
      'title': instance.title,
      'type': instance.type,
      'zan': instance.zan
    };
