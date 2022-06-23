
import 'package:bb/auth/auth_exception.dart';
import 'package:bb/auth/bloc/auth_bloc.dart';
import 'package:bb/auth/bloc/auth_event.dart';
import 'package:bb/auth/bloc/auth_state.dart';
import 'package:bb/utilities/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;


class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(
              context,
              "Weak password",
            );
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(
              context,
              "Email already in use",
            );
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(
              context,
              "Failed to register",
            );
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(
              context,
              "Invalid email",
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  enableSuggestions: false,
                  autocorrect: false,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  decoration:
                      const InputDecoration(hintText: "Enter your email here"),
                ),
                TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: _password,
                  decoration:
                      const InputDecoration(hintText: "Enter your password here"),
                ),
                TextButton(
                    child: const Text("Register"),
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      context.read<AuthBloc>().add(AuthEventRegister(
                            email,
                            password,
                          ));
                    }),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEventLogOut());
                  },
                  child: const Text("Already registered? Login here!"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
