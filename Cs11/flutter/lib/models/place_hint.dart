class PlaceHint {
  var id;
  String name;
  String image;
  PlaceHint({
    required this.id,
    required this.name,
    required this.image,
  });

  factory PlaceHint.fromJson(Map<String, dynamic> json) {
    return PlaceHint(
      id: json['id'].toString(),
      name: json['name'],
      image: json['image'] ?? json['main_Image'],
    );
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
