import 'package:dio/dio.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/models/user_access.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/services/gamiacad_dio_client.dart';
import 'package:gami_acad_web/services/models/storage_keys.dart';
import 'package:gami_acad_web/services/secure_storage.dart';

class AuthRepository {
  late UserAccess user;

  late final SecureStorage _secureStorage;
  late final GamiAcadDioClient _gamiAcadDioClient;

  AuthRepository({
    SecureStorage? secureStorage,
    GamiAcadDioClient? gamiAcadDioClient,
  }) {
    _secureStorage = secureStorage ?? SecureStorage();
    _gamiAcadDioClient = gamiAcadDioClient ?? GamiAcadDioClient();
  }

  Future<Result> loginUser({
    required String registration,
    required String password,
  }) async {
    try {
      var response = await _gamiAcadDioClient.post(
        path: '/login/admin',
        body: {
          'registration': registration,
          'password': password,
        },
      );
      var result = Result(
        status: false,
        code: response.statusCode,
        message: response.statusMessage,
      );
      if (response.statusCode == 200) {
        user = UserAccess.fromJson(response.data);
        result.status = true;
        await _saveUserAccess(user);
        return result;
      }
      return result;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw ServiceUnavailableException();
    } catch (e) {
      throw ServiceUnavailableException();
    }
  }

  Future<Result> logoutUser() async {
    try {
      await _gamiAcadDioClient.post(
        path: '/logout',
        body: {
          'token': await _secureStorage.read(key: StorageKeys.refreshToken)
        },
      );
    } catch (e) {
      //Should erase user access even with errors
    } finally {
      await _eraseUserAccess();
    }
    return Result(
      status: true,
    );
  }

  Future<void> _saveUserAccess(UserAccess user) async {
    await _secureStorage.write(key: StorageKeys.userId, value: user.id);
    await _secureStorage.write(
        key: StorageKeys.accessToken, value: user.accessToken);
    await _secureStorage.write(
        key: StorageKeys.refreshToken, value: user.refreshToken);
  }

  Future<void> _eraseUserAccess() async {
    await _secureStorage.delete(key: StorageKeys.userId);
    await _secureStorage.delete(key: StorageKeys.accessToken);
    await _secureStorage.delete(key: StorageKeys.refreshToken);
  }
}
