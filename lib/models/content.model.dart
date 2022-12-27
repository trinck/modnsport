import 'dart:ffi';

import 'package:modnsport/repositories/uri/ModelType.dart';

class Content extends ModelType<Content>{
  Content({
    required this.data,
    required this.meta,

  });

  late final List<Data> data;
  late final Meta meta;

  Content.fromJson(super.json) : super.fromJson()
  {

    data =List.from((json!['data']).map((e) => Data.fromJson(e)).toList());
    meta = Meta.fromJson(json!['meta']);
  }


  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.attributes,
  });

  late final int id;
  late final Attributes attributes;

  Data.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    attributes = Attributes.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes.toJson();
    return _data;
  }
}

class Attributes {
  Attributes(
      {required this.imageName,
        required this.imageNameFr,
        required this.nameArFr,
        required this.createdAt,
        required this.updatedAt,
        required this.publishedAt,
        required this.pageNumber,
        required this.image,
        required this.lesson,
        required this.imageSong});

  late final String imageName;
  late final String nameArFr;
  late final String imageNameFr;
  late final String createdAt;
  late final String updatedAt;
  late final String publishedAt;
  late final int pageNumber;
  late final Image image;
  late final Lesson lesson;
  late final ImageSong imageSong;

  Attributes.fromJson(Map<String, dynamic> json) {

    imageName = json['imageName'];
    nameArFr = json['nameArFr'];
    imageNameFr = json['imageNameFr'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    pageNumber = json['pageNumber'];
    image =  (json['image'] == null)? Image(data:[]): Image.fromJson(json['image']) ;
    lesson = json['lesson']== null? Lesson(data: DataLesson()) :Lesson.fromJson(json['lesson']);
    imageSong = json['imageSong']== null? ImageSong(data: []) :ImageSong.fromJson(json['imageSong']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['imageName'] = imageName;
    _data['nameArFr'] = nameArFr;
    _data['imageNameFr'] = imageNameFr;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['publishedAt'] = publishedAt;
    _data['pageNumber'] = pageNumber;
    _data['image'] = image.toJson();
    _data['lesson'] = lesson.toJson();
    _data['imageSong'] = imageSong.toJson();
    return _data;
  }
}

class Image {
  Image({
    required this.data,
  });

  late final List<DataImage> data;

  Image.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => DataImage.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataImage {
  DataImage({
    required this.id,
    required this.attributes,
  });

  late final int id;
  late final AttributesImage attributes;

  DataImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = AttributesImage.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes.toJson();
    return _data;
  }
}

class AttributesImage {
  AttributesImage({
    required this.name,
    required this.alternativeText,
    required this.caption,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.provider,
    required this.createdAt,
    required this.updatedAt,
  });

  late final String name;
  late final String alternativeText;
  late final String caption;
  late final String hash;
  late final String ext;
  late final String mime;
  late final double size;
  late final String url;
  late final String provider;
  late final String createdAt;
  late final String updatedAt;

  AttributesImage.fromJson(Map<String, dynamic> json) {
    name = json['name']!;
    alternativeText = json['alternativeText']!;
    caption = json['caption']!;
    hash = json['hash']!;
    ext = json['ext']!;
    mime = json['mime']!;
    size = json['size']!.toDouble();
    url = json['url']!;
    provider = json['provider']!;
    createdAt = json['createdAt']!;
    updatedAt = json['updatedAt']!;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['alternativeText'] = alternativeText;
    _data['caption'] = caption;
    _data['hash'] = hash;
    _data['ext'] = ext;
    _data['mime'] = mime;
    _data['size'] = size;
    _data['url'] = url;
    _data['provider'] = provider;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}

class Lesson {
  Lesson({
    required this.data,
  });

  late final DataLesson data;

  Lesson.fromJson(Map<String, dynamic> json) {
    data = DataLesson.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class DataLesson {
  DataLesson({
     this.id,
     this.attributes,
  });

  late final int? id;
  late final AttributesLesson? attributes;

  DataLesson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = AttributesLesson.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes!.toJson();
    return _data;
  }
}

class AttributesLesson {
  AttributesLesson({
    required this.title,
    required this.started,
    required this.locked,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  late final String title;
  late final bool started;
  late final bool locked;
  late final String createdAt;
  late final String updatedAt;
  late final String publishedAt;

  AttributesLesson.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    started = json['started'];
    locked = json['locked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['started'] = started;
    _data['locked'] = locked;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['publishedAt'] = publishedAt;
    return _data;
  }
}

class ImageSong {
  ImageSong({
    required this.data,
  });

  late final List<DataSong> data;

  ImageSong.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => DataSong.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DataSong {
  DataSong({
    required this.id,
    required this.attributes,
  });

  late final int id;
  late final AttributesSong attributes;

  DataSong.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = AttributesSong.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['attributes'] = attributes.toJson();
    return _data;
  }
}

class AttributesSong {
  AttributesSong({
    required this.name,
    required this.alternativeText,
    required this.caption,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.provider,
    required this.createdAt,
    required this.updatedAt,
  });

  late final String name;
  late final String alternativeText;
  late final String caption;
  late final String hash;
  late final String ext;
  late final String mime;
  late final double size;
  late final String url;
  late final String provider;
  late final String createdAt;
  late final String updatedAt;

  AttributesSong.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    alternativeText = json['alternativeText'];
    caption = json['caption'];
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    size = json['size'].toDouble();
    url = json['url'];
    provider = json['provider'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['alternativeText'] = alternativeText;
    _data['caption'] = caption;
    _data['hash'] = hash;
    _data['ext'] = ext;
    _data['mime'] = mime;
    _data['size'] = size;
    _data['url'] = url;
    _data['provider'] = provider;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}

class ProviderMetadata {
  ProviderMetadata({
    required this.publicId,
    required this.resourceType,
  });

  late final String publicId;
  late final String resourceType;

  ProviderMetadata.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    resourceType = json['resource_type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['public_id'] = publicId;
    _data['resource_type'] = resourceType;
    return _data;
  }
}

class Meta {
  Meta({
    required this.pagination,
  });

  late final Pagination pagination;

  Meta.fromJson(Map<String, dynamic> json) {

    pagination = json.isEmpty? Pagination(page: 0, pageSize: 0, pageCount: 0, total: 0): Pagination.fromJson(json['pagination']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pagination'] = pagination.toJson();
    return _data;
  }
}

class Pagination {
  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  late final int page;
  late final int pageSize;
  late final int pageCount;
  late final int total;

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['page'] = page;
    _data['pageSize'] = pageSize;
    _data['pageCount'] = pageCount;
    _data['total'] = total;
    return _data;
  }
}
