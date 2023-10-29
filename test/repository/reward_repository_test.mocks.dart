// Mocks generated by Mockito 5.4.2 from annotations
// in gami_acad_web/test/repository/reward_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dio/dio.dart' as _i2;
import 'package:gami_acad_web/services/gamiacad_dio_client.dart' as _i3;
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

class _FakeResponse_0<T> extends _i1.SmartFake implements _i2.Response<T> {
  _FakeResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GamiAcadDioClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockGamiAcadDioClient extends _i1.Mock implements _i3.GamiAcadDioClient {
  MockGamiAcadDioClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Response<dynamic>> post({
    required String? path,
    Map<String, String>? headers,
    Object? body,
    Map<String, dynamic>? query,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [],
          {
            #path: path,
            #headers: headers,
            #body: body,
            #query: query,
          },
        ),
        returnValue:
            _i4.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #post,
            [],
            {
              #path: path,
              #headers: headers,
              #body: body,
              #query: query,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response<dynamic>>);

  @override
  _i4.Future<_i2.Response<dynamic>> get({
    required String? path,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [],
          {
            #path: path,
            #headers: headers,
            #query: query,
          },
        ),
        returnValue:
            _i4.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #get,
            [],
            {
              #path: path,
              #headers: headers,
              #query: query,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response<dynamic>>);

  @override
  _i4.Future<_i2.Response<dynamic>> delete({
    required String? path,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [],
          {
            #path: path,
            #headers: headers,
            #query: query,
          },
        ),
        returnValue:
            _i4.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #delete,
            [],
            {
              #path: path,
              #headers: headers,
              #query: query,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response<dynamic>>);

  @override
  _i4.Future<_i2.Response<dynamic>> put({
    required String? path,
    Map<String, String>? headers,
    Object? body,
    Map<String, dynamic>? query,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [],
          {
            #path: path,
            #headers: headers,
            #body: body,
            #query: query,
          },
        ),
        returnValue:
            _i4.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #put,
            [],
            {
              #path: path,
              #headers: headers,
              #body: body,
              #query: query,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response<dynamic>>);

  @override
  _i4.Future<_i2.Response<dynamic>> patch({
    required String? path,
    Map<String, String>? headers,
    Object? body,
    Map<String, dynamic>? query,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [],
          {
            #path: path,
            #headers: headers,
            #body: body,
            #query: query,
          },
        ),
        returnValue:
            _i4.Future<_i2.Response<dynamic>>.value(_FakeResponse_0<dynamic>(
          this,
          Invocation.method(
            #patch,
            [],
            {
              #path: path,
              #headers: headers,
              #body: body,
              #query: query,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response<dynamic>>);
}
