enum Gender {
  male('Male', 'male'),
  female('Female', 'female'),
  other('Other', 'other');

  final String name;
  final String code;

  const Gender(this.name, this.code);

  String get getGenderName => name;
  String get getGenderCode => code;
}