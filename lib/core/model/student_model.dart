class StudentModel {
  final String name;
  final String grade;
  final String PublicOrAlAzhar;
  final String phone;
  final String guardianPhone;
  final String city;
  final String WhichGrade;

  StudentModel({
    required this.name,
    required this.grade,
    required this.PublicOrAlAzhar,
    required this.phone,
    required this.guardianPhone,
    required this.city, required this.WhichGrade,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      name: map['name'] ?? '',
      grade: map['grade'] ?? '',
      PublicOrAlAzhar: map['PublicOrAlAzhar'] ?? '',
      phone: map['phone'] ?? '',
      guardianPhone: map['guardianPhone'] ?? '',
      city: map['city'] ?? '',
      WhichGrade: map['WhichGrade']??'',
    );
  }
}
