import 'package:gami_acad_web/repository/models/user.dart';
import 'package:gami_acad_web/repository/models/user_with_privilege.dart';

class UserMocks {
  static String userId = 'userId';
  static String user2Id = 'user2Id';

  static User user = User(
    id: userId,
    name: 'user name',
    email: 'email@email.com',
    registration: '12345678901',
    balance: 0,
    totalPoints: 1000,
    createdAt: DateTime(2023),
    updatedAt: null,
  );

  static User user2 = User(
    id: user2Id,
    name: 'user2 name',
    email: 'email2@email.com',
    registration: '12345678902',
    balance: 1000,
    totalPoints: 2000,
    createdAt: DateTime(2023),
    updatedAt: null,
  );

  static UserWithPrivilege userWithPrivilege = UserWithPrivilege(
    id: userId,
    name: 'user name',
    email: 'email@email.com',
    admin: true,
    active: true,
    registration: '12345678901',
    balance: 0,
    totalPoints: 1000,
    createdAt: DateTime(2023),
    updatedAt: null,
  );
}
