enum Weather {
  sunny(image: 'assets/sunny.svg'),
  cloudy(image: 'assets/cloudy.svg'),
  rainy(image: 'assets/rainy.svg'),
  ;

  const Weather({
    required this.image,
  });

  factory Weather.from(String name) {
    return Weather.values.singleWhere(
      (element) => element.name == name,
      orElse: () => throw Exception('No enum value for `$name`.'),
    );
  }

  final String image;
}
