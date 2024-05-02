
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/textstyles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final Function? onBackPressed;
  final Widget? menuWidget;
  const CustomAppBar({Key? key, required this.title, this.onBackPressed, this.isBackButtonExist = true, this.menuWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: Theme.of(context).primaryColor,

     automaticallyImplyLeading: false,
      shape: const  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(0),
        ),
      ),
      title: Text(title!, style: styleSatoshiBold(size: 18, color: Colors.white)),
      centerTitle: false,
      leading: isBackButtonExist ? IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Theme.of(context).cardColor,
        onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.pop(context),
      ) : const SizedBox(width: 1,),
      elevation: 0,
      actions: menuWidget != null ? [menuWidget!] : null,
    );
  }

  @override
  Size get preferredSize => Size(1170, GetPlatform.isDesktop ? 70 : 50);
}

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  final Widget? menuWidget;
  const CustomAppBar2({Key? key, required this.title, this.menuWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: Theme.of(context).primaryColor,
      automaticallyImplyLeading: false,
      shape: const  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(0),
        ),
      ),
      title: Text(title!, style: styleSatoshiBold(size: 18, color: Colors.white)),
      centerTitle: false,
      elevation: 0,
      actions: menuWidget != null ? [menuWidget!] : null,
    );
  }

  @override
  Size get preferredSize => Size(1170, GetPlatform.isDesktop ? 70 : 50);
}

