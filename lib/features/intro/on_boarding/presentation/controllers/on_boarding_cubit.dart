import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/features/auth/presentation/screens/login/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/app_assets.dart';
import '../../../../main/home/nav_user_view.dart';
import 'on_boarding_state.dart';
class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(InitVideoState());
  static OnBoardingCubit get(context) => BlocProvider.of(context);
  late VideoPlayerController controller;
void initVideo(){
  emit(LoadingVideoState());
  controller =VideoPlayerController.asset(AppVideos.intro)..initialize().then((_){
    emit(SuccessVideoState());
    controller.play();
    controller.setLooping(false);
    controller.addListener((){
      if(controller.value.position==controller.value.duration) {
        AppNavigator.push(NavUserView());
      }
    }
    );
  });
  emit(InitVideoState());
}
void navigateToHome(){
  controller.pause();
  AppNavigator.replace(SignInScreen());
}
}
