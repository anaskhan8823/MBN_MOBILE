import 'package:dalil_2020_app/core/dio_helper.dart';
import 'package:dalil_2020_app/core/helper/app_toast.dart';
import 'package:dalil_2020_app/features/main/controller/discount_store_state.dart';
import 'package:dalil_2020_app/models/discount_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// your toast

class DiscountCardCubit extends Cubit<DiscountCardState> {
  DiscountCardCubit() : super(DiscountCardInitial());

  List<DiscountCardModel> cards = [];

  Future<void> getDiscountCards() async {
    try {
      emit(DiscountCardLoading());
      final response = await DioHelper.get("discount-cards");

      if (response.isSuccess) {
        final List<DiscountCardModel> list = List<DiscountCardModel>.from(
          (response.data?['data'] ?? [])
              .map((e) => DiscountCardModel.fromJson(e)),
        );

        cards.clear();
        cards.addAll(list);
        emit(DiscountCardSuccess(list));
      } else {
        emit(DiscountCardError("Failed to load discount cards"));
      }
    } catch (e) {
      AppToast.error("Error: ${e.toString()}");
      emit(DiscountCardError(e.toString()));
    }
  }
}
