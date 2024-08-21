import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ShadowContainerWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets outsidePadding;
  final EdgeInsets insidePadding;
  final Alignment alignment;
  final BorderRadius borderRadius;
  final double spreadRadius;
  final double blurRadius;
  final Offset offset;

  ShadowContainerWidget({
    super.key,
    required this.child,
    this.outsidePadding = const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
    this.insidePadding = const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
    this.alignment = Alignment.center,
    BorderRadius? borderRadius,
    this.spreadRadius = 2,
    this.blurRadius = 8,
    this.offset = const Offset(0,2),
  }) : borderRadius = borderRadius ?? BorderRadius.circular(15);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outsidePadding,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              spreadRadius: spreadRadius,
              blurRadius: blurRadius,
              offset: offset,
            )
          ],
        ),
        child: Padding(
          child: Align(alignment: alignment, child: child,),
          padding: insidePadding,
        ),
      ),
    );
  }
}
