import 'package:dalil_2020_app/core/style/app_size.dart';
import 'package:dalil_2020_app/features/main/controller/product_cubit/product_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../core/helper/dialogs.dart';
import '../../core/style/app_colors.dart';
import '../../core/style/text_style.dart';
import '../main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'comments_card.dart';

class CommentsForProduct extends StatelessWidget {
  final Color? color;
  final int? productId;
  final bool? addComment;
  const CommentsForProduct(
      {super.key, this.addComment = false, this.color, this.productId});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreAndProductCubit, StoreAndProductState>(
      builder: (_, state) {
        final bool successLoadComments =
            state is GetProductsStoreCommentsSuccess;
        return Skeletonizer(
          enabled: state is ProductLoading,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addComment == true
                  ? GestureDetector(
                      onTap: () {
                        final cubit = context.read<StoreAndProductCubit>();
                        showRatingBottomSheet(context, (value) {
                          cubit.changeRate(value.floor());
                        }, () {
                          cubit.addComment(productId, null);
                        }, cubit.commentController);
                      },
                      child: Row(
                        children: [
                          Text('addProduct.comments'.tr(),
                              style: kTextStyle18iUnderLine),
                          const Spacer(),
                          Icon(
                            Icons.add,
                            color: AppColors.primary,
                          ),
                          Text("change.add".tr()),
                        ],
                      ),
                    )
                  : Text('addProduct.comments'.tr(),
                      style: kTextStyle18iUnderLine),
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
                  if (state is GetProductsStoreCommentsSuccess) ...{
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
                  },
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
