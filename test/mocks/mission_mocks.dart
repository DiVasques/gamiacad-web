import 'package:gami_acad_web/repository/models/create_mission.dart';
import 'package:gami_acad_web/repository/models/edit_mission.dart';
import 'package:gami_acad_web/repository/models/mission.dart';

import 'user_mocks.dart';

class MissionMocks {
  static String missionId = 'missionId';

  static Mission mission = Mission(
    id: missionId,
    name: 'name',
    description: 'description',
    number: 1,
    points: 100,
    expirationDate: DateTime.now(),
    createdAt: DateTime.now(),
    updatedAt: null,
    createdBy: UserMocks.user.id,
    createdByInfo: UserMocks.user,
    participants: [],
    participantsInfo: [],
    completers: [],
    completersInfo: [],
    active: true,
  );

  static CreateMission newMission = CreateMission(
    name: 'name',
    description: 'description',
    points: 100,
    expirationDate: DateTime.now(),
  );

  static EditMission editMission = EditMission(
    name: 'name',
    description: 'description',
    expirationDate: DateTime.now(),
  );
}
