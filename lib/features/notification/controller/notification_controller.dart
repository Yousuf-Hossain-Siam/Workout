import 'package:get/get.dart';

class NotificationController extends GetxController {
  var items =
      <Map<String, String>>[
        {
          'title': 'Eat more protein',
          'subtitle':
              'Hit my protein goal at least 3 days this week. Feed your muscles, skin, and bone health.',
          'time': '10:00 PM',
        },
        {
          'title': 'Eat more protein',
          'subtitle':
              'Hit my protein goal at least 3 days this week. Feed your muscles, skin, and bone health.',
          'time': '10:00 PM',
        },
        {
          'title': 'Eat more protein',
          'subtitle':
              'Hit my protein goal at least 3 days this week. Feed your muscles, skin, and bone health.',
          'time': '10:00 PM',
        },
        {
          'title': 'Eat more protein',
          'subtitle':
              'Hit my protein goal at least 3 days this week. Feed your muscles, skin, and bone health.',
          'time': '10:00 PM',
        },
        {
          'title': 'Eat more protein',
          'subtitle':
              'Hit my protein goal at least 3 days this week. Feed your muscles, skin, and bone health.',
          'time': '10:00 PM',
        },
        {
          'title': 'Eat more protein',
          'subtitle':
              'Hit my protein goal at least 3 days this week. Feed your muscles, skin, and bone health.',
          'time': '10:00 PM',
        },
        {
          'title': 'Eat more protein',
          'subtitle':
              'Hit my protein goal at least 3 days this week. Feed your muscles, skin, and bone health.',
          'time': '10:00 PM',
        },
        {
          'title': 'Eat more protein',
          'subtitle':
              'Hit my protein goal at least 3 days this week. Feed your muscles, skin, and bone health.',
          'time': '10:00 PM',
        },
        {
          'title': 'Eat more protein',
          'subtitle':
              'Hit my protein goal at least 3 days this week. Feed your muscles, skin, and bone health.',
          'time': '10:00 PM',
        },
        {
          'title': 'Eat more protein',
          'subtitle':
              'Hit my protein goal at least 3 days this week. Feed your muscles, skin, and bone health.',
          'time': '10:00 PM',
        },
        {
          'title': 'Eat more protein',
          'subtitle':
              'Hit my protein goal at least 3 days this week. Feed your muscles, skin, and bone health.',
          'time': '10:00 PM',
        },
        {
          'title': 'Eat more protein',
          'subtitle':
              'Hit my protein goal at least 3 days this week. Feed your muscles, skin, and bone health.',
          'time': '10:00 PM',
        },
        {
          'title': 'Eat more protein',
          'subtitle':
              'Hit my protein goal at least 3 days this week. Feed your muscles, skin, and bone health.',
          'time': '10:00 PM',
        },
      ].obs;

  var swipeOffsets = <double>[].obs;
  @override
  void onInit() {
    super.onInit();
    swipeOffsets.assignAll(List.filled(items.length, 0.0));
  }

  void updateOffset(int index, double offset) {
    if (index < swipeOffsets.length) {
      swipeOffsets[index] = offset;
      swipeOffsets.refresh();
    }
  }

  void resetOffset(int index) {
    updateOffset(index, 0.0);
  }

  void revealDelete(int index) {
    updateOffset(index, -37);
  }

  void deleteItem(int index) {
    items.removeAt(index);
    swipeOffsets.removeAt(index);
  }
}
