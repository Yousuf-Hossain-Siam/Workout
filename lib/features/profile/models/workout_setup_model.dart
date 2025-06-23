class WorkoutSetupModel {
  final String id;
  final String userId;
  final String goal;
  final String gender;
  final int weight;
  final int age;
  final int height;
  final String dietaryPreference;
  final String exercisePreference;
  final int calorieGoal;
  final SleepQualityModel sleepQuality;

  WorkoutSetupModel({
    required this.id,
    required this.userId,
    required this.goal,
    required this.gender,
    required this.weight,
    required this.age,
    required this.height,
    required this.dietaryPreference,
    required this.exercisePreference,
    required this.calorieGoal,
    required this.sleepQuality,
  });

  // from json
  factory WorkoutSetupModel.fromJson(Map<String, dynamic> json) {
    return WorkoutSetupModel(
      id: json['_id'],
      userId: json['user_id'],
      goal: json['goal'],
      gender: json['gender'],
      weight: json['weight'],
      age: json['age'],
      height: json['height'],
      dietaryPreference: json['dietaryPreference'],
      exercisePreference: json['exercisePreference'],
      calorieGoal: json['calorieGoal'],
      sleepQuality: SleepQualityModel.fromJson(json['sleepQuality']),
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['user_id'] = this.userId;
    data['goal'] = this.goal;
    data['gender'] = this.gender;
    data['weight'] = this.weight;
    data['age'] = this.age;
    data['height'] = this.height;
    data['dietaryPreference'] = this.dietaryPreference;
    data['exercisePreference'] = this.exercisePreference;
    data['calorieGoal'] = this.calorieGoal;
    data['sleepQuality'] = this.sleepQuality.toJson();
    return data;
  }

  // copy with
  WorkoutSetupModel copyWith({
    String? id,
    String? userId,
    String? goal,
    String? gender,
    int? weight,
    int? age,
    int? height,
    String? dietaryPreference,
    String? exercisePreference,
    int? calorieGoal,
    SleepQualityModel? sleepQuality,
  }) {
    return WorkoutSetupModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      goal: goal ?? this.goal,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      age: age ?? this.age,
      height: height ?? this.height,
      dietaryPreference: dietaryPreference ?? this.dietaryPreference,
      exercisePreference: exercisePreference ?? this.exercisePreference,
      calorieGoal: calorieGoal ?? this.calorieGoal,
      sleepQuality: sleepQuality ?? this.sleepQuality,
    );
  }
}

class SleepQualityModel {
  final String quality;
  final int lowerLimit;
  final int upperLimit;
  final String id;

  SleepQualityModel({
    required this.quality,
    required this.lowerLimit,
    required this.upperLimit,
    required this.id,
  });

  factory SleepQualityModel.fromJson(Map<String, dynamic> json) {
    return SleepQualityModel(
      quality: json['quality'],
      lowerLimit: json['lowerLimit'],
      upperLimit: json['upperLimit'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quality'] = quality;
    data['lowerLimit'] = lowerLimit;
    data['upperLimit'] = upperLimit;
    data['_id'] = id;
    return data;
  }

  // copy with
  SleepQualityModel copyWith({
    String? quality,
    int? lowerLimit,
    int? upperLimit,
    String? id,
  }) {
    return SleepQualityModel(
      quality: quality ?? this.quality,
      lowerLimit: lowerLimit ?? this.lowerLimit,
      upperLimit: upperLimit ?? this.upperLimit,
      id: id ?? this.id,
    );
  }
}

var test = {
  "_id": "68522b7448fd7655f9e86f7f",
  "user_id": "6847edf9e20c705b82be9e52",
  "goal": "lose_weight",
  "gender": "male",
  "weight": 75,
  "age": 30,
  "height": 175,
  "dietaryPreference": "plant_based",
  "exercisePreference": "yoga",
  "calorieGoal": 2000,
  "sleepQuality": {
    "quality": "normal",
    "lowerLimit": 5,
    "upperLimit": 6,
    "_id": "68522b7448fd7655f9e86f80",
  },
  "__v": 0,
};
