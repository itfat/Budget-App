import 'package:bb/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/cupertino.dart';


Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: "Log Out",
    content: "Are you sure you want to logout",
    optionsBuilder: () => {
      "Cancel": false,
      "Log out": true,
    },
  ).then((value) => value ?? false);
}
