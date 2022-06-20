import 'package:bb/services/auth/bloc/auth_bloc.dart';
import 'package:bb/services/auth/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify email"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
                "We have sent you an email verification. Please open it to verify your account."),
            const Text(
                "If you have not received a verification email yet, press the button below."),
            TextButton(
              onPressed: () {
                context
                    .read<AuthBloc>()
                    .add(const AuthEventSendEmailVerification());
              },
              child: const Text("Send email verification"),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
              child: const Text("Register"),
            )
          ],
        ),
      ),
    );
  }
}
