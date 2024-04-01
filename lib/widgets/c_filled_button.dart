import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CFilledButton extends StatefulWidget {
  final bool isLoading;
  final String buttonLabel;
  final Function() onPressed;
  const CFilledButton(
      {super.key,
      required this.isLoading,
      required this.buttonLabel,
      required this.onPressed});

  @override
  State<CFilledButton> createState() => _CFilledButtonState();
}

class _CFilledButtonState extends State<CFilledButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xffc1a792),
        ),
        textStyle: MaterialStateProperty.all(
          GoogleFonts.rajdhani(fontWeight: FontWeight.w500),
        ),
      ),
      onPressed: widget.onPressed,
      child: widget.isLoading
          ? const CircularProgressIndicator()
          : Text(widget.buttonLabel),
    );
  }
}
