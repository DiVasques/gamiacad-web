// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/reward_controller.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/utils/field_validators.dart';
import 'package:gami_acad_web/ui/views/base_section_view.dart';
import 'package:gami_acad_web/ui/widgets/default_text_field.dart';
import 'package:provider/provider.dart';

class RewardEditView extends StatefulWidget {
  final double maxViewItemsWidth = 600;
  const RewardEditView({super.key});

  @override
  State<RewardEditView> createState() => _RewardEditViewState();
}

class _RewardEditViewState extends State<RewardEditView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode _nameFocus;
  late FocusNode _descriptionFocus;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _nameFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RewardController>(
      builder: (context, rewardController, _) {
        _nameController.text = rewardController.selectedReward.name;
        _descriptionController.text =
            rewardController.selectedReward.description;
        return BaseSectionView(
          viewTitle: AppTexts.rewardEdit,
          state: rewardController.state,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    AppTexts.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DefaultTextField(
                    controller: _nameController,
                    hintText: AppTexts.name,
                    constraints: const BoxConstraints(maxWidth: 600),
                    focusNode: _nameFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(_descriptionFocus);
                    },
                    validator: FieldValidators.validateMissionOrRewardName,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    AppTexts.description,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DefaultTextField(
                    controller: _descriptionController,
                    hintText: AppTexts.description,
                    constraints: const BoxConstraints(maxWidth: 600),
                    maxLines: 8,
                    focusNode: _descriptionFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                    },
                    validator: FieldValidators.validateDescription,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: widget.maxViewItemsWidth,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.errorGray,
                          ),
                          onPressed: () {
                            rewardController.getRewards();
                            rewardController.selectedView =
                                RewardViewState.list;
                          },
                          child: const Text(AppTexts.back),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            bool result = await rewardController.editReward(
                              rewardId: rewardController.selectedReward.id,
                              name: _nameController.text,
                              description: _descriptionController.text,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 2),
                                content: Text(
                                  result
                                      ? AppTexts.rewardEditSuccess
                                      : AppTexts.rewardEditError,
                                ),
                              ),
                            );
                            if (result) {
                              await rewardController.refreshRewardData(
                                rewardId: rewardController.selectedReward.id,
                                viewState: RewardViewState.details,
                              );
                            }
                          },
                          child: const Text(AppTexts.edit),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
