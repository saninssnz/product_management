part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

class SetUserData extends UserEvent {
  final String email;
  final String password;
  final String pin;
  SetUserData({required this.email, required this.password,required this.pin});
}

class CreateUserData extends UserEvent {
  final String email;
  final String password;
  CreateUserData({required this.email, required this.password});
}

class AddUserToPreferenceEvent extends UserEvent {
  final UserModel userModel;
  AddUserToPreferenceEvent(this.userModel);
}

class SetUseModel extends UserEvent {
  final UserModel userModel;
  SetUseModel(this.userModel);
}