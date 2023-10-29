// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gami_acad_web/ui/controllers/mission_controller.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/utils/date_picker.dart';
import 'package:gami_acad_web/ui/utils/extensions/date_extension.dart';
import 'package:gami_acad_web/ui/utils/extensions/string_extension.dart';
import 'package:gami_acad_web/ui/utils/field_validators.dart';
import 'package:gami_acad_web/ui/views/base_section_view.dart';
import 'package:gami_acad_web/ui/widgets/default_text_field.dart';
import 'package:provider/provider.dart';

class MissionEditView extends StatefulWidget {
  final double maxViewItemsWidth = 600;
  const MissionEditView({super.key});

  @override
  State<MissionEditView> createState() => _MissionEditViewState();
}

class _MissionEditViewState extends State<MissionEditView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode _nameFocus;
  late FocusNode _descriptionFocus;
  late FocusNode _expirationDateFocus;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _expirationDateController;

  @override
  void initState() {
    _nameFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _expirationDateFocus = FocusNode();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _expirationDateController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MissionController>(
      builder: (context, missionController, _) {
        _nameController.text = missionController.selectedMission.name;
        _descriptionController.text =
            missionController.selectedMission.description;
        _expirationDateController.text = missionController
            .selectedMission.expirationDate
            .toLocalDateTimeString();
        return BaseSectionView(
          viewTitle: AppTexts.missionEdit,
          state: missionController.state,
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
                    validator: FieldValidators.validateMissionName,
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
                      FocusScope.of(context).requestFocus(_expirationDateFocus);
                    },
                    validator: FieldValidators.validateDescription,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    AppTexts.expirationDate,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DefaultTextField(
                    controller: _expirationDateController,
                    hintText: AppTexts.datePlaceholder,
                    constraints: BoxConstraints(
                      maxWidth: widget.maxViewItemsWidth / 2,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'([\d/]+)')),
                    ],
                    onChanged: (value) async {
                      await DatePicker.handleDateTimePickerActions(
                        context: context,
                        controller: _expirationDateController,
                        initialDate:
                            missionController.selectedMission.expirationDate,
                        firstDate:
                            missionController.selectedMission.expirationDate,
                        lastDate: DateTime(2100),
                      );
                    },
                    onTap: () async {
                      await DatePicker.handleDateTimePickerActions(
                        context: context,
                        controller: _expirationDateController,
                        initialDate:
                            missionController.selectedMission.expirationDate,
                        firstDate:
                            missionController.selectedMission.expirationDate,
                        lastDate: DateTime(2100),
                      );
                    },
                    focusNode: _expirationDateFocus,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                    },
                    validator: FieldValidators.validateExpirationDate,
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
                            textStyle: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            missionController.getMissions();
                            missionController.selectedView =
                                MissionViewState.list;
                          },
                          child: const Text(AppTexts.back),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            bool result = await missionController.editMission(
                              missionId: missionController.selectedMission.id,
                              name: _nameController.text,
                              description: _descriptionController.text,
                              expirationDate: _expirationDateController.text
                                  .toLocalDateTime(),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 2),
                                content: Text(
                                  result
                                      ? AppTexts.missionEditSuccess
                                      : AppTexts.missionEditError,
                                ),
                              ),
                            );
                            if (result) {
                              missionController.getMissions();
                              missionController.selectedView =
                                  MissionViewState.list;
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
