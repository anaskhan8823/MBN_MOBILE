import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/style/app_size.dart';
import '../../../../auth/presentation/screens/register/units/upload_photo_card.dart';
import '../../../../widgets/form_of_store_and_products.dart';
class GeneralInformation extends StatelessWidget {
  const GeneralInformation({super.key});
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
              const UploadPhotoCard(url: '',),
              FormOfStoreAndProducts(cubit: cubit,isStore: true,),
            ],
          ),
        );
      },
    );
  }
}

