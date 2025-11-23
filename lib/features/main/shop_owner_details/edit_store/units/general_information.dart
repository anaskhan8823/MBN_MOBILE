import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:dalil_2020_app/features/widgets/custom_field_with_hint_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app_assets.dart';
import '../../../../../core/style/app_size.dart';
import '../../../../auth/presentation/screens/register/units/upload_photo_card.dart';
class EditGeneralInformation extends StatelessWidget {
  const EditGeneralInformation({super.key, this.storeImage, this.arStoreName, this.enStoreName, this.arStoreDesc, this.enStoreDesc});
  final String ?storeImage;
  final String ?arStoreName;
  final String ?enStoreName;
  final String ?arStoreDesc;
  final String ?enStoreDesc;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreAndProductCubit, StoreAndProductState>(
      builder: (context, state) {
        final cubit= context.read<StoreAndProductCubit>();
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: AppSize.getHeight(14),
            children: [
               Text(
                 'addStore.fill'.tr(),
                 style: TextStyle(fontSize: 14,
                     color: AppColors.whiteAndBlackColor),
                 textAlign: TextAlign.center,
               ),
               UploadPhotoCard(url:storeImage ,),
                  CustomFieldWithHint(
                    hintText: arStoreName,
                    controller:cubit.arabicName,
                    iconStart: AppSvg.store,
                  ),
                  CustomFieldWithHint(
                    hintText: enStoreName,
                    controller:cubit.englishName,
                    iconStart: AppSvg.store,
                  ),
                  CustomFieldWithHint(
                    maxLines: 5,
                    maxLength: 500,
                    minLines: 5,
                    hintText: arStoreDesc,
                    controller:cubit.arabicDisc,
                  ),
                  CustomFieldWithHint(
                    maxLines: 5,
                    maxLength: 500,
                    minLines: 5,
                    hintText: enStoreDesc,
                    controller:cubit.englishDisc,
                  ),
                  const SizedBox(),

              // FormOfStoreAndProducts(cubit: cubit,isStore: true,),
            ],
          ),
        );
      },
    );
  }
}

