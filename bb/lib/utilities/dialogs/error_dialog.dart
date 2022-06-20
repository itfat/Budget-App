import 'package:bb/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/cupertino.dart';


Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: "An error occurred",
    content: text,
    optionsBuilder: () => {
      "OK": null,
    },
  );
}
