import 'package:get/get.dart';

class WorkoutController extends GetxController {
  var sets = <Map<String, dynamic>>[].obs;
  var restTime = 60.obs;
  var activeStartIndices = <int>{}.obs;
  var timerKey = 0.obs; // for triggering the timer reset

  void addSet() {
    sets.add({
      'SET': (sets.length + 1).toString(),
      'KG': '0',
      'REPS': '0',
      'STARTED': false,
    });
  }

  void updateKG(int index, String value) {
    sets[index]['KG'] = value;
    sets.refresh();
  }

  void updateReps(int index, String value) {
    sets[index]['REPS'] = value;
    sets.refresh();
  }

  void toggleStart(int index) {
    if (activeStartIndices.contains(index)) {
      activeStartIndices.remove(index);
    } else {
      activeStartIndices.add(index);
    }

    // Reset timer on every tap
    timerKey.value++; 
  }

  bool isStarted(int index) => activeStartIndices.contains(index);
}
