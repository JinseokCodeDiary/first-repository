class Photo{
  final String id;
  final String url;
  final String title;

  Photo({required this.id, required this.url, required this.title});

  @override
  String toString() {
    return 'Photo(id: $id, url: $url, title: $title)';
  }
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      url: json['url'],
      title: json['ematitleil'],
    );
  }
}