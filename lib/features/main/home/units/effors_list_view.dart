import 'package:dalil_2020_app/core/app_assets.dart';
import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/core/style/app_size.dart';
import 'package:dalil_2020_app/features/main/controller/discount_cubit.dart';
import 'package:dalil_2020_app/features/main/controller/discount_store_state.dart'
    hide DiscountCardLoading, DiscountCardSuccess, DiscountCardError;
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:dalil_2020_app/features/main/user_details/all_shops/view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/style/text_style.dart';

class EfforsList extends StatelessWidget {
  const EfforsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.14,
      child: BlocProvider(
        create: (_) => StoreAndProductCubit()..getDiscountCards(),
        child: BlocBuilder<StoreAndProductCubit, StoreAndProductState>(
          builder: (context, state) {
            if (state is DiscountCardLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DiscountCardSuccess) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.cards.length,
                itemBuilder: (context, index) {
                  final card = state.cards[index];
                  final isEn = context.locale.languageCode == 'en';
                  final cubit = context.read<StoreAndProductCubit>();
                  return GestureDetector(
                    onTap: () {
                      cubit.duscountID = card.id;
                      AppNavigator.push(AllShopsForUser(id: cubit.duscountID));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 140,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black,
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: card.photo.isNotEmpty
                                ? Image.network(card.photo, fit: BoxFit.cover)
                                : Image.asset(AppIcons.sale, fit: BoxFit.cover),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            card.discount,
                            // isEn ? card.nameEn : card.nameAr,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // Text(
                          //   card.discount,
                          //   style: kTextStyle16white.copyWith(
                          //     color: AppColors.whiteAndOrangeColor,
                          //   ),
                          // ),x
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is DiscountCardError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
