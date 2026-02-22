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
    String videoId = ''; //para guardar o id do video

    //validando qual forma pegar o id para diferente metodo
    if (json['id'] is String) {
      //formato para o em alta
      videoId = json['id'];
    } else if (json['id'] is Map && json['id']['videoId'] != null) {
      //formato do busca
      videoId = json['id']['videoId'];
    }

    return VideoModel(
      id: videoId,
      title: json['snippet']['title'] ?? '', //?? para caso nulo nao quebre
      description: json['snippet']['description'] ?? '',
      thumbnail: json['snippet']['thumbnails']['high']['url'] ?? '',
      channelTitle: json['snippet']['channelTitle'] ?? '',
    );
  }
}
