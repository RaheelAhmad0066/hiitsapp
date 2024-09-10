import 'dart:convert';

class CustomWorkTimeTrack {
  //modal class for Person object
  String name;
  // ,
  //  totaltime;
  // String
  int rest_minutes,
      rest_seconds,
      cool_down_minutes,
      cool_down_seconds,
      work_minutes,
      work_seconds,
      total_rounds,
      total_sets,
      totaltime,
      total_hours;

  CustomWorkTimeTrack(
      {required this.rest_minutes,
      required this.rest_seconds,
      required this.cool_down_minutes,
      required this.cool_down_seconds,
      required this.work_minutes,
      required this.work_seconds,
      required this.name,
      required this.total_rounds,
      required this.total_sets,
      required this.totaltime,
      required this.total_hours});

  factory CustomWorkTimeTrack.fromJson(String source) =>
      CustomWorkTimeTrack.fromMap(json.decode(source));

  factory CustomWorkTimeTrack.fromMap(Map<String, dynamic> map) {
    return CustomWorkTimeTrack(
        rest_minutes: map['rest_minutes'] ?? 0,
        rest_seconds: map['rest_seconds'] ?? 0,
        cool_down_minutes: map['cool_down_minutes'] ?? 0,
        cool_down_seconds: map['cool_down_seconds'] ?? 0,
        work_minutes: map['work_minutes'] ?? 0,
        work_seconds: map['work_seconds'] ?? 0,
        name: map['name'] ?? "",
        total_rounds: map['total_rounds'] ?? 0,
        total_sets: map['total_sets'] ?? 0,
        totaltime: map['totaltime'],
        total_hours: map['totalHours'] ?? 0);
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      "rest_minutes": rest_minutes,
      "rest_seconds": rest_seconds,
      "cool_down_minutes": cool_down_minutes,
      "cool_down_seconds": cool_down_seconds,
      "work_minutes": work_minutes,
      "work_seconds": work_seconds,
      "name": name,
      "total_rounds": total_rounds,
      "total_sets": total_sets,
      "totaltime": totaltime,
      "total_hours": total_hours
    };
  }

  // static fromJson(String todoJson) {}
}
