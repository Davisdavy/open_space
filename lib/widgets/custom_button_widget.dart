import 'package:flutter/material.dart';
import 'package:on_space/constants/app_colors.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({ required this.height, required this.widget,
    this.width = 10,
    this.color = AppColors.whiteAppColor,
    this.onTap,
    this.shape = BoxShape.circle, super.key,});

  final double height;
  final double width;
  final Widget widget;
  final Color color;
  final BoxShape shape;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          shape: shape,
          boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 12,
                offset: const Offset(0, 2), // changes position of shadow
              ),
          ],
        ),
        child: Center(
          child: widget,
        ),
      ),
    );
  }
}
