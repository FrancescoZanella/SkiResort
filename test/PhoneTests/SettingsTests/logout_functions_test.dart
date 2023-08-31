import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ski_resorts_app/phone/screens/settings/logout_logic/logout_functions.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFacebookAuth extends Mock implements FacebookAuth {}

class MockAccessToken extends Mock implements AccessToken {}

void main() {
  group('logoutUser', () {
    /*test('clears shared preferences and sets isLoggedIn to false', () async {
      final mockSharedPreferences = MockSharedPreferences();
      when(() => mockSharedPreferences.getInstance())
          .thenAnswer((_) async => mockSharedPreferences);

      await logoutUser();

      verify(() => mockSharedPreferences.clear());
      verify(() => mockSharedPreferences.setBool('isLoggedIn', false));
    });*/
  });

  group('logoutGoogleUser', () {
    /*test('signs out of Google and Firebase and calls logoutUser', () async {
      final mockGoogleSignIn = MockGoogleSignIn();
      final mockFirebaseAuth = MockFirebaseAuth();
      when(() => mockGoogleSignIn.isSignedIn()).thenAnswer((_) async => true);

      await logoutGoogleUser(mockGoogleSignIn, mockFirebaseAuth);

      verify(() => mockGoogleSignIn.signOut());
      verify(() => mockFirebaseAuth.signOut());
      verify(() => logoutUser());
    });

    test('does not sign out of Google or Firebase if not signed in', () async {
      final mockGoogleSignIn = MockGoogleSignIn();
      final mockFirebaseAuth = MockFirebaseAuth();
      when(() => mockGoogleSignIn.isSignedIn()).thenAnswer((_) async => false);

      await logoutGoogleUser(mockGoogleSignIn, mockFirebaseAuth);

      verifyNever(() => mockGoogleSignIn.signOut());
      verifyNever(() => mockFirebaseAuth.signOut());
      verify(() => logoutUser());
    });
  });

  group('logoutFacebookUser', () {
    test('logs out of Facebook and Firebase and calls logoutUser', () async {
      final mockFacebookAuth = MockFacebookAuth();
      final mockFirebaseAuth = MockFirebaseAuth();
      final mockAccessToken = MockAccessToken();
      when(() => mockFacebookAuth.accessToken)
          .thenAnswer((_) async => mockAccessToken);
      when(() => mockAccessToken != null).thenReturn(true);

      await logoutFacebookUser(mockFacebookAuth, mockFirebaseAuth);

      verify(() => mockFacebookAuth.logOut());
      verify(() => mockFirebaseAuth.signOut());
      verify(() => logoutUser());
    });

    test('does not log out of Facebook or Firebase if not logged in', () async {
      final mockFacebookAuth = MockFacebookAuth();
      final mockFirebaseAuth = MockFirebaseAuth();
      final mockAccessToken = MockAccessToken();
      when(() => mockFacebookAuth.accessToken)
          .thenAnswer((_) async => mockAccessToken);
      when(() => mockAccessToken != null).thenReturn(false);

      await logoutFacebookUser(mockFacebookAuth, mockFirebaseAuth);

      verifyNever(() => mockFacebookAuth.logOut());
      verifyNever(() => mockFirebaseAuth.signOut());
      verify(() => logoutUser());
    });*/
  });
}
