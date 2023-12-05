import 'package:gami_acad_web/ui/utils/error_messages.dart';
import 'package:intl/intl.dart';

class FieldValidators {
  static String? validateMissionOrRewardName(String? input) {
    input!.trim();
    RegExp validNamePattern = RegExp(r'''^[ \p{L}\p{N}`'-]+$''', unicode: true);
    if (validNamePattern.hasMatch(input)) {
      return null;
    } else {
      return ErrorMessages.invalidName;
    }
  }

  static String? validateDescription(String? input) {
    input!.trim();
    RegExp validDescriptionPattern =
        RegExp(r'^[\p{L}\p{N}\s.,?!$-]+$', unicode: true);
    if (validDescriptionPattern.hasMatch(input)) {
      return null;
    } else {
      return ErrorMessages.invalidDescription;
    }
  }

  static String? validatePoints(String? input) {
    input!.trim();
    RegExp validDescriptionPattern = RegExp(r'^[\d]+$');
    if (!validDescriptionPattern.hasMatch(input)) {
      return ErrorMessages.invalidPoints;
    }
    int points = int.parse(input);
    if (points <= 0) {
      return ErrorMessages.invalidPoints;
    }
    return null;
  }

  static String? validatePrice(String? input) {
    input!.trim();
    RegExp validDescriptionPattern = RegExp(r'^[\d]+$');
    if (!validDescriptionPattern.hasMatch(input)) {
      return ErrorMessages.invalidPrice;
    }
    int points = int.parse(input);
    if (points <= 0) {
      return ErrorMessages.invalidPrice;
    }
    return null;
  }

  static String? validateAvailability(String? input) {
    input!.trim();
    RegExp validDescriptionPattern = RegExp(r'^[\d]+$');
    if (!validDescriptionPattern.hasMatch(input)) {
      return ErrorMessages.invalidAvailability;
    }
    int points = int.parse(input);
    if (points <= 0) {
      return ErrorMessages.invalidAvailability;
    }
    return null;
  }

  static String? validateExpirationDate(String? input) {
    input!.trim();
    if (input.isEmpty) {
      return ErrorMessages.invalidExpirationDate;
    }
    DateTime date = DateFormat('dd/MM/yyyy HH:mm').parse(input);
    if (date.isBefore(DateTime.now())) {
      return ErrorMessages.invalidExpirationDate;
    }
    return null;
  }
}
