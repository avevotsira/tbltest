
import 'dart:convert';

List<Student> studentsFromJson(String str) => List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));

String studentsToJson(List<Student> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Student {
  Student({
   required this.id,
   required this.name,
   required this.duration,
   required this.type,
  });

  int id;
  String name;
  String duration;
  String type;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["id"],
    name: json["name"],
    duration: json["duration"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "duration": duration,
    "type": type,
  };
}
Student studentFromJson(String str) => Student.fromJson(json.decode(str));
String studentToJson(Student data) => json.encode(data.toJson());
