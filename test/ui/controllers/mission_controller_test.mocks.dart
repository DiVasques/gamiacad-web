// Mocks generated by Mockito 5.4.2 from annotations
// in gami_acad_web/test/ui/controllers/mission_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:gami_acad_web/repository/mission_repository.dart' as _i3;
import 'package:gami_acad_web/repository/models/mission.dart' as _i4;
import 'package:gami_acad_web/repository/models/result.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeResult_0 extends _i1.SmartFake implements _i2.Result {
  _FakeResult_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MissionRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMissionRepository extends _i1.Mock implements _i3.MissionRepository {
  MockMissionRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i4.Mission> get missions => (super.noSuchMethod(
        Invocation.getter(#missions),
        returnValue: <_i4.Mission>[],
      ) as List<_i4.Mission>);

  @override
  set missions(List<_i4.Mission>? _missions) => super.noSuchMethod(
        Invocation.setter(
          #missions,
          _missions,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i5.Future<_i2.Result> getMissions() => (super.noSuchMethod(
        Invocation.method(
          #getMissions,
          [],
        ),
        returnValue: _i5.Future<_i2.Result>.value(_FakeResult_0(
          this,
          Invocation.method(
            #getMissions,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Result>);
}