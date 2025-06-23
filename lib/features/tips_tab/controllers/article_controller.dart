import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/features/tips_tab/models/article_model.dart';

class ArticleController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  List<ArticleModel> _allArticles = [];
  List<ArticleModel> _filteredArticles = [];
  List<ArticleModel> _savedArticles = [];

  List<ArticleModel> get articles => _filteredArticles;
  List<ArticleModel> get savedArticles => _savedArticles;

  @override
  void onInit() {
    super.onInit();
    _allArticles = [
      ArticleModel(
        id: "1",
        category: "STRENGTH",
        title: "Perfect Your Squat Form",
        description:
            "Master the fundamentals of squatting with these essential tips for proper form and technique.",
        imageUrl: "https://picsum.photoss/id/355/355/187",
        likes: 15,
        isFavorite: true,
        isSaved: false,
      ),
      ArticleModel(
        id: "2",
        category: "NUTRITION",
        title: "Balanced Meal Planning",
        description:
            "Include protein, carbs, and healthy fats in every meal for sustained energy.",
        imageUrl: "https://picsum.photoss/id/187/355/187",
        likes: 20,
        isFavorite: false,
        isSaved: true,
      ),
    ];
    _savedArticles = _allArticles.where((element) => element.isSaved).toList();
    _filteredArticles = _allArticles;
    update();
  }

  void searchArticles(String query, {bool? isSaved = false}) {
    List<ArticleModel> sourceList =
        isSaved == true ? _savedArticles : _allArticles;

    if (query.isEmpty) {
      _filteredArticles = sourceList;
    } else {
      _filteredArticles =
          sourceList
              .where(
                (article) =>
                    article.title.toLowerCase().contains(query.toLowerCase()) ||
                    article.description!.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
              )
              .toList();
    }
    update();
  }

  void toggleFavorite(String id) {
    final index = _filteredArticles.indexWhere((element) => element.id == id);
    if (index != -1) {
      _filteredArticles[index].isFavorite =
          !_filteredArticles[index].isFavorite;
      _filteredArticles[index].likes =
          _filteredArticles[index].isFavorite
              ? _filteredArticles[index].likes + 1
              : _filteredArticles[index].likes - 1;
      update();
    }
  }

  void toggleSaved(String id) {
    final index = _allArticles.indexWhere((element) => element.id == id);
    if (index != -1) {
      _allArticles[index].isSaved = !_allArticles[index].isSaved;
      _savedArticles =
          _allArticles.where((element) => element.isSaved).toList();

      update();
    }
  }

  void addArticle(ArticleModel article) {
    _allArticles.add(article);
    _filteredArticles = _allArticles;
    update();
  }
}
