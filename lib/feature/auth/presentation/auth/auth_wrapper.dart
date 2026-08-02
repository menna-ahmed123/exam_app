import 'package:exam_app/feature/auth/presentation/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({
    super.key,
    required this.authCubit,
    required this.child,
  });

  final AuthCubit authCubit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authCubit,
      child: child,
    );
  }
}
