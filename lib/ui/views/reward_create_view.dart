// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gami_acad_web/ui/controllers/reward_controller.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/utils/field_validators.dart';
import 'package:gami_acad_web/ui/views/base_section_view.dart';
import 'package:gami_acad_web/ui/widgets/default_text_field.dart';
import 'package:provider/provider.dart';

class RewardCreateView extends StatefulWidget {
  final double maxViewItemsWidth = 600;
  const RewardCreateView({super.key});

  @override
  State<RewardCreateView> createState() => _RewardCreateViewState();
}

class _RewardCreateViewState extends State<RewardCreateView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode _nameFocus;
  late FocusNode _descriptionFocus;
  late FocusNode _priceFocus;
  late FocusNode _availabilityFocus;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _availabilityController;

  @override
  void initState() {
    _nameFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _priceFocus = FocusNode();
    _availabilityFocus = FocusNode();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
    _availabilityController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RewardController>(
      builder: (context, rewardController, _) {
        return BaseSectionView(
          viewTitle: AppTexts.rewardCreate,
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
                      FocusScope.of(context).requestFocus(_priceFocus);
                    },
                    validator: FieldValidators.validateDescription,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    AppTexts.price,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DefaultTextField(
                    controller: _priceController,
                    hintText: AppTexts.price,
                    constraints: BoxConstraints(
                      maxWidth: widget.maxViewItemsWidth / 2,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    focusNode: _priceFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) async {
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(_availabilityFocus);
                    },
                    validator: FieldValidators.validatePrice,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    AppTexts.rewardAvailability,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DefaultTextField(
                    controller: _availabilityController,
                    hintText: AppTexts.quantity,
                    constraints: BoxConstraints(
                      maxWidth: widget.maxViewItemsWidth / 2,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    focusNode: _availabilityFocus,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                    },
                    validator: FieldValidators.validateAvailability,
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
                            bool result = await rewardController.createReward(
                              name: _nameController.text,
                              description: _descriptionController.text,
                              price: int.parse(_priceController.text),
                              availability:
                                  int.parse(_availabilityController.text),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 2),
                                content: Text(
                                  result
                                      ? AppTexts.rewardCreateSuccess
                                      : AppTexts.rewardCreateError,
                                ),
                              ),
                            );
                            if (result) {
                              rewardController.getRewards();
                              rewardController.selectedView =
                                  RewardViewState.list;
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
}
