import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ski_resorts_app/phone/screens/settings/profile_screen/functions_for_firebase.dart';
import 'package:ski_resorts_app/phone/screens/user_data_model.dart';

class MockUserModel extends Mock implements UserModel {}

class MockDatabaseReference extends Mock implements DatabaseReference {}

class MockFirebaseDatabase extends Mock implements FirebaseDatabase {}

void main() {
  group('updateDataOnFirebase', () {
    final mockUserModel = MockUserModel();
    final mockDatabaseReference = MockDatabaseReference();
    final mockFirebaseDatabase = MockFirebaseDatabase();

    setUp(() {
      when(() => mockFirebaseDatabase.ref()).thenReturn(mockDatabaseReference);
      when(() => mockDatabaseReference.child(any()))
          .thenReturn(mockDatabaseReference);
    });

    test('updates avatar field in user model and firebase', () async {
      const userId = '123';
      const field = 'avatar';
      const newValue = 'newAvatarPath';

      when(() => mockUserModel.updateField('avatarPath', newValue))
          .thenReturn(null);
      when(() => mockDatabaseReference.update({field: newValue}))
          .thenAnswer((_) async {});

      await updateDataOnFirebase(mockUserModel, userId, field, newValue);

      verify(() => mockUserModel.updateField('avatarPath', newValue)).called(1);
      verify(() => mockDatabaseReference.update({field: newValue})).called(1);
    });

    test('updates non-avatar field in user model and firebase', () async {
      const userId = '123';
      const field = 'name';
      const newValue = 'newName';

      when(() => mockUserModel.updateField(field, newValue)).thenReturn(null);
      when(() => mockDatabaseReference.update({field: newValue}))
          .thenAnswer((_) async {});

      await updateDataOnFirebase(mockUserModel, userId, field, newValue);

      verify(() => mockUserModel.updateField(field, newValue)).called(1);
      verify(() => mockDatabaseReference.update({field: newValue})).called(1);
    });
  });
}
