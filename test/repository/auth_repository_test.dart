import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/repository/auth_repository.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/services/gamiacad_dio_client.dart';
import 'package:gami_acad_web/services/models/storage_keys.dart';
import 'package:gami_acad_web/services/secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks([SecureStorage, GamiAcadDioClient])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('AuthRepository', () {
    late AuthRepository authRepository;
    late MockSecureStorage secureStorage;
    late MockGamiAcadDioClient gamiAcadDioClient;

    String registration = 'valid_registration';
    String password = 'valid_password';
    String userId = 'userId';
    String accessToken = 'accessToken';
    String refreshToken = 'refreshToken';

    setUp(() {
      secureStorage = MockSecureStorage();
      gamiAcadDioClient = MockGamiAcadDioClient();
      authRepository = AuthRepository(
        secureStorage: secureStorage,
        gamiAcadDioClient: gamiAcadDioClient,
      );
      when(secureStorage.write(key: StorageKeys.userId, value: userId))
          .thenAnswer((_) async {});
      when(secureStorage.write(
              key: StorageKeys.accessToken, value: accessToken))
          .thenAnswer((_) async {});
      when(secureStorage.write(
              key: StorageKeys.refreshToken, value: refreshToken))
          .thenAnswer((_) async {});
      when(secureStorage.delete(key: StorageKeys.userId))
          .thenAnswer((_) async {});
      when(secureStorage.delete(key: StorageKeys.accessToken))
          .thenAnswer((_) async {});
      when(secureStorage.delete(key: StorageKeys.refreshToken))
          .thenAnswer((_) async {});
      when(secureStorage.read(key: StorageKeys.refreshToken))
          .thenAnswer((_) async => refreshToken);
    });

    group('loginUser', () {
      test('should return success login', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          statusMessage: 'Success',
          data: {
            'userId': userId,
            'accessToken': accessToken,
            'refreshToken': refreshToken,
          },
        );
        when(gamiAcadDioClient.post(
          path: '/login/admin',
          body: {
            'registration': registration,
            'password': password,
          },
        )).thenAnswer((_) async => response);

        // Act
        final result = await authRepository.loginUser(
          registration: registration,
          password: password,
        );

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
        expect(authRepository.user.id, userId);
        expect(authRepository.user.accessToken, accessToken);
        expect(authRepository.user.refreshToken, refreshToken);
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/login/admin',
          body: {
            'registration': registration,
            'password': password,
          },
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await authRepository.loginUser(
            registration: registration,
            password: password,
          );
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/login/admin',
          body: {
            'registration': registration,
            'password': password,
          },
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 500),
          ),
        );

        // Act and Assert
        try {
          await authRepository.loginUser(
            registration: registration,
            password: password,
          );
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/login/admin',
          body: {
            'registration': registration,
            'password': password,
          },
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await authRepository.loginUser(
            registration: registration,
            password: password,
          );
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });
  });
}
