import 'package:bloc/bloc.dart';
import 'package:beyou/core/service/auth_service.dart';
import 'package:beyou/core/utils/validation_service.dart';
import 'package:flutter/material.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<OnTextChangeEvent>(_onTextChange);
    on<SignInTappedEvent>(_onSignInTapped);
    on<ForgotPasswordTappedEvent>(_onForgotPasswordTapped);
    on<SignUpTappedEvent>(_onSignUpTapped);
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isButtonEnabled = false;

  void _onTextChange(OnTextChangeEvent event, Emitter<SignInState> emit) {
    if (isButtonEnabled != _checkIfSignInButtonEnabled()) {
      isButtonEnabled = _checkIfSignInButtonEnabled();
      emit(SignInButtonEnableChangedState(isEnabled: isButtonEnabled));
    }
  }

  Future<void> _onSignInTapped(SignInTappedEvent event, Emitter<SignInState> emit) async {
    if (_checkValidatorsOfTextField()) {
      try {
        emit(LoadingState());
        await AuthService.signIn(emailController.text, passwordController.text);
        emit(NextTabBarPageState());
      } catch (e) {
        emit(ErrorState(message: e.toString()));
      }
    } else {
      emit(ShowErrorState());
    }
  }

  void _onForgotPasswordTapped(ForgotPasswordTappedEvent event, Emitter<SignInState> emit) {
    emit(NextForgotPasswordPageState());
  }

  void _onSignUpTapped(SignUpTappedEvent event, Emitter<SignInState> emit) {
    emit(NextSignUpPageState());
  }

  bool _checkIfSignInButtonEnabled() {
    return emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  bool _checkValidatorsOfTextField() {
    return ValidationService.email(emailController.text) && ValidationService.password(passwordController.text);
  }
}
