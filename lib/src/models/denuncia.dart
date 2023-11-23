class Denuncia {
  final String date;
  final String hour;
  final String description;
  final double latitude;
  final double longitude;
  final String image_url;

  Denuncia(this.date, this.hour, this.description, this.latitude,
      this.longitude, this.image_url);

  factory Denuncia.fromJson(Map<String, dynamic> json) {
    final String date = json['date'];
    final String hour = json['hour'];
    final String description = json['description'];
    final double latitude = json['latitude'];
    final double longitude = json['longitude'];
    final String image_url = json['image_url'];

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
