// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
      id: json['_id'] as String,
      createdAt: json['createdAt'] as String,
      desc: json['desc'] as String,
      images: (json['images'] as List)?.map((e) => e as String)?.toList(),
      publishedAt: json['publishedAt'] as String,
      source: json['source'] as String,
      type: json['type'] as String,
      url: json['url'] as String,
      used: json['used'] as bool,
      who: json['who'] as String);
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      '_id': instance.id,
      'createdAt': instance.createdAt,
      'desc': instance.desc,
      'images': instance.images,
      'publishedAt': instance.publishedAt,
      'source': instance.source,
      'type': instance.type,
      'url': instance.url,
      'used': instance.used,
      'who': instance.who
    };
