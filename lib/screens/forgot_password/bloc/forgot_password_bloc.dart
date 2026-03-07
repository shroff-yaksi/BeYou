import 'package:bloc/bloc.dart';
import 'package:beyou/core/service/auth_service.dart';
import 'package:flutter/material.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordTappedEvent>(_onForgotPasswordTapped);
  }

  final emailController = TextEditingController();

  Future<void> _onForgotPasswordTapped(
    ForgotPasswordTappedEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    try {
      emit(ForgotPasswordLoading());
      await AuthService.resetPassword(emailController.text);
      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(ForgotPasswordError(message: e.toString()));
    }
  }
}
