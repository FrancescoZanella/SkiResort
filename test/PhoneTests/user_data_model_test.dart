//test ok
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_resorts_app/phone/screens/user_data_model.dart';

void main() {
  group('UserModel', () {
    late UserModel userModel;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      userModel = UserModel();
    });

    test('updateUser should update all fields', () {
      userModel.updateUser(
        userId: '123',
        name: 'John',
        surname: 'Doe',
        email: 'john.doe@example.com',
        phoneNumber: '1234567890',
        avatarPath: '/path/to/avatar',
      );

      expect(userModel.userId, '123');
      expect(userModel.name, 'John');
      expect(userModel.surname, 'Doe');
      expect(userModel.email, 'john.doe@example.com');
      expect(userModel.phoneNumber, '1234567890');
      expect(userModel.avatarPath, '/path/to/avatar');
    });

    test('updateField should update the specified field', () async {
      userModel.updateField('name', 'John');
      expect(userModel.name, 'John');

      userModel.updateField('surname', 'Doe');
      expect(userModel.surname, 'Doe');

      userModel.updateField('email', 'john.doe@example.com');
      expect(userModel.email, 'john.doe@example.com');

      userModel.updateField('phoneNumber', '1234567890');
      expect(userModel.phoneNumber, '1234567890');

      userModel.updateField('avatarPath', '/path/to/avatar');
      expect(userModel.avatarPath, '/path/to/avatar');
    });
  });
}
