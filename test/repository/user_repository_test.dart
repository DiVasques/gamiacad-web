import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/repository/models/exceptions/forbidden_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/user_repository.dart';
import 'package:gami_acad_web/services/gamiacad_dio_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mocks/user_mocks.dart';
import 'user_repository_test.mocks.dart';

@GenerateMocks([GamiAcadDioClient])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('UserRepository', () {
    late UserRepository userRepository;
    late MockGamiAcadDioClient gamiAcadDioClient;

    setUp(() {
      gamiAcadDioClient = MockGamiAcadDioClient();
      userRepository = UserRepository(
        gamiAcadDioClient: gamiAcadDioClient,
      );
    });

    group('getUsers', () {
      test('should return success getUsers', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          statusMessage: 'Success',
          data: {
            'users': [UserMocks.userWithPrivilege.toJson()],
          },
        );
        when(gamiAcadDioClient.get(
          path: '/user',
        )).thenAnswer((_) async => response);

        // Act
        final result = await userRepository.getUsers();

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
        expect(userRepository.users[0].id, UserMocks.userWithPrivilege.id);
        expect(userRepository.users[0].name, UserMocks.userWithPrivilege.name);
        expect(
            userRepository.users[0].email, UserMocks.userWithPrivilege.email);
        expect(userRepository.users[0].registration,
            UserMocks.userWithPrivilege.registration);
        expect(userRepository.users[0].balance,
            UserMocks.userWithPrivilege.balance);
        expect(userRepository.users[0].totalPoints,
            UserMocks.userWithPrivilege.totalPoints);
        expect(userRepository.users[0].createdAt,
            UserMocks.userWithPrivilege.createdAt);
        expect(userRepository.users[0].updatedAt,
            UserMocks.userWithPrivilege.updatedAt);
        expect(
            userRepository.users[0].admin, UserMocks.userWithPrivilege.admin);
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/user',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await userRepository.getUsers();
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/user',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await userRepository.getUsers();
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/user',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await userRepository.getUsers();
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/user',
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await userRepository.getUsers();
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });
  });
}
