import 'package:all_video_downloader/core/theme/constant/app_colors.dart';
import 'package:all_video_downloader/core/theme/constant/app_icons.dart';
import 'package:all_video_downloader/presentation/pages/home_tab/provider/internet_tab.provider.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';

class InternetTabWidget extends ConsumerStatefulWidget {
  String title;
  String url;
  String faviconPath;
  String tabId;
  TextEditingController urlTextEditingController;

  InternetTabWidget(
      {super.key,
      required this.title,
      required this.url,
      required this.faviconPath,
      required this.tabId,
      required this.urlTextEditingController});

  @override
  ConsumerState<InternetTabWidget> createState() => _InternetTabWidgetState();
}

class _InternetTabWidgetState extends ConsumerState<InternetTabWidget> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: _isDeleting ? Offset(-1, 0) : Offset(0, 0),
      duration: Duration(milliseconds: 300),
      child: AnimatedOpacity(
        opacity: _isDeleting ? 0.0 : 1.0,
        duration: Duration(milliseconds: 300),
        child: _isDeleting
            ? SizedBox.shrink()
            : Row(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: (widget.faviconPath == AppIcons.newTabIcon)
                          ? Image.asset(
                              widget.faviconPath,
                              width: 30,
                              height: 30,
                            )
                          : Image.network(
                              widget.faviconPath,
                              width: 30,
                              height: 30,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.broken_image_outlined,
                                  size: 30,
                                  color: AppColors.lessImportant,
                                );
                              },
                            ),
                      title: Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () async {
                        ref
                            .read(internetTabListProvider.notifier)
                            .setCurrentTabId(widget.tabId);
                        widget.urlTextEditingController.text = widget.url;
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        _isDeleting = true;
                      });

                      await Future.delayed(Duration(milliseconds: 300));

                      await ref
                          .read(internetTabListProvider.notifier)
                          .deleteInternetTab(widget.tabId);

                      setState(() {
                        _isDeleting = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Transform.rotate(
                          angle: math.pi / 4,
                          child: Icon(
                            Icons.add,
                            size: 24,
                          )),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
