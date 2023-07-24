class City {
  var id;
  var name;
  var nick_name;
  var main_Image;
  var area;
  var info;
  var location_text;

// Location location;

  City({
    required this.id,
    required this.name,
    required this.nick_name,
    required this.main_Image,
    required this.area,
    required this.info,
    required this.location_text,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json["id"],
      name: json["name"],
      nick_name: json["nick_name"],
      main_Image: json["main_Image"],
      area: json["area"],
      info: json["info"],
      location_text: json["location_text"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "nick_name": this.nick_name,
      "main_Image": this.main_Image,
      "area": this.area,
      "info": this.info,
      "location_text": this.location_text,
    };
  }
}
