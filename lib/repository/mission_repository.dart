import 'package:dio/dio.dart';
import 'package:gami_acad_web/repository/models/create_mission.dart';
import 'package:gami_acad_web/repository/models/edit_mission.dart';
import 'package:gami_acad_web/repository/models/exceptions/forbidden_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/models/mission.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/services/gamiacad_dio_client.dart';

class MissionRepository {
  late List<Mission> missions;

  late final GamiAcadDioClient _gamiAcadDioClient;

  MissionRepository({
    GamiAcadDioClient? gamiAcadDioClient,
  }) {
    _gamiAcadDioClient = gamiAcadDioClient ?? GamiAcadDioClient();
  }

  Future<Result> getMissions() async {
    try {
      var response = await _gamiAcadDioClient.get(
        path: '/mission',
      );
      var result = Result(
        status: false,
        code: response.statusCode,
        message: response.statusMessage,
      );
      if (response.statusCode == 200) {
        result.status = true;
        missions = (response.data['missions'] as List<dynamic>)
            .map((mission) => Mission.fromJson(mission))
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

  Future<Result> refreshMission({required String missionId}) async {
    try {
      var response = await _gamiAcadDioClient.get(
        path: '/mission/$missionId',
      );
      var result = Result(
        status: false,
        code: response.statusCode,
        message: response.statusMessage,
      );
      if (response.statusCode == 200) {
        result.status = true;
        for (var (index, mission) in missions.indexed) {
          if (mission.id == missionId) {
            missions[index] = Mission.fromJson(response.data);
            break;
          }
        }
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

  Future<Result> createMission({required CreateMission newMission}) async {
    try {
      var response = await _gamiAcadDioClient.post(
        path: '/mission',
        body: newMission.toJson(),
      );
      var result = Result(
        status: false,
        code: response.statusCode,
        message: response.statusMessage,
      );
      if (response.statusCode == 201) {
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

  Future<Result> editMission({
    required String missionId,
    required EditMission editMission,
  }) async {
    try {
      var response = await _gamiAcadDioClient.patch(
        path: '/mission/$missionId',
        body: editMission.toJson(),
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

  Future<Result> deactivateMission({required String missionId}) async {
    try {
      var response = await _gamiAcadDioClient.delete(
        path: '/mission/$missionId',
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

  Future<Result> completeMission({
    required String missionId,
    required String userId,
  }) async {
    try {
      var response = await _gamiAcadDioClient.patch(
        path: '/mission/$missionId/$userId',
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
