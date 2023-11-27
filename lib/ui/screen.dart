enum Screen {
  main(route: '/main'),
  splash(route: '/splash'),
  ;

  const Screen({
    required this.route,
  });

  final String route;
}
