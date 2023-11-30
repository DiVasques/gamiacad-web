import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';

class UserManagementTableHeaders {
  static const EdgeInsets _tableHeaderPadding =
      EdgeInsets.only(left: 15, right: 15, top: 10);

  static const List<Widget> _tableHeaders = [
    Padding(
      padding: _tableHeaderPadding,
      child: Text(
        AppTexts.name,
        maxLines: 2,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Padding(
      padding: _tableHeaderPadding,
      child: Text(
        AppTexts.registration,
        maxLines: 2,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Padding(
      padding: _tableHeaderPadding,
      child: Text(
        AppTexts.createdAt,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Padding(
      padding: _tableHeaderPadding,
      child: Text(
        AppTexts.admin,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ];

  static TableRow build() {
    return const TableRow(children: _tableHeaders);
  }
}
