import 'package:dio/dio.dart';
import 'package:gami_acad_web/repository/models/exceptions/forbidden_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/repository/models/user_with_privilege.dart';
import 'package:gami_acad_web/services/gamiacad_dio_client.dart';

class UserRepository {
  late List<UserWithPrivilege> users;

  late final GamiAcadDioClient _gamiAcadDioClient;

  UserRepository({
    GamiAcadDioClient? gamiAcadDioClient,
  }) {
    _gamiAcadDioClient = gamiAcadDioClient ?? GamiAcadDioClient();
  }

  Future<Result> getUsers() async {
    try {
      var response = await _gamiAcadDioClient.get(
        path: '/user',
      );
      var result = Result(
        status: false,
        code: response.statusCode,
        message: response.statusMessage,
      );
      if (response.statusCode == 200) {
        result.status = true;
        users = (response.data['users'] as List<dynamic>)
            .map((user) => UserWithPrivilege.fromJson(user))
            .toList();
        return result;
      }
      return result;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      if (error.response?.statusCode == 403) {
        throw ForbiddenException();
      }
      throw ServiceUnavailableException();
    } catch (e) {
      throw ServiceUnavailableException();
    }
  }

  Future<Result> updateUserStatus(
      {required String userId, required bool active}) async {
    try {
      var response = await _gamiAcadDioClient.patch(
        path: '/user/status/$userId',
        body: {'active': active},
      );
      var result = Result(
        status: false,
        code: response.statusCode,
        message: response.statusMessage,
      );
      if (response.statusCode == 204) {
        result.status = true;
        return result;
      }
      return result;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      if (error.response?.statusCode == 403) {
        throw ForbiddenException();
      }
      throw ServiceUnavailableException();
    } catch (e) {
      throw ServiceUnavailableException();
    }
  }

  Future<Result> updateUserPrivileges(
      {required String userId, required bool admin}) async {
    try {
      var response = await _gamiAcadDioClient.patch(
        path: '/user/admin/$userId',
        body: {'admin': admin},
      );
      var result = Result(
        status: false,
        code: response.statusCode,
        message: response.statusMessage,
      );
      if (response.statusCode == 204) {
        result.status = true;
        return result;
      }
      return result;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      if (error.response?.statusCode == 403) {
        throw ForbiddenException();
      }
      throw ServiceUnavailableException();
    } catch (e) {
      throw ServiceUnavailableException();
    }
  }
}
