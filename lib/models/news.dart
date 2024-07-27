class News {
  final String title;
  final String source;
  final String urlToImage;
  final String time;
  final String author;
  final String description;
  final String content;
  final String url;

  News({
    required this.title,
    required this.source,
    required this.urlToImage,
    required this.time,
    required this.author,
    required this.description,
    required this.content,
    required this.url,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? 'No title',
      source: json['source']['name'] ?? 'No source',
      urlToImage: json['urlToImage'] ??
          'https://play-lh.googleusercontent.com/_ahCmEdTn8h5omlAg0jg9Y15KArlptm4qcbnyWSzGU-jM4mR1LeArqbMM7DzgZjNywO2',
      time: json['publishedAt'],
      author: json['author'].toString(),
      description: json['description'].toString(),
      content: json['content'].toString(),
      url: json['url'].toString(),
    );
  }
}
