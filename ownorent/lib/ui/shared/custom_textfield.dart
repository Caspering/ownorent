import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';
import '../../utils/font_size.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final Function? onChanged;
  final TextEditingController controller;
  final String? errorText;
  final bool? obscureText;
  final bool? isEnabled;
  final IconData? prefix;
  final int? maxLines;
  final int? minLines;
  final int? maxChar;
  final TextInputAction? action;
  final Function? onSubmit;

  // ignore: use_key_in_widget_constructors
  const CustomTextField(
      {required this.hintText,
      this.prefix,
      this.labelText,
      this.onChanged,
      this.maxLines,
      this.minLines,
      this.action,
      required this.controller,
      this.errorText,
      this.obscureText,
      this.isEnabled,
      this.onSubmit,
      this.maxChar});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.only(top: 5),
        width: MediaQuery.of(context).size.width / 1.1,
        child: TextFormField(
          textInputAction: widget.action,
          onFieldSubmitted: ((value) {
            if (widget.onSubmit != null) {
              widget.onSubmit!(value);
            }
          }),
          maxLength: widget.maxChar,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          onChanged: (text) {
            if (widget.onChanged != null) {
              widget.onChanged!(text);
            }
          },
          controller: widget.controller,
          style: GoogleFonts.lato(
              color: ownorentBlack,
              fontSize: TextSize().p(context),
              fontWeight: FontWeight.w500),
          enabled: widget.isEnabled,
          decoration: InputDecoration(
            filled: true,
            fillColor: greyOne,
            prefixIcon: widget.prefix != null
                ? Icon(
                    widget.prefix,
                    color: ownorentPurpleGrey,
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: GoogleFonts.lato(
                color: ownorentPurpleGrey,
                fontSize: TextSize().p(context),
                fontWeight: FontWeight.w500),
            labelText: widget.labelText,
            labelStyle: GoogleFonts.lato(
                color: ownorentPurpleGrey,
                fontSize: TextSize().p(context),
                fontWeight: FontWeight.w500),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(width: 2.5, color: greyOne!)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(width: 2, color: greyOne!)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(width: 2, color: greyOne!)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(width: 2, color: greyOne!)),
            errorText: widget.errorText,
          ),
          obscureText: widget.obscureText == null ? false : true,
          obscuringCharacter: '*',
        ),
      ),
    );
  }
}
