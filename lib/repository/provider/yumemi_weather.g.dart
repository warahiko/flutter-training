// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'yumemi_weather.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$yumemiWeatherHash() => r'60e3e1a36fb4a27ee07aa44531ee1f0e1df18907';

/// See also [yumemiWeather].
@ProviderFor(yumemiWeather)
final yumemiWeatherProvider = AutoDisposeProvider<YumemiWeather>.internal(
  yumemiWeather,
  name: r'yumemiWeatherProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$yumemiWeatherHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef YumemiWeatherRef = AutoDisposeProviderRef<YumemiWeather>;
String _$syncFetchWeatherHash() => r'8344658bae5ded7d155147f1dcf6126d9f11a46c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [syncFetchWeather].
@ProviderFor(syncFetchWeather)
const syncFetchWeatherProvider = SyncFetchWeatherFamily();

/// See also [syncFetchWeather].
class SyncFetchWeatherFamily extends Family<AsyncValue<Forecast>> {
  /// See also [syncFetchWeather].
  const SyncFetchWeatherFamily();

  /// See also [syncFetchWeather].
  SyncFetchWeatherProvider call({
    required String area,
    required DateTime dateTime,
  }) {
    return SyncFetchWeatherProvider(
      area: area,
      dateTime: dateTime,
    );
  }

  @override
  SyncFetchWeatherProvider getProviderOverride(
    covariant SyncFetchWeatherProvider provider,
  ) {
    return call(
      area: provider.area,
      dateTime: provider.dateTime,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'syncFetchWeatherProvider';
}

/// See also [syncFetchWeather].
class SyncFetchWeatherProvider extends AutoDisposeFutureProvider<Forecast> {
  /// See also [syncFetchWeather].
  SyncFetchWeatherProvider({
    required String area,
    required DateTime dateTime,
  }) : this._internal(
          (ref) => syncFetchWeather(
            ref as SyncFetchWeatherRef,
            area: area,
            dateTime: dateTime,
          ),
          from: syncFetchWeatherProvider,
          name: r'syncFetchWeatherProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$syncFetchWeatherHash,
          dependencies: SyncFetchWeatherFamily._dependencies,
          allTransitiveDependencies:
              SyncFetchWeatherFamily._allTransitiveDependencies,
          area: area,
          dateTime: dateTime,
        );

  SyncFetchWeatherProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.area,
    required this.dateTime,
  }) : super.internal();

  final String area;
  final DateTime dateTime;

  @override
  Override overrideWith(
    FutureOr<Forecast> Function(SyncFetchWeatherRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SyncFetchWeatherProvider._internal(
        (ref) => create(ref as SyncFetchWeatherRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        area: area,
        dateTime: dateTime,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Forecast> createElement() {
    return _SyncFetchWeatherProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SyncFetchWeatherProvider &&
        other.area == area &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, area.hashCode);
    hash = _SystemHash.combine(hash, dateTime.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SyncFetchWeatherRef on AutoDisposeFutureProviderRef<Forecast> {
  /// The parameter `area` of this provider.
  String get area;

  /// The parameter `dateTime` of this provider.
  DateTime get dateTime;
}

class _SyncFetchWeatherProviderElement
    extends AutoDisposeFutureProviderElement<Forecast>
    with SyncFetchWeatherRef {
  _SyncFetchWeatherProviderElement(super.provider);

  @override
  String get area => (origin as SyncFetchWeatherProvider).area;
  @override
  DateTime get dateTime => (origin as SyncFetchWeatherProvider).dateTime;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
