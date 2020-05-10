class Movie {
  String title;
  int id;
  String image;
  String backgroundImage;
  String overview;

  Movie({this.id, this.title, this.image, this.overview, this.backgroundImage});

  Movie.fromJSON(var json) {
    id = json['id'];
    title = json['title'];
    image = json['poster_path'];
    backgroundImage = json['backdrop_path'];
    overview = json['overview'];
  }
}
