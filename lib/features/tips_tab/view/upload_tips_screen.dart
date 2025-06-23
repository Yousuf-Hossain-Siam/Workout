import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luna_3/core/common/styles/global_text_style.dart';
import 'package:luna_3/core/common/widgets/app_bar_widget.dart';
import 'package:luna_3/core/common/widgets/custom_bottom_nav_bar.dart';
import 'package:luna_3/core/utils/constants/svg_path.dart';
import 'package:luna_3/features/tips_tab/controllers/upload_new_tips_controller.dart';
import 'package:luna_3/features/tips_tab/widgets/custom_text_field.dart';

class UploadTipsScreen extends StatelessWidget {
  const UploadTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Upload New Tip", showNotification: true),
      body: const _UploadTipsBody(),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

class _UploadTipsBody extends StatefulWidget {
  const _UploadTipsBody();

  @override
  State<_UploadTipsBody> createState() => _UploadTipsBodyState();
}

class _UploadTipsBodyState extends State<_UploadTipsBody> {
  final controller = Get.put(UploadNewTipsController());
  final _imagePicker = ImagePicker();

  Future<void> _pickFile(String type) async {
    final XFile? file =
        await (type == 'image'
            ? _imagePicker.pickImage(source: ImageSource.gallery)
            : _imagePicker.pickVideo(source: ImageSource.gallery));

    if (file != null) {
      controller.setFileType(type);
      controller.setFilePath(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text('Title', style: AppTextStyle.f18W400()),
              const SizedBox(height: 8),
              CustomTextField(
                controller: controller.titleController,
                hintText: 'enter the title of the tip',
                validator:
                    (value) =>
                        value?.isEmpty == true ? 'Title is required' : null,
              ),
              const SizedBox(height: 20),
              Text('Description', style: AppTextStyle.f18W400()),
              const SizedBox(height: 8),
              CustomTextField(
                controller: controller.descriptionController,
                hintText: 'provide a detailed description or content',
                maxLines: 5,
                validator:
                    (value) =>
                        value?.isEmpty == true
                            ? 'Description is required'
                            : null,
              ),
              const SizedBox(height: 20),
              _buildDropdownField(),
              const SizedBox(height: 20),
              Text('Embedded Media (Optional)', style: AppTextStyle.f18W400()),
              const SizedBox(height: 8),
              CustomTextField(
                controller: controller.embeddedMediaController,
                hintText: 'enter media link or embed code',
                willValidate: false,
                suffixIcon: Transform.scale(
                  scale: 0.5,
                  child: SvgPicture.asset(
                    SvgPath.closeTag,
                    colorFilter: ColorFilter.mode(
                      const Color(0xFFEAFF55),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Tag', style: AppTextStyle.f18W400()),
              const SizedBox(height: 8),
              CustomTextField(
                controller: controller.tagsController,
                hintText: 'enter tags separated by commas',
                onFieldSubmitted: (value) => controller.addTag(value),
                onChange: (value) {
                  if (value.endsWith(',')) {
                    controller.addTag(value.substring(0, value.length - 1));
                  }
                },
                validator:
                    (value) =>
                        controller.tags.isEmpty
                            ? 'At least one tag is required'
                            : null,
              ),
              GetBuilder<UploadNewTipsController>(
                builder:
                    (controller) => Wrap(
                      spacing: 8,
                      children:
                          controller.tags
                              .map(
                                (tag) => Chip(
                                  label: Text(tag),
                                  onDeleted: () => controller.removeTag(tag),
                                ),
                              )
                              .toList(),
                    ),
              ),
              const SizedBox(height: 30),
              _buildSubmitButton(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return GetBuilder<UploadNewTipsController>(
      builder:
          (controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select File Type', style: AppTextStyle.f18W400()),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF121400),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF13251A)),
                ),
                child: PopupMenuButton<String>(
                  onSelected: (type) => _pickFile(type),
                  itemBuilder:
                      (context) => [
                        const PopupMenuItem(
                          value: 'image',
                          child: Text('Image'),
                        ),
                        const PopupMenuItem(
                          value: 'video',
                          child: Text('Video'),
                        ),
                      ],
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.selectedFilePath != null
                              ? 'File selected'
                              : 'choose an image/video to upload',
                          style: TextStyle(
                            color:
                                controller.selectedFilePath != null
                                    ? Colors.white
                                    : Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: SvgPicture.asset(
                            SvgPath.uploadIcon,
                            colorFilter: ColorFilter.mode(
                              const Color(0xFFEAFF55),
                              BlendMode.srcIn,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => controller.submitTip(),
        child: const Text("Submit Tip", style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
