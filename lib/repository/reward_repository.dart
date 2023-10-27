import 'package:dio/dio.dart';
import 'package:gami_acad_web/repository/models/exceptions/forbidden_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/models/reward.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/services/gamiacad_dio_client.dart';

class RewardRepository {
  late List<Reward> rewards;

  late final GamiAcadDioClient _gamiAcadDioClient;

  RewardRepository({
    GamiAcadDioClient? gamiAcadDioClient,
  }) {
    _gamiAcadDioClient = gamiAcadDioClient ?? GamiAcadDioClient();
  }

  Future<Result> getRewards() async {
    try {
      var response = await _gamiAcadDioClient.get(
        path: '/reward',
      );
      var result = Result(
        status: false,
        code: response.statusCode,
        message: response.statusMessage,
      );
      if (response.statusCode == 200) {
        result.status = true;
        rewards = (response.data['rewards'] as List<dynamic>)
            .map((reward) => Reward.fromJson(reward))
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
}
