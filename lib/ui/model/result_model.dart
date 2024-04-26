class ResultModel {
  final double height;
  final double weight;
  final int age;
  double bmiResult;
  final DateTime date;

  ResultModel(
      {required this.height,
      required this.weight,
      required this.age,
      required this.date,
      required this.bmiResult});
}
