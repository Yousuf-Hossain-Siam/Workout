import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/utils/constants/colors.dart';
import 'package:luna_3/core/utils/constants/sizer.dart';
import 'package:luna_3/features/tips_tab/controllers/video_controller.dart';
import 'package:luna_3/features/tips_tab/models/article_model.dart';
import 'package:luna_3/features/tips_tab/widgets/filled_tonal_button.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({super.key, required this.articleModel});

  final ArticleModel articleModel;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.network(widget.articleModel.videoUrl!)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVideo(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategory(),
                const SizedBox(height: 10),
                _buildTitle(),
                const SizedBox(height: 8),
                _buildDescription(),
                const SizedBox(height: 16),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideo() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_isInitialized)
              VideoPlayer(_controller)
            else
              const Center(child: CircularProgressIndicator()),
            if (_isInitialized)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory() {
    return Text(
      widget.articleModel.category,
      style: getTextStyleInter(
        color: AppColors.textTitle,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.50,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.articleModel.title,
      style: getTextStyleInter(
        color: AppColors.textTitle,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.50,
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      widget.articleModel.description ?? '',
      style: getTextStyleInter(color: AppColors.textDescription),
    );
  }

  Widget _buildFooter() {
    final vidController = Get.find<VideoController>();
    return Row(
      children: [
        FilledTonalButton(
          icon: Icons.favorite_rounded,
          text: widget.articleModel.likes.toString(),
          isClicked: widget.articleModel.isFavorite,
          onClick: () {
            vidController.toggleFavorite(widget.articleModel.id);
          },
        ),
        SizedBox(width: Sizer.wp(25)),
        FilledTonalButton(
          icon: Icons.bookmark_rounded,
          text: "Save",
          isClicked: widget.articleModel.isSaved,
          onClick: () {
            vidController.toggleSave(widget.articleModel.id);
          },
        ),
      ],
    );
  }
}
