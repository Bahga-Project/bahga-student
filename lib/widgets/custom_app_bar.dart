import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/widgets/toggle_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titleWidget;
  final VoidCallback? onFilterPressed;
  final List<Widget>? actions;
  final Color backgroundColor;
  final bool showBackButton;
  final bool showToggleButtons;
  final bool isFirstSelected;
  final VoidCallback? onFirstButtonPressed;
  final VoidCallback? onSecondButtonPressed;
  final String firstButtonText;
  final String secondButtonText;

  const CustomAppBar({
    required this.title,
    this.titleWidget,
    this.onFilterPressed,
    this.actions,
    this.backgroundColor = AppColors.primaryColor,
    this.showBackButton = false,
    this.showToggleButtons = false,
    this.isFirstSelected = true,
    this.onFirstButtonPressed,
    this.onSecondButtonPressed,
    this.firstButtonText = "Offline",
    this.secondButtonText = "Online",
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: titleWidget ??
          Text(
            title,
            style: const TextStyle(color: AppColors.white),
          ),
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.white),
        onPressed: () => Navigator.pop(context),
      )
          : null,
      actions: actions ??
          (onFilterPressed != null
              ? [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: onFilterPressed,
            ),
          ]
              : null),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: showToggleButtons
            ? Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleButton(
                text: firstButtonText,
                isSelected: isFirstSelected,
                onTap: onFirstButtonPressed ?? () {},
              ),
              ToggleButton(
                text: secondButtonText,
                isSelected: !isFirstSelected,
                onTap: onSecondButtonPressed ?? () {},
              ),
            ],
          ),
        )
            : const SizedBox(height: 50),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 50);
}