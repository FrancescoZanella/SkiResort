import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:ski_resorts_app/phone/screens/statistics/statistics_screen_1.dart';
import 'package:ski_resorts_app/phone/screens/statistics/statistics_data.dart';

void main() {
  group('saveStat', () {
    test('saves a stat successfully', () async {
      final client = http.Client();
      final r = RunData(
        latitude: 0,
        longitude: 0,
        date: '2022-01-01',
        formattedTime: '00:00:00',
        averageSpeed: 0,
        maxSpeed: 0,
        distanceInMeters: 0,
        speedDataPoints: [],
      );

      saveStat(r, client: client);

      // Check that the stat was saved by fetching all stats and checking if the saved stat is in the list
      final stats = await getStats('test_user_id');
      expect(stats, contains(r));
    });

    test('throws an exception when saving a stat fails', () async {
      final client = http.Client();
      final r = RunData(
        latitude: 0,
        longitude: 0,
        date: '2022-01-01',
        formattedTime: '00:00:00',
        averageSpeed: 0,
        maxSpeed: 0,
        distanceInMeters: 0,
        speedDataPoints: [],
      );

      // Set an invalid URL to make the saveStat request fail
      url.replace(scheme: 'invalid');

      expect(() => saveStat(r, client: client), throwsException);
    });
  });

  group('getStats', () {
    test('returns a list of stats for a user', () async {
      // Save some stats for the test user
      final client = http.Client();
      final r1 = RunData(
        latitude: 0,
        longitude: 0,
        date: '2022-01-01',
        formattedTime: '00:00:00',
        averageSpeed: 0,
        maxSpeed: 0,
        distanceInMeters: 0,
        speedDataPoints: [],
      );
      final r2 = RunData(
        latitude: 0,
        longitude: 0,
        date: '2022-01-02',
        formattedTime: '00:00:00',
        averageSpeed: 0,
        maxSpeed: 0,
        distanceInMeters: 0,
        speedDataPoints: [],
      );
      saveStat(r1, client: client);
      saveStat(r2, client: client);

      final stats = await getStats('test_user_id');

      expect(stats, containsAll([r1, r2]));
    });

    test('throws an exception when the server returns an error', () async {
      // Set an invalid URL to make the getStats request fail
      url.replace(scheme: 'invalid');

      expect(() => getStats('test_user_id'), throwsException);
    });
  });

  group('getBestStat', () {
    test('returns the best stat for a user', () async {
      // Save some stats for the test user
      final client = http.Client();
      final r1 = RunData(
        latitude: 0,
        longitude: 0,
        date: '2022-01-01',
        formattedTime: '00:00:00',
        averageSpeed: 0,
        maxSpeed: 10,
        distanceInMeters: 0,
        speedDataPoints: [],
      );
      final r2 = RunData(
        latitude: 0,
        longitude: 0,
        date: '2022-01-02',
        formattedTime: '00:00:00',
        averageSpeed: 0,
        maxSpeed: 20,
        distanceInMeters: 0,
        speedDataPoints: [],
      );
      saveStat(r1, client: client);
      saveStat(r2, client: client);

      final bestStat = await getBestStat('test_user_id');

      expect(bestStat, equals(r2));
    });

    test('throws an exception when the server returns an error', () async {
      // Set an invalid URL to make the getBestStat request fail
      url.replace(scheme: 'invalid');

      expect(() => getBestStat('test_user_id'), throwsException);
    });
  });
}
