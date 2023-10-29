import 'package:flutter/material.dart';

class BaseViewHeader extends StatelessWidget {
  final String viewTitle;
  final List<Widget> actions;
  final void Function()? reloadAction;
  const BaseViewHeader({
    super.key,
    required this.viewTitle,
    this.actions = const [],
    this.reloadAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 20,
        children: [
          Flexible(
            child: Text(
              viewTitle,
              textAlign: TextAlign.start,
              softWrap: true,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          reloadAction != null
              ? IconButton(
                  onPressed: reloadAction,
                  icon: const Icon(Icons.replay),
                )
              : const SizedBox(),
          ...actions,
        ],
      ),
    );
  }
}
