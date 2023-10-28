// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gami_acad_web/ui/controllers/mission_controller.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/utils/extensions/date_extension.dart';
import 'package:gami_acad_web/ui/utils/field_validators.dart';
import 'package:gami_acad_web/ui/views/base_section_view.dart';
import 'package:gami_acad_web/ui/widgets/default_text_field.dart';
import 'package:provider/provider.dart';

class MissionCreateView extends StatefulWidget {
  final double maxViewItemsWidth = 600;
  const MissionCreateView({super.key});

  @override
  State<MissionCreateView> createState() => _MissionCreateViewState();
}

class _MissionCreateViewState extends State<MissionCreateView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode _nameFocus;
  late FocusNode _descriptionFocus;
  late FocusNode _pointsFocus;
  late FocusNode _expirationDateFocus;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _pointsController;
  late TextEditingController _expirationDateController;

  @override
  void initState() {
    _nameFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _pointsFocus = FocusNode();
    _expirationDateFocus = FocusNode();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _pointsController = TextEditingController();
    _expirationDateController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MissionController>(
      builder: (context, missionController, _) {
        return BaseSectionView(
          viewTitle: AppTexts.missionCreate,
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
                      FocusScope.of(context).requestFocus(_pointsFocus);
                    },
                    validator: FieldValidators.validateDescription,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    AppTexts.points,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DefaultTextField(
                    controller: _pointsController,
                    hintText: AppTexts.points,
                    constraints: BoxConstraints(
                      maxWidth: widget.maxViewItemsWidth / 2,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    focusNode: _pointsFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) async {
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(_expirationDateFocus);
                    },
                    validator: FieldValidators.validatePoints,
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
                      await handleDateTimePickerActions(
                          context, _expirationDateController);
                    },
                    onTap: () async {
                      await handleDateTimePickerActions(
                          context, _expirationDateController);
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
                            bool validationResult =
                                await validateFields(_formKey);
                            if (validationResult == false) {
                              return;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 2),
                                content: Text(
                                  validationResult
                                      ? AppTexts.missionCreateSucesso
                                      : AppTexts.missionCreateError,
                                ),
                              ),
                            );
                            if (validationResult) {
                              missionController.getMissions();
                              missionController.selectedView =
                                  MissionViewState.list;
                            }
                          },
                          child: const Text(AppTexts.create),
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

  Future<void> handleDateTimePickerActions(
      BuildContext context, TextEditingController controller) async {
    DateTime? selectedDate = await showDatePicker(
      locale: const Locale('pt', 'BR'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (selectedDate == null) {
      return;
    }
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return Localizations.override(
          context: context,
          locale: const Locale('pt', 'BR'),
          child: child,
        );
      },
    );
    if (selectedTime != null) {
      selectedDate = selectedDate.add(
        Duration(
          hours: selectedTime.hour,
          minutes: selectedTime.minute,
        ),
      );
    }
    _expirationDateController.text = selectedDate.toLocalDateTimeString();
  }

  Future<bool> validateFields(GlobalKey<FormState> formKey) async {
    final formState = formKey.currentState;
    if (!formState!.validate()) {
      return false;
    }
    return true;
  }
}
