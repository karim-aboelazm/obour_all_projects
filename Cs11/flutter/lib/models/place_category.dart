class PlaceCategory {
  late int id;
  late String name;
  late String icon;

  PlaceCategory({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory PlaceCategory.fromJson(Map<String, dynamic> json) {
    return PlaceCategory(
      id: json["id"],
      name: json["name"],
      icon: json["icon"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "icon": this.icon,
    };
  }
}
