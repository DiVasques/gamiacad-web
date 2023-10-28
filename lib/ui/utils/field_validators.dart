import 'package:gami_acad_web/ui/utils/error_messages.dart';
import 'package:intl/intl.dart';

class FieldValidators {
  static String? validateMissionName(String? input) {
    input!.trim();
    RegExp validMissionNamePattern = RegExp(
        r'''^[ a-z\dA-ZàèìòùÀÈÌÒÙáéíóúýÁÉÍÓÚÝâêîôûÂÊÎÔÛãñõÃÑÕäëïöüÿÄËÏÖÜŸçÇßØøÅåÆæœ`'-]+$''');
    if (validMissionNamePattern.hasMatch(input)) {
      return null;
    } else {
      return ErrorMessages.invalidName;
    }
  }

  static String? validateDescription(String? input) {
    input!.trim();
    RegExp validDescriptionPattern = RegExp(r'^[\w\s,.]+$');
    if (validDescriptionPattern.hasMatch(input)) {
      return null;
    } else {
      return ErrorMessages.invalidName;
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
