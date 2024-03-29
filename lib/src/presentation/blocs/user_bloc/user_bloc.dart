import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:machine_test/src/data/data_source/local/preference/preference_file.dart';
import 'package:machine_test/src/data/models/user_model.dart';
import 'package:machine_test/src/domain/repositories/firebase/firebase_repo.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {

    on<SetUserData>((event, emit) async {
      emit(UserLoading());

      try {
        User? user = await signIn(event.email, event.password);

        if (user != null) {
          emit(UserLoaded());
          emit(state.copyWith(
            userModel: UserModel(userEmail: user.email ?? ""),
          ));
        } else {
          // emit(UserLoaded());
          emit(UserError("User sign-in failed."));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<CreateUserData>((event, emit) async {
      emit(UserLoading());

      try {
        User? user = await createAccount(event.email, event.password);

        if (user != null) {
          emit(UserLoaded());
        } else {
          emit(UserError("User sign-Up failed."));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<AddUserToPreferenceEvent>((event, emit) async {
      PreferenceFile().setLoginData(event.userModel);
      emit(state.copyWith(
        userModel: event.userModel,
      ));
    });

    on<SetUseModel>((event, emit) async {
      emit(state.copyWith(
        userModel: event.userModel,
      ));
    });
  }
}
