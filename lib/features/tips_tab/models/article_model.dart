
class ArticleModel {
  final String id;
  String category;
  String title;
  String? description;
  String? imageUrl;
  String? videoUrl;
  String? embeddedUrlOrCode;
  int likes;
  bool isFavorite;
  bool isSaved;

  ArticleModel({
    required this.id,
    required this.category,
    required this.title,
    this.description,
    this.imageUrl,
    this.videoUrl,
    this.embeddedUrlOrCode,
    this.likes = 0,
    this.isFavorite = false,
    this.isSaved = false,
  });
}
