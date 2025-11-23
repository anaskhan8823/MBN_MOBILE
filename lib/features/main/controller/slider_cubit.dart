
import 'package:flutter_bloc/flutter_bloc.dart';

class SliderCubit extends Cubit<int>{
  SliderCubit():super(0);
  final List<String> sliderImages = [
    "assets/icons/rectangle.png",
    "assets/icons/rectangle.png",
    "assets/icons/rectangle.png"
  ];
  void changeSliderIndex(int i){
    emit(i);
  }


}