import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/text_style.dart';
import '../../../delivery_user_view/widget/button_widget.dart';
import '../../data/model/comments_model.dart';
import '../controller/posts_cubit.dart';

class AlertOfUpdateComment extends StatefulWidget {
  final CommentsModel data;
  AlertOfUpdateComment({required this.data});

  @override
  State<AlertOfUpdateComment> createState() => _AlertOfUpdateCommentState();
}

class _AlertOfUpdateCommentState extends State<AlertOfUpdateComment> {
  TextEditingController controllerTextField = TextEditingController();
  @override
  void initState() {
    controllerTextField.text = widget.data.content ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: TextField(
        scrollPadding: EdgeInsets.zero,
        controller: controllerTextField,
        decoration: InputDecoration(
          hintText: context.tr('posts.enterYouComment'),
          filled: true,
          fillColor: AppColors.primaryLight.withOpacity(.2),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.primaryLight),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryLight),
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: ButtonWidget(
                height: 45.h,
                width: MediaQuery.of(context).size.width / 2,
                backgroundColor: AppColors.primaryLight,
                borderColor: AppColors.primaryLight,
                borderWidth: 1,
                borderRadius: 50,
                onPressed: () async {
                  context.read<PostsCubit>().updateComment(
                      commentId: widget.data.id ?? 0,
                      message: controllerTextField.text);
                },
                body: Text(context.tr('posts.edit'),
                    style: kTextStyle16white.copyWith(
                        color: AppColors.isDark()
                            ? AppColors.black
                            : AppColors.white)),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: ButtonWidget(
                height: 45.h,
                width: MediaQuery.of(context).size.width / 2,
                backgroundColor: AppColors.isDark()
                    ? AppColors.primaryLight.withOpacity(.2)
                    : Colors.white,
                borderColor: AppColors.primaryLight,
                borderWidth: 1,
                borderRadius: 50,
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                body: Text(context.tr('deliveryUserView.cancel'),
                    style: kTextStyle16white.copyWith(
                        color: AppColors.isDark()
                            ? AppColors.white
                            : AppColors.black)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
