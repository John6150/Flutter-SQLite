class StudentModel {
  final String name;
  final String studentID;
  final String course;

  const StudentModel({
    required this.name,
    required this.studentID,
    required this.course,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    name: json['name'],
    studentID: json['studentID'].toString(),
    course: json['course'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'studentID': studentID.toString(),
    'course': course,
  };
}
