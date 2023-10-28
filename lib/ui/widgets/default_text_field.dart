import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';

class DefaultTextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final Color backgroundColor;
  final String? labelText;
  final String? hintText;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final void Function(String) onFieldSubmitted;
  final void Function()? onTap;
  final TextStyle? style;
  final String? initValue;
  final BoxConstraints? constraints;
  final int? maxLines;
  const DefaultTextField({
    Key? key,
    this.controller,
    this.obscureText = false,
    this.backgroundColor = Colors.white,
    this.labelText,
    this.hintText,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onSaved,
    this.style,
    required this.onFieldSubmitted,
    this.onTap,
    this.onChanged,
    this.initValue,
    this.constraints,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        constraints: widget.constraints,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        labelText: widget.labelText,
        hintText: widget.hintText,
        fillColor: widget.backgroundColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        errorStyle: const TextStyle(fontSize: 11.0),
      ),
      onTap: widget.onTap,
      controller: widget.controller,
      maxLines: widget.maxLines,
      obscureText: widget.obscureText,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.top,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      focusNode: widget.focusNode,
      style: widget.style,
      onFieldSubmitted: widget.onFieldSubmitted,
      initialValue: widget.initValue,
    );
  }
}
