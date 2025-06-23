import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/features/tips_tab/models/article_model.dart';

class VideoController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  // Original list that never gets modified
  final List<ArticleModel> _originalArticles = [];
  // Working copy that gets filtered
  List<ArticleModel> _allArticles = [];
  List<ArticleModel> _savedArticles = [];

  List<ArticleModel> get articles => _allArticles;
  List<ArticleModel> get savedArticles => _savedArticles;

  @override
  void onInit() {
    super.onInit();
    _originalArticles.addAll([
      ArticleModel(
        id: "1",
        category: "STRENGTH",
        title: "Perfect Your Squat Form",
        description:
            "Master the fundamentals of squatting with these essential tips for proper form and technique.",
        videoUrl:
            'https://videos.pexels.com/video-files/9244502/9244502-hd_1920_1080_25fps.mp4',
        likes: 234,
        isFavorite: false,
        isSaved: false,
      ),
      ArticleModel(
        id: "2",
        category: "CARDIO",
        title: "HIIT Workout Guide",
        description:
            "High-intensity interval training for maximum calorie burn and endurance.",
        videoUrl:
            'https://videos.pexels.com/video-files/30607101/13104809_1920_1080_25fps.mp4',
        likes: 142,
        isFavorite: true,
        isSaved: false,
      ),
      ArticleModel(
        id: "3",
        category: "NUTRITION",
        title: "Healthy Meal Prep",
        description:
            "Quick and easy meal preparation tips for a balanced diet.",
        videoUrl:
            'https://videos.pexels.com/video-files/32099814/13684576_2560_1440_30fps.mp4',
        likes: 189,
        isFavorite: false,
        isSaved: true,
      ),
      ArticleModel(
        id: "4",
        category: "YOGA",
        title: "Morning Yoga Flow",
        description:
            "Start your day with this energizing 15-minute yoga sequence.",
        videoUrl:
            'https://videos.pexels.com/video-files/28800682/12480980_1920_1080_30fps.mp4',
        likes: 321,
        isFavorite: false,
        isSaved: true,
      ),
    ]);

    // Initialize working copies
    _allArticles = List.from(_originalArticles);
    _savedArticles = _allArticles.where((element) => element.isSaved).toList();

    update();
  }

  void searchVideos(String query, {bool? isSaved = false}) {
    if (query.isEmpty) {
      // When search is cleared, restore original videos
      _allArticles =
          isSaved == true
              ? List.from(_savedArticles)
              : List.from(_originalArticles);
    } else {
      // Filter videos based on search query
      final sourceList = isSaved == true ? _savedArticles : _originalArticles;
      _allArticles =
          sourceList
              .where(
                (article) =>
                    article.title.toLowerCase().contains(query.toLowerCase()) ||
                    (article.description != null &&
                        article.description!.toLowerCase().contains(
                          query.toLowerCase(),
                        )),
              )
              .toList();
    }
    update();
  }

  void toggleFavorite(String id) {
    final articleIndex = _originalArticles.indexWhere(
      (element) => element.id == id,
    );
    if (articleIndex != -1) {
      _originalArticles[articleIndex].isFavorite =
          !_originalArticles[articleIndex].isFavorite;
      _originalArticles[articleIndex].likes =
          _originalArticles[articleIndex].isFavorite
              ? _originalArticles[articleIndex].likes + 1
              : _originalArticles[articleIndex].likes - 1;

      // Update working copy
      _allArticles = List.from(_originalArticles);
    }
    update();
  }

  void toggleSave(String id) {
    final articleIndex = _originalArticles.indexWhere(
      (element) => element.id == id,
    );
    if (articleIndex != -1) {
      _originalArticles[articleIndex].isSaved =
          !_originalArticles[articleIndex].isSaved;

      // Update saved articles
      _savedArticles =
          _originalArticles.where((element) => element.isSaved).toList();
      // Update working copy
      _allArticles = List.from(_originalArticles);
    }
    update();
  }
}
