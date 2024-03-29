part of 'user_bloc.dart';

class UserState {
  UserModel? userModel;

  UserState({
    this.userModel,
  });

  UserState copyWith({
    UserModel? userModel,
  }) {
    return UserState(
      userModel: userModel ?? this.userModel,
    );
  }
}

final class UserInitial extends UserState {
  UserInitial()
      : super(
          userModel: UserModel(),
        );
}
