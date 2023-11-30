import 'dart:convert';

import 'package:flutter_training/model/fetch_weather_request.dart';
import 'package:test/test.dart';

import '../util/string_ext.dart';

void main() {
  test('Serialize', () {
    // Setup
    final dummy = FetchWeatherRequest(
      area: 'tokyo',
      date: DateTime.utc(2023, 11, 29),
    );
    final expected = '''
    {
      "area":"tokyo",
      "date":"2023-11-29T00:00:00Z"
    }'''
        .trimSpace();

    // Exercise
    final result = jsonEncode(dummy.toJson());

    // Verify
    expect(result, expected);
  });
  group('Deserialize', () {
    final dataSet = [
      _DeserializeData(
        description: 'タイムゾーンが UTC の場合',
        dummy: '''
        {
          "area":"nagoya",
          "date":"2023-11-29T00:00:00Z"
        }'''
            .trimSpace(),
        expected: FetchWeatherRequest(
          area: 'nagoya',
          date: DateTime.utc(2023, 11, 29),
        ),
      ),
      _DeserializeData(
        description: 'タイムゾーンが +09:00 の場合',
        dummy: '''
        {
          "area":"nagoya",
          "date":"2023-11-29T00:00:00+09:00"
        }'''
            .trimSpace(),
        expected: FetchWeatherRequest(
          area: 'nagoya',
          date: DateTime.utc(2023, 11, 28, 15),
        ),
      ),
      _DeserializeData(
        description: 'タイムゾーンが -10:00 の場合',
        dummy: '''
        {
          "area":"nagoya",
          "date":"2023-11-29T00:00:00-10:00"
        }'''
            .trimSpace(),
        expected: FetchWeatherRequest(
          area: 'nagoya',
          date: DateTime.utc(2023, 11, 29, 10),
        ),
      ),
      _DeserializeData(
        description: 'タイムゾーンが +05:45 の場合',
        dummy: '''
        {
          "area":"nagoya",
          "date":"2023-11-29T00:00:00+05:45"
        }'''
            .trimSpace(),
        expected: FetchWeatherRequest(
          area: 'nagoya',
          date: DateTime.utc(2023, 11, 28, 18, 15),
        ),
      ),
    ];

    for (final element in dataSet) {
      test(element.description, () {
        // Setup
        final dummy = element.dummy;
        final expected = element.expected;

        // Exercise
        final result = FetchWeatherRequest.fromJson(
          jsonDecode(dummy) as Map<String, dynamic>,
        );

        // Verify
        expect(result, expected);
      });
    }
  });
}

class _DeserializeData {
  _DeserializeData({
    required this.description,
    required this.dummy,
    required this.expected,
  });

  final String description;
  final String dummy;
  final FetchWeatherRequest expected;
}
