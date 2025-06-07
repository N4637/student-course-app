class Course {
  final String course_code;
  final String course_name;
  final int credits;

  Course({
    required this.course_code,
    required this.course_name,
    required this.credits,
  });

  factory Course.fromJson(Map<String, dynamic> data) {
    print("Course JSON: $data");
    return Course(
      course_code: data['course_code'],
      course_name: data['course_name'],
      credits: data['credits'],
    );
  }

  Map<String, dynamic> toJson() {
    return{
      'course_code': course_code,
      'course_name': course_name,
      'credits': credits,
    };
  }
}