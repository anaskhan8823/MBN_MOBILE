import 'package:dalil_2020_app/core/style/app_size.dart';
import 'package:dalil_2020_app/features/main/controller/product_cubit/product_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../core/style/app_colors.dart';
import '../../core/style/text_style.dart';
import 'comments_card.dart';

class CommentsForProductProductiveSection extends StatelessWidget {
  const CommentsForProductProductiveSection(
      {super.key, this.color, this.widget});
  final Color? color;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (_, state) {
        final bool successLoadComments = state is GetProductsCommentsSuccess;
        return Skeletonizer(
          enabled: state is ProductLoading,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget ??
                  Text('addProduct.comments'.tr(),
                      style: color != null
                          ? kTextStyle20iUnderLinePink
                          : kTextStyle18iUnderLine),
              Column(
                spacing: 10,
                children: [
                  Column(
                      children: List.generate(
                    successLoadComments ? state.comment.length : 0,
                    (index) {
                      return Padding(
                        padding: AppSize.padding(all: 5),
                        child: CommentCard(
                          color: AppColors.primary,
                          rating: successLoadComments
                              ? (double.tryParse(
                                      state.comment[index].rating ?? '') ??
                                  4.0)
                              : 4.0,
                          image: successLoadComments
                              ? state.comment[index].user?.avatar ?? ""
                              : "",
                          name: successLoadComments
                              ? state.comment[index].user?.name ?? ''
                              : '',
                          comment: successLoadComments
                              ? state.comment[index].comment ?? ''
                              : '',
                        ),
                      );
                    },
                  )),
                  if (state is GetProductsCommentsSuccess) ...{
                    if (state.comment.isNotEmpty &&
                        state.comment.length >= 5) ...{
                      Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_box,
                            color: color ?? AppColors.primary,
                            size: 20,
                          ),
                          Text(
                            "addProduct.loadMore".tr(),
                            style: kTextStyle16Orange.copyWith(
                                color: color ?? AppColors.primary),
                          )
                        ],
                      )
                    } else if (state.comment.isEmpty) ...{
                      Center(
                          child: Text(
                        "change.emptyComments".tr(),
                        style: kTextStyle18White.copyWith(fontSize: 14.sp),
                      ))
                    }
                  }
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
