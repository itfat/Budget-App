import 'package:bb/constants/routes.dart';
import 'package:bb/create_update_expenses.dart';
import 'package:bb/helpers/loading/loading_screen.dart';
import 'package:bb/themes/theme.dart';
import 'package:bb/views/forgot_password_view.dart';
import 'package:bb/views/login_view.dart';
import 'package:bb/views/notes/create_update_note_view.dart';
import 'package:bb/views/notes/notes_view.dart';
import 'package:bb/views/register_view.dart';
import 'package:bb/views/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: const CreateUpdateExpenseView(),
      routes: {
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    );
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     context.read<AuthBloc>().add(const AuthEventInitialize());
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state.isLoading) {
//           LoadingScreen().show(
//               context: context,
//               text: state.loadingText ?? "Please wait a moment!");
//         } else {
//           LoadingScreen().hide();
//         }
//       },
//       builder: (context, state) {
//         if (state is AuthStateLoggedIn) {
//           return const NotesView();
//         } else if (state is AuthStateNeedsVerification) {
//           return const VerifyEmailView();
//         } else if (state is AuthStateLoggedOut) {
//           return const LoginView();
//         } else if (state is AuthStateForgotPassword) {
//           return const ForgotPasswordView();
//         } else if (state is AuthStateRegistering) {
//           return const RegisterView();
//         } else {
//           return const Scaffold(
//             body: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }
// }
