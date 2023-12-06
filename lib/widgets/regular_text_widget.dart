import 'package:flutter/material.dart';

class RegularTextWidget extends StatelessWidget {


  const RegularTextWidget(
      {required this.text, super.key,
        this.decoration,
        this.fontStyle,
        this.letterSpacing = 1,
        this.fontWeight = FontWeight.w400,
        this.color = Colors.white,
        this.size = 14,
        this.height = 1.0,
        this.align,
        this.maxLine = 1,
        this.textOverflow = TextOverflow.ellipsis,});
  final Color? color;
  final String text;
  final double size;
  final TextAlign? align;
  final double height;
  final int maxLine;
  final double letterSpacing;
  final TextOverflow textOverflow;
  final FontWeight fontWeight;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      textAlign: align ?? TextAlign.center,
      maxLines: maxLine,
      style: TextStyle(
          color: color,
          height: height,
          letterSpacing: letterSpacing,
          fontWeight: fontWeight,
          //fontFamily: 'SFPRO',
          fontStyle: fontStyle,
          decoration: decoration,
          //fontStyle: FontStyle.normal,
          fontSize: size,),
    );
  }
}
