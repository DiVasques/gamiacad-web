// Mocks generated by Mockito 5.4.2 from annotations
// in gami_acad_web/test/ui/controllers/reward_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:gami_acad_web/repository/models/claimed_reward.dart' as _i5;
import 'package:gami_acad_web/repository/models/create_reward.dart' as _i7;
import 'package:gami_acad_web/repository/models/edit_reward.dart' as _i8;
import 'package:gami_acad_web/repository/models/result.dart' as _i2;
import 'package:gami_acad_web/repository/models/reward.dart' as _i4;
import 'package:gami_acad_web/repository/reward_repository.dart' as _i3;
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

/// A class which mocks [RewardRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockRewardRepository extends _i1.Mock implements _i3.RewardRepository {
  MockRewardRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i4.Reward> get rewards => (super.noSuchMethod(
        Invocation.getter(#rewards),
        returnValue: <_i4.Reward>[],
      ) as List<_i4.Reward>);

  @override
  set rewards(List<_i4.Reward>? _rewards) => super.noSuchMethod(
        Invocation.setter(
          #rewards,
          _rewards,
        ),
        returnValueForMissingStub: null,
      );

  @override
  List<_i5.ClaimedReward> get claimedRewards => (super.noSuchMethod(
        Invocation.getter(#claimedRewards),
        returnValue: <_i5.ClaimedReward>[],
      ) as List<_i5.ClaimedReward>);

  @override
  set claimedRewards(List<_i5.ClaimedReward>? _claimedRewards) =>
      super.noSuchMethod(
        Invocation.setter(
          #claimedRewards,
          _claimedRewards,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<_i2.Result> getRewards() => (super.noSuchMethod(
        Invocation.method(
          #getRewards,
          [],
        ),
        returnValue: _i6.Future<_i2.Result>.value(_FakeResult_0(
          this,
          Invocation.method(
            #getRewards,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Result>);

  @override
  _i6.Future<_i2.Result> getClaimedRewards() => (super.noSuchMethod(
        Invocation.method(
          #getClaimedRewards,
          [],
        ),
        returnValue: _i6.Future<_i2.Result>.value(_FakeResult_0(
          this,
          Invocation.method(
            #getClaimedRewards,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Result>);

  @override
  _i6.Future<_i2.Result> createReward({required _i7.CreateReward? newReward}) =>
      (super.noSuchMethod(
        Invocation.method(
          #createReward,
          [],
          {#newReward: newReward},
        ),
        returnValue: _i6.Future<_i2.Result>.value(_FakeResult_0(
          this,
          Invocation.method(
            #createReward,
            [],
            {#newReward: newReward},
          ),
        )),
      ) as _i6.Future<_i2.Result>);

  @override
  _i6.Future<_i2.Result> editReward({
    required String? rewardId,
    required _i8.EditReward? editReward,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #editReward,
          [],
          {
            #rewardId: rewardId,
            #editReward: editReward,
          },
        ),
        returnValue: _i6.Future<_i2.Result>.value(_FakeResult_0(
          this,
          Invocation.method(
            #editReward,
            [],
            {
              #rewardId: rewardId,
              #editReward: editReward,
            },
          ),
        )),
      ) as _i6.Future<_i2.Result>);

  @override
  _i6.Future<_i2.Result> deactivateReward({required String? rewardId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #deactivateReward,
          [],
          {#rewardId: rewardId},
        ),
        returnValue: _i6.Future<_i2.Result>.value(_FakeResult_0(
          this,
          Invocation.method(
            #deactivateReward,
            [],
            {#rewardId: rewardId},
          ),
        )),
      ) as _i6.Future<_i2.Result>);

  @override
  _i6.Future<_i2.Result> handReward({
    required String? rewardId,
    required String? userId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #handReward,
          [],
          {
            #rewardId: rewardId,
            #userId: userId,
          },
        ),
        returnValue: _i6.Future<_i2.Result>.value(_FakeResult_0(
          this,
          Invocation.method(
            #handReward,
            [],
            {
              #rewardId: rewardId,
              #userId: userId,
            },
          ),
        )),
      ) as _i6.Future<_i2.Result>);
}
