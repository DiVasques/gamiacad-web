import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';

class RewardHandingTableHeaders {
  static const EdgeInsets _tableHeaderPadding =
      EdgeInsets.only(left: 15, right: 15, top: 10);

  static const List<Widget> _tableHeaders = [
    Padding(
      padding: _tableHeaderPadding,
      child: Text(
        AppTexts.number,
        maxLines: 2,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Padding(
      padding: _tableHeaderPadding,
      child: Text(
        AppTexts.reward,
        maxLines: 2,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Padding(
      padding: _tableHeaderPadding,
      child: Text(
        AppTexts.rewardHandingClaimerName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Padding(
      padding: _tableHeaderPadding,
      child: Text(
        AppTexts.registration,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Padding(
      padding: _tableHeaderPadding,
      child: Text(
        AppTexts.date,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Padding(
      padding: _tableHeaderPadding,
      child: Text(
        AppTexts.rewardHandingHandReward,
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
