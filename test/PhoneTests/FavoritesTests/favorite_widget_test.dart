import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ski_resorts_app/phone/screens/favorites/favorite_elements.dart';
import 'package:ski_resorts_app/phone/screens/favorites/favorite_widget.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class MockWidgetsToImageController extends Mock
    implements WidgetsToImageController {}

class MockDirectory extends Mock implements Directory {}

class MockFile extends Mock implements File {}

class MockFirebaseDatabase extends Mock implements FirebaseDatabase {}

class MockDatabaseReference extends Mock implements DatabaseReference {}

class MockBuildContext extends Mock implements BuildContext {}

class MockFirebaseApp extends Mock implements FirebaseApp {}

void main() {
  setUpAll(() async {
    // Mock Firebase Initialization
    MockFirebaseApp mockFirebaseApp = MockFirebaseApp();
    when(() => Firebase.initializeApp())
        .thenAnswer((_) => Future.value(mockFirebaseApp));
  });
  group('FavoriteWidget', () {
    late Favorite favorite;
    late BuildContext context;
    late VoidCallback onFavoriteRemoved;
    late MockWidgetsToImageController controller;
    late MockDirectory directory;
    late MockFile imgFile;
    late MockFirebaseDatabase firebaseDatabase;
    late MockDatabaseReference databaseReference;

    setUp(() {
      favorite = Favorite(
        skiResortName: 'Test Resort',
        skiResortRating: 4.5,
        skiResortDescription: 'Test description',
        skiResortElevation: '1000 m',
        totalSkiSlopes: '10',
        blueSkiSlopes: '3',
        redSkiSlopes: '5',
        blackSkiSlopes: '2',
        skiLiftsNumber: '5',
        skiPassCost: '50 €',
        skiResortUrl: 'https://test-resort.com',
        imageLink: 'https://test-resort.com/image.jpg',
        skiResortFavoriteId: '123',
      );
      context = MockBuildContext();
      onFavoriteRemoved = () {};
      controller = MockWidgetsToImageController();
      directory = MockDirectory();
      imgFile = MockFile();
      firebaseDatabase = MockFirebaseDatabase();
      databaseReference = MockDatabaseReference();

      when(() => firebaseDatabase.ref()).thenReturn(databaseReference);
      when(() => databaseReference.child(any())).thenReturn(databaseReference);
    });

    testWidgets('displays ski resort name and rating',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FavoriteWidget.favoriteWidget(
                favorite, context, onFavoriteRemoved),
          ),
        ),
      );

      expect(find.text(favorite.skiResortName), findsOneWidget);
      expect(find.byType(RatingBarIndicator), findsOneWidget);
    });

    testWidgets('displays ski resort description', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FavoriteWidget.favoriteWidget(
                favorite, context, onFavoriteRemoved),
          ),
        ),
      );

      expect(find.text(favorite.skiResortDescription), findsOneWidget);
    });

    testWidgets(
        'displays ski resort elevation, ski slopes, ski lifts and ski pass cost',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FavoriteWidget.favoriteWidget(
                favorite, context, onFavoriteRemoved),
          ),
        ),
      );

      expect(find.text(favorite.skiResortElevation), findsOneWidget);
      expect(find.text(favorite.totalSkiSlopes), findsOneWidget);
      expect(find.text(favorite.skiLiftsNumber), findsOneWidget);
      expect(find.text(favorite.skiPassCost), findsOneWidget);
    });

    testWidgets('displays ski resort image and share button',
        (WidgetTester tester) async {
      when(() => controller.capture())
          .thenAnswer((_) async => Uint8List.fromList([0, 1, 2, 3]));
      when(() => directory.path).thenReturn('/test/path');
      when(() => imgFile.path).thenReturn('/test/path/screenshot.png');
      when(() => imgFile.writeAsBytes(any())).thenAnswer((_) async {
        return File('/test/path/screenshot.png');
      });
      when(() => firebaseDatabase.ref()).thenReturn(databaseReference);
      when(() => databaseReference.child(any())).thenReturn(databaseReference);
      when(() => databaseReference.remove()).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FavoriteWidget.favoriteWidget(
                favorite, context, onFavoriteRemoved),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.byIcon(Icons.share), findsOneWidget);

      await tester.tap(find.byIcon(Icons.share));
      await tester.pumpAndSettle();

      verify(() => controller.capture()).called(1);
      verify(() => imgFile.writeAsBytes(any())).called(1);
      verify(() => Share.shareFiles([imgFile.path],
              text: 'Check out this ski resort: ${favorite.skiResortUrl}'))
          .called(1);
    });

    testWidgets(
        'removes favorite resort from database when remove button is pressed',
        (WidgetTester tester) async {
      when(() => databaseReference.child(any())).thenReturn(databaseReference);
      when(() => databaseReference.remove()).thenAnswer((_) async {});
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FavoriteWidget.favoriteWidget(
                favorite, context, onFavoriteRemoved),
          ),
        ),
      );

      expect(find.text('Remove from Favorites'), findsOneWidget);

      await tester.tap(find.text('Remove from Favorites'));
      await tester.pumpAndSettle();

      verify(() => databaseReference.child(favorite.skiResortFavoriteId!))
          .called(1);
      verify(() => databaseReference.remove()).called(1);
      verify(() => onFavoriteRemoved()).called(1);
    });
  });
}
