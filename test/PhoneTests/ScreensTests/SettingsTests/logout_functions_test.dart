//tests ok
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/phone/screens/settings/logout_logic/logout_functions.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'isLoggedIn': true, // Mocked initial value
      'someOtherKey': 'someValue', // Mocked additional data
    });
  });

  test(
      'logoutUser should clear all SharedPreferences and set isLoggedIn to false',
      () async {
    // Assert initial values before the logout
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('isLoggedIn'), isTrue);
    expect(prefs.getString('someOtherKey'), 'someValue');

    await logoutUser(); // Call the function

    // Assert the expected state after logout
    expect(prefs.getBool('isLoggedIn'), isFalse);
    expect(prefs.getString('someOtherKey'),
        null); // All other keys should be cleared
  });
}
