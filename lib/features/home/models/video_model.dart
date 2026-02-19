class VideoModel {
  //modelo de objeto que criara
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String channelTitle;

  //construtor
  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.channelTitle,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    //pega um  json e tranforma em um objeto
    return VideoModel(
      id: json['id']['videoId'] ?? '', //?? para caso nulo nao quebre
      title: json['snippet']['title'] ?? '',
      description: json['snippet']['description'] ?? '',
      thumbnail: json['snippet']['thumbnails']['high']['url'] ?? '',
      channelTitle: json['snippet']['channelTitle'] ?? '',
    );
  }
}
