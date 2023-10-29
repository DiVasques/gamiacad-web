import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:gami_acad_web/ui/widgets/base_view_header.dart';

class BaseSectionView extends StatelessWidget {
  final String viewTitle;
  final List<Widget> headerActions;
  final void Function()? reloadAction;
  final Widget errorBody;
  final Widget loadingBody;
  final Widget body;
  final ViewState state;
  const BaseSectionView({
    super.key,
    required this.viewTitle,
    this.errorBody = const Center(
      child: Text(
        AppTexts.error,
        style: TextStyle(fontSize: 20),
      ),
    ),
    this.loadingBody = const Center(
      child: CircularProgressIndicator(),
    ),
    required this.body,
    this.state = ViewState.idle,
    this.headerActions = const [],
    this.reloadAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BaseViewHeader(
          viewTitle: viewTitle,
          actions: headerActions,
          reloadAction: reloadAction,
        ),
        Expanded(
          child: () {
            switch (state) {
              case ViewState.error:
                return errorBody;
              case ViewState.busy:
                return loadingBody;
              case ViewState.idle:
                return body;
            }
          }(),
        )
      ],
    );
  }
}
