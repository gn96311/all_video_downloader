import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/core/theme/theme_data.dart';
import 'package:flutter/material.dart';

class SettingContainer extends StatefulWidget {
  final String mainSettingText;
  final String? subSettingText;
  final void Function()? toggleFunction;
  final bool? toggleValue;

  SettingContainer(this.toggleFunction, this.toggleValue, this.subSettingText,
      {required this.mainSettingText, super.key});

  @override
  State<SettingContainer> createState() => _SettingContainerState();
}

class _SettingContainerState extends State<SettingContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.mainSettingText,
                  style: CustomThemeData.themeData.textTheme.headlineSmall,
                ),
                SizedBox(
                  height: 4,
                ),
                (widget.subSettingText != null)
                    ? Text(
                        widget.subSettingText!,
                        style: CustomThemeData.themeData.textTheme.labelLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
          (widget.toggleValue != null)
              ? GestureDetector(
            onTap: widget.toggleFunction,
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 35,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: widget.toggleValue!
                            ? AppColors.secondary
                            : AppColors.lessImportant.withOpacity(0.5)),
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                            top: 6,
                            left: widget.toggleValue! ? 35.0 : 0.0,
                            right: widget.toggleValue! ? 0.0 : 35.0,
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return RotationTransition(
                                  turns: animation,
                                  child: child,
                                );
                              },
                              child: widget.toggleValue!
                                  ? Icon(
                                      Icons.check_circle,
                                      color: AppColors.white,
                                    )
                                  : Icon(
                                      Icons.remove_circle_outline,
                                      color: AppColors.black,
                                    ),
                            ))
                      ],
                    ),
                  ),
              )
              : Container()
        ],
      ),
    );
  }
}
