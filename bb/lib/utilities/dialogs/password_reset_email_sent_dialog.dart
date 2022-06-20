import 'package:bb/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';


Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: "Password Reset",
      content:
          "We have now sent you a password reset link. Please check your email for more information.",
      optionsBuilder: () => {
            "OK": null,
          });
}
