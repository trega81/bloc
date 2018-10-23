import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_login/login/login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginState get initialState => LoginState.initial();

  void onLoginButtonPressed({String username, String password}) {
    dispatch(
      LoginButtonPressed(
        username: username,
        password: password,
      ),
    );
  }

  void onLoginSuccess() {
    dispatch(LoginSuccess());
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginState state,
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginState.loading();

      try {
        final _token = await _authenticate(
            username: event.username, password: event.password);

        yield LoginState.success(_token);
      } catch (error) {
        yield LoginState.failure(error.toString());
      }
    }

    if (event is LoginSuccess) {
      yield LoginState.initial();
    }
  }

  Future<String> _authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));

    /// uncomment the following line to simulator a login error.
    // throw Exception('Login Error');
    return 'token';
  }
}
