import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/test.dart';

// https://riverpod.dev/docs/essentials/testing#unit-tests
ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  addTearDown(container.dispose);

  return container;
}
