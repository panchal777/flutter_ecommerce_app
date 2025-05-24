import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/common.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBack,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed:
                  onBack ??
                  () {
                    Common.hideKeyboard(context);
                    Navigator.of(context).pop();
                  },
            )
          : null,
      title: Text(title),
      centerTitle: true,
      elevation: 2,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
