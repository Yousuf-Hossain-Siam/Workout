import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/features/tips_tab/controllers/article_controller.dart';
import 'package:luna_3/features/tips_tab/models/article_model.dart';

class UploadNewTipsController extends GetxController {
  late GlobalKey<FormState> formKey;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final embeddedMediaController = TextEditingController();
  final tagsController = TextEditingController();
  final List<String> tags = [];
  String? selectedFileType;
  String? selectedFilePath;

  void addTag(String tag) {
    if (tag.isNotEmpty) {
      final newTags =
          tag
              .split(',')
              .map((t) => t.trim())
              .where((t) => t.isNotEmpty && !tags.contains(t))
              .toList();
      tags.addAll(newTags);
      // tagsController.clear();
      update();
    }
  }

  void removeTag(String tag) {
    tags.remove(tag);
    update();
  }

  void setFileType(String type) {
    selectedFileType = type;
    update();
  }

  void setFilePath(String path) {
    selectedFilePath = path;
    update();
  }

  bool validateForm() {
    if (!formKey.currentState!.validate()) return false;
    if (selectedFilePath == null) {
      Get.snackbar('Error', 'Please select an image or video');
      return false;
    }
    return true;
  }

  void submitTip() {
    if (!validateForm()) return;

    final articleController = Get.find<ArticleController>();
    final newArticle = ArticleModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      category: tags.first.toUpperCase(),
      title: titleController.text,
      description: descriptionController.text,
      imageUrl: selectedFilePath,
      likes: 0,
      isFavorite: false,
      isSaved: false,
    );

    articleController.addArticle(newArticle);

    Get.back();
    Get.snackbar('Success', 'Tip uploaded successfully');
  }

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    embeddedMediaController.dispose();
    tagsController.dispose();
    super.onClose();
  }
}
