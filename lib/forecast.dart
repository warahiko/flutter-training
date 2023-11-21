enum Forecast {
  sunny(image: 'assets/sunny.svg'),
  cloudy(image: 'assets/cloudy.svg'),
  rainy(image: 'assets/rainy.svg'),
  ;

  const Forecast({
    required this.image,
  });

  factory Forecast.from(String name) {
    return Forecast.values.singleWhere(
          (element) => element.name == name,
      orElse: () => throw Exception('No enum value for `$name`.'),
    );
  }

  final String image;
}
