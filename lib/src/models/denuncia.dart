class Denuncia {
  String date;
  String hour;
  String description;
  double latitude;
  double longitude;
  List<String>? image_url = [];

  Denuncia(this.date , this.hour, this.description, this.latitude,
      this.longitude, this.image_url);

  factory Denuncia.fromJson(Map<String, dynamic> json) {
    String date = json['date'];
    String hour = json['hour'];
    String description = json['description'];
    double latitude = json['latitude'];
    double longitude = json['longitude'];
    List<String> image_url = json['image_url'];

    return Denuncia(date, hour, description, latitude, longitude, image_url);
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'hour': hour,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'image_url': image_url,
      };
}
