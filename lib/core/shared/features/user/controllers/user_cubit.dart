import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../../models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(BuildContext ctx) => BlocProvider.of(ctx);

  UserModel? user;

  /// TODO : GET USER API

  // Future<void> getUser() async {
  //   if (CacheHelper.get('token') == null) return;
  //   emit(LoadingUser());
  //   final repo = ProfileRepoImpel();
  //   final api = await repo.getProfile();
  //   api.fold(
  //     (l) async {
  //       await CacheHelper.remove('token');
  //       user = null;
  //       emit(Error());
  //     },
  //     (r) {
  //       user = r;
  //       emit(SuccessUser());
  //     },
  //   );
  // }
}
