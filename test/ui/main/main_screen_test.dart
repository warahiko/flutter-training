import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/common/provider/date_time.dart';
import 'package:flutter_training/model/forecast.dart';
import 'package:flutter_training/model/weather.dart';
import 'package:flutter_training/repository/provider/yumemi_weather_repository.dart';
import 'package:flutter_training/repository/yumemi_weather_repository.dart';
import 'package:flutter_training/ui/main/main_screen.dart';
import 'package:flutter_training/ui/main/view/forecast_view.dart';
import 'package:flutter_training/yumemi_weather_error.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'main_screen_test.mocks.dart';

@GenerateMocks([YumemiWeatherRepository])
@GenerateNiceMocks([MockSpec<NavigatorObserver>()])
void main() {
  final mockYumemiWeatherRepository = MockYumemiWeatherRepository();
  final mockNavigatorObserver = MockNavigatorObserver();

  final dummyDateTime = DateTime.utc(2023, 11, 30);
  final globalOverrides = <Override>[
    nowDateTimeProvider.overrideWithValue(dummyDateTime),
  ];

  Future<void> pumpMainScreen(
    WidgetTester widgetTester, {
    List<Override> overrides = const [],
    List<NavigatorObserver> navigatorObservers = const [],
  }) async {
    await widgetTester.pumpWidget(
      ProviderScope(
        overrides: globalOverrides + overrides,
        child: MaterialApp(
          home: const MainScreen(),
          navigatorObservers: navigatorObservers,
        ),
      ),
    );
  }

  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  final implicitView = binding.platformDispatcher.implicitView!;
  setUp(() {
    // デフォルトのサイズだとボタンが入り切っておらず tap() ができないため、サイズを大きくする
    implicitView.physicalSize = const Size(1080, 2400);
    implicitView.devicePixelRatio = 3.0;
  });
  tearDown(() {
    reset(mockYumemiWeatherRepository);
    reset(mockNavigatorObserver);

    implicitView.resetPhysicalSize();
    implicitView.resetDevicePixelRatio();
  });

  testWidgets('クローズボタンを押下で画面を閉じる', (widgetTester) async {
    // Setup
    await pumpMainScreen(
      widgetTester,
      navigatorObservers: [mockNavigatorObserver],
    );

    // Exercise
    await widgetTester.tap(find.widgetWithText(TextButton, 'Close'));
    await widgetTester.pump();

    // Verify
    verify(mockNavigatorObserver.didPop(any, any)).called(1);
  });
  testWidgets('リロードボタンを押下で天気予報の取得を行う', (widgetTester) async {
    // Setup
    final dummyResponse = _createDummyForecast();

    when(
      mockYumemiWeatherRepository.syncFetchWeather(
        area: anyNamed('area'),
        dateTime: anyNamed('dateTime'),
      ),
    ).thenAnswer((_) async => dummyResponse);

    await pumpMainScreen(
      widgetTester,
      overrides: [
        yumemiWeatherRepositoryProvider
            .overrideWithValue(mockYumemiWeatherRepository),
      ],
    );

    // Exercise
    await widgetTester.tap(find.widgetWithText(TextButton, 'Reload'));
    await widgetTester.pump();

    // Verify
    verify(
      mockYumemiWeatherRepository.syncFetchWeather(
        area: anyNamed('area'),
        dateTime: anyNamed('dateTime'),
      ),
    ).called(1);
  });
  group('天気予報の取得に成功した場合', () {
    testWidgets(
      '晴れの場合、天気予報画面に晴れの画像が表示される',
      (widgetTester) async {
        // Setup
        final dummyResponse = _createDummyForecast(
          // ignore: avoid_redundant_argument_values
          weather: Weather.sunny,
        );

        when(
          mockYumemiWeatherRepository.syncFetchWeather(
            area: anyNamed('area'),
            dateTime: anyNamed('dateTime'),
          ),
        ).thenAnswer((_) async => dummyResponse);

        await pumpMainScreen(
          widgetTester,
          overrides: [
            yumemiWeatherRepositoryProvider
                .overrideWithValue(mockYumemiWeatherRepository),
          ],
        );

        // Exercise
        await widgetTester.tap(find.widgetWithText(TextButton, 'Reload'));
        await widgetTester.pump();

        // Verify
        expect(
          find.bySemanticsLabel(Weather.sunny.name),
          findsOneWidget,
        );
      },
    );
    testWidgets(
      '曇りの場合、天気予報画面に曇りの画像が表示される',
      (widgetTester) async {
        // Setup
        final dummyResponse = _createDummyForecast(
          weather: Weather.cloudy,
        );

        when(
          mockYumemiWeatherRepository.syncFetchWeather(
            area: anyNamed('area'),
            dateTime: anyNamed('dateTime'),
          ),
        ).thenAnswer((_) async => dummyResponse);

        await pumpMainScreen(
          widgetTester,
          overrides: [
            yumemiWeatherRepositoryProvider
                .overrideWithValue(mockYumemiWeatherRepository),
          ],
        );

        // Exercise
        await widgetTester.tap(find.widgetWithText(TextButton, 'Reload'));
        await widgetTester.pump();

        // Verify
        expect(
          find.bySemanticsLabel(Weather.cloudy.name),
          findsOneWidget,
        );
      },
    );
    testWidgets(
      '雨の場合、天気予報画面に雨の画像が表示される',
      (widgetTester) async {
        // Setup
        final dummyResponse = _createDummyForecast(
          weather: Weather.rainy,
        );

        when(
          mockYumemiWeatherRepository.syncFetchWeather(
            area: anyNamed('area'),
            dateTime: anyNamed('dateTime'),
          ),
        ).thenAnswer((_) async => dummyResponse);

        await pumpMainScreen(
          widgetTester,
          overrides: [
            yumemiWeatherRepositoryProvider
                .overrideWithValue(mockYumemiWeatherRepository),
          ],
        );

        // Exercise
        await widgetTester.tap(find.widgetWithText(TextButton, 'Reload'));
        await widgetTester.pump();

        // Verify
        expect(
          find.bySemanticsLabel(Weather.rainy.name),
          findsOneWidget,
        );
      },
    );
    testWidgets(
      '天気予報画面に最高気温が表示される',
      (widgetTester) async {
        // Setup
        final dummyResponse = _createDummyForecast(
          maxTemperature: 25,
        );

        when(
          mockYumemiWeatherRepository.syncFetchWeather(
            area: anyNamed('area'),
            dateTime: anyNamed('dateTime'),
          ),
        ).thenAnswer((_) async => dummyResponse);

        await pumpMainScreen(
          widgetTester,
          overrides: [
            yumemiWeatherRepositoryProvider
                .overrideWithValue(mockYumemiWeatherRepository),
          ],
        );

        // Exercise
        await widgetTester.tap(find.widgetWithText(TextButton, 'Reload'));
        await widgetTester.pump();

        // Verify
        final maxTemperatureTextWidget = widgetTester.widget<Text>(
          find.byKey(ForecastView.maxTemperatureTextKey),
        );

        expect(
          maxTemperatureTextWidget.data,
          '25 ℃',
        );
      },
    );
    testWidgets(
      '天気予報画面に最低気温が表示される',
      (widgetTester) async {
        // Setup
        final dummyResponse = _createDummyForecast(
          minTemperature: -10,
        );

        when(
          mockYumemiWeatherRepository.syncFetchWeather(
            area: anyNamed('area'),
            dateTime: anyNamed('dateTime'),
          ),
        ).thenAnswer((_) async => dummyResponse);

        await pumpMainScreen(
          widgetTester,
          overrides: [
            yumemiWeatherRepositoryProvider
                .overrideWithValue(mockYumemiWeatherRepository),
          ],
        );

        // Exercise
        await widgetTester.tap(find.widgetWithText(TextButton, 'Reload'));
        await widgetTester.pump();

        // Verify
        final minTemperatureTextWidget = widgetTester.widget<Text>(
          find.byKey(ForecastView.minTemperatureTextKey),
        );

        expect(
          minTemperatureTextWidget.data,
          '-10 ℃',
        );
      },
    );
  });
  group('天気予報の取得に失敗した場合', () {
    testWidgets(
      '天気予報画面にダイアログが表示され、特定のメッセージが表示される',
      (widgetTester) async {
        // Setup
        const dummyError = YumemiWeatherError.unknown;

        when(
          mockYumemiWeatherRepository.syncFetchWeather(
            area: anyNamed('area'),
            dateTime: anyNamed('dateTime'),
          ),
        ).thenThrow(dummyError);

        await pumpMainScreen(
          widgetTester,
          overrides: [
            yumemiWeatherRepositoryProvider
                .overrideWithValue(mockYumemiWeatherRepository),
          ],
        );

        // Exercise
        await widgetTester.tap(find.widgetWithText(TextButton, 'Reload'));
        await widgetTester.pump();

        // Verify
        final alertDialogFinder = find.byType(AlertDialog);
        final errorMessageFinder = find.text(
          YumemiWeatherError.unknown.toMessage(),
        );
        expect(alertDialogFinder, findsOneWidget);
        expect(errorMessageFinder, findsOneWidget);
        expect(
          find.descendant(
            of: alertDialogFinder,
            matching: errorMessageFinder,
          ),
          findsOneWidget,
        );
      },
    );
  });
}

Forecast _createDummyForecast({
  Weather weather = Weather.sunny,
  int maxTemperature = 40,
  int minTemperature = -40,
}) =>
    Forecast(
      weather: weather,
      maxTemperature: maxTemperature,
      minTemperature: minTemperature,
    );
