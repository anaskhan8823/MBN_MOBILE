part of '../main/shop_owner_details/store_details/view.dart';

class CommentsStoreSection extends StatelessWidget {
  const CommentsStoreSection(
      {super.key, this.addComment = false, this.storeId});
  final bool? addComment;
  final int? storeId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreAndProductCubit, StoreAndProductState>(
      builder: (context, state) {
        final bool successLoadComments = state is GetStoresCommentsSuccess;
        return Skeletonizer(
          enabled: state is AddStoreLoading,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachHelper.role == "user"
                  ? GestureDetector(
                      onTap: () {
                        final cubit = context.read<StoreAndProductCubit>();
                        showRatingBottomSheet(context, (value) {
                          cubit.changeRate(value.floor());
                        }, () {
                          cubit.addComment(null, storeId);
                        }, cubit.commentController);
                      },
                      child: Row(
                        children: [
                          Text('addProduct.comments'.tr(),
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
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
              const SizedBox(height: 10),
              Column(
                spacing: 10,
                children: [
                  Column(
                      children: List.generate(
                    successLoadComments ? state.comment.length : 2,
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
                  if (state is GetStoresCommentsSuccess) ...{
                    if (state.comment.isNotEmpty &&
                        state.comment.length >= 5) ...{
                      Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_box,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          Text(
                            "addProduct.loadMore".tr(),
                            style: kTextStyle16Orange.copyWith(
                                color: AppColors.primary),
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
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
