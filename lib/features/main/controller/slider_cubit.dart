import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderState.initial());

  final Dio _dio = Dio();

  Future<void> fetchSliderImages() async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await _dio.get(
          'https://filterr.net/api/v1/sliders?platform=web&role=shop_owner');

      if (response.statusCode == 200) {
        final List data = response.data['data'];
        final images = data.map((e) => e['image'] as String).toList();
        emit(state.copyWith(images: images, isLoading: false));
      } else {
        emit(state.copyWith(images: [], isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(images: [], isLoading: false));
      print("Error fetching slider images: $e");
    }
  }

  void changeSliderIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}

class SliderState {
  final List<String> images;
  final int currentIndex;
  final bool isLoading;

  SliderState({
    required this.images,
    required this.currentIndex,
    required this.isLoading,
  });

  factory SliderState.initial() =>
      SliderState(images: [], currentIndex: 0, isLoading: true);

  SliderState copyWith({
    List<String>? images,
    int? currentIndex,
    bool? isLoading,
  }) {
    return SliderState(
      images: images ?? this.images,
      currentIndex: currentIndex ?? this.currentIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
