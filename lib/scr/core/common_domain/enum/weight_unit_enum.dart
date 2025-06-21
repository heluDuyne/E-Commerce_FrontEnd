enum WeightUnitEnum {
  kg('Kilogram', 'kg'),
  g('Gram', 'g'),
  lb('Pound', 'lb'),
  oz('Ounce', 'oz');

  final String name;
  final String code;

  const WeightUnitEnum(this.name, this.code);

  String get getWeightUnitName => name;
  String get getWeightUnitCode => code;
}