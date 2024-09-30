class SourceModel {
  String? id;
  String? name;

  SourceModel({this.id, this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ArticleModel {
  String? author;
  String? content;
  String? description;
  String? publishedAt;
  String? title;
  String? url;
  String? urlToImage;
  SourceModel? source;

  ArticleModel(
      {this.title,
      this.description,
      this.author,
      this.url,
      this.content,
      this.publishedAt,
      this.source,
      this.urlToImage});

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
        title: json['title'],
        description: json['description'],
        urlToImage: json['urlToImage'],
        author: json['author'],
        url: json['url'],
        content: json['content'],
        publishedAt: json['publishedAt'],
        source: SourceModel.fromJson(json['source']));
  }
}

class NewsDataModel {
  String? status;
  int? totalResults;
  List<ArticleModel>? articles;

  NewsDataModel({this.status, this.articles, this.totalResults});

  factory NewsDataModel.fromJson(Map<String, dynamic> json) {

    List<ArticleModel> allArticles = [];
    for (Map<String, dynamic> eachArticle in json['articles']) {
      allArticles.add(ArticleModel.fromJson(eachArticle));
    }
    return NewsDataModel(
      articles: allArticles,
      status: json['status'],
      totalResults: json['totalResults'],
    );
  }
}
