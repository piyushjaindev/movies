class MovieVideo {
  String id;
  String name;
  String type;

  MovieVideo({this.id, this.type, this.name});

  MovieVideo.fromJSON(var json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }
}
