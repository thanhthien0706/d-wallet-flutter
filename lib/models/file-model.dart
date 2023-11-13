class FileModel {
  String fieldname;
  String originalname;
  String encoding;
  String mimetype;
  String destination;
  String filename;
  String path;
  int size;
  String url;

  FileModel(
      {required this.fieldname,
      required this.originalname,
      required this.encoding,
      required this.mimetype,
      required this.destination,
      required this.filename,
      required this.path,
      required this.size,
      required this.url});

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      fieldname: json['filename'] as String,
      originalname: json['originalname'] as String,
      encoding: json['encoding'] as String,
      mimetype: json['mimetype'] as String,
      destination: json['destination'] as String,
      filename: json['filename'] as String,
      path: json['path'] as String,
      size: json['size'] as int,
      url: json['url'] as String,
    );
  }
}
