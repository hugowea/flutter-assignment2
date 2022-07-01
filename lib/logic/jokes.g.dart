part of 'jokes.dart';

Jokes _$JokesFromJson(Map<String, dynamic> json) => Jokes(
      createdAt: json['createdAt'] as String?,
      iconUrl: json['iconUrl'] as String?,
      id: json['id'] as String?,
      updatedAt: json['updatedAt'] as String?,
      url: json['url'] as String?,
      value: json['value'] as String,
    );

Map<String, dynamic> _$JokesToJson(Jokes instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'iconUrl': instance.iconUrl,
      'id': instance.id,
      'updatedAt': instance.updatedAt,
      'url': instance.url,
      'value': instance.value,
    };
