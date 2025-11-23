import 'package:dalil_2020_app/features/auth/presentation/city_and_country/cubit/location_cubit.dart';
import 'package:dalil_2020_app/features/controller/upload_profie_image_cubit/upload_photo_cubit.dart';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:dalil_2020_app/features/main/shop_owner_details/edit_store/units/contact.dart';
import 'package:dalil_2020_app/features/main/shop_owner_details/edit_store/units/details.dart';
import 'package:dalil_2020_app/features/main/shop_owner_details/edit_store/units/general_information.dart';
import 'package:dalil_2020_app/features/main/shop_owner_details/edit_store/units/store_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helper/dialogs.dart';
import '../../../../core/shared/widgets/auth_appbar.dart';
import '../../../../models/store_model.dart';
import '../../../widgets/custpm_store_nav_bar.dart';
import '../../../widgets/stepper.dart';
import '../../controller/stepper_and_add_product_cubit.dart';

class NavEditStore extends StatelessWidget {
  const NavEditStore(
      {super.key,
      required this.storeId,
      this.storeImage,
      this.arStoreName,
      this.enStoreName,
      this.arStoreDesc,
      this.enStoreDesc,
      this.subCategoryName,
      this.mainCategoryName,
      this.subScriptionEndDate,
      this.city,
      this.phoneNumber,
      this.country,
      this.address,
      this.dialCode,
      required this.workingTimes});
  final int storeId;
  final String? storeImage;
  final String? arStoreName;
  final String? enStoreName;
  final String? arStoreDesc;
  final String? enStoreDesc;
  final String? subCategoryName;
  final String? mainCategoryName;
  final String? subScriptionEndDate;
  final String? city;
  final String? phoneNumber;
  final String? country;
  final String? address;
  final String? dialCode;
  final List<WorkingTime> workingTimes;
  @override
  Widget build(BuildContext context) {
    final tabsOdEditStore = <Widget>[
      EditGeneralInformation(
        arStoreName: arStoreName,
        enStoreDesc: enStoreDesc,
        arStoreDesc: arStoreDesc,
        enStoreName: enStoreName,
        storeImage: storeImage,
      ),
      EditContactStore(
        dialCode: dialCode,
        address: address,
        phoneNumber: phoneNumber,
        city: city,
        country: country,
      ),
      EditStoreDetails(
        mainCategoryName: mainCategoryName,
        subCategoryName: subCategoryName,
        subScriptionEndDate: subScriptionEndDate,
      ),
      EditStoreWorkTimes(
        workingTimes: workingTimes,
      )
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => StepperAndNavAddProductCubit(),
        ),
        BlocProvider(
          create: (_) => StoreAndProductCubit()
            ..getCategories()
            ..getStoreDetails(storeId),
        ),
        BlocProvider(
          create: (_) => UploadPhotoCubit(),
        ),
        BlocProvider(
          create: (_) => LocationCubit(),
        ),
      ],
      child: BlocBuilder<StepperAndNavAddProductCubit, int>(
        builder: (context, currentIndex) {
          final cubit = context.read<StepperAndNavAddProductCubit>();
          final addCubit = context.read<StoreAndProductCubit>();
          final uploadCubit = context.read<UploadPhotoCubit>();
          final locCubit = context.read<LocationCubit>();
          return Scaffold(
            appBar: AuthAppbar(
              onTap: () {
                displayDiscardChangesSheetSheet(context, null);
              },
              showLang: false,
              title: "addStore.storeDetails",
              heightAppBar: 120,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomStepper(
                    onStepReached: (currentIndex) =>
                        cubit.onStepReached(currentIndex),
                    activeStep: cubit.activeStep,
                  ),
                ),
              ),
            ),
            bottomNavigationBar: CustomStoreNavBar(
              onNext: () {
                if (currentIndex == 3) {
                  addCubit.editStoreDetails(
                      locCubit.cityId,
                      locCubit.countryId,
                      uploadCubit.profileImage,
                      locCubit.selectedValue,
                      storeId);
                }
                cubit.nextSection(currentIndex);
              },
              onBack: () {
                cubit.backSection(currentIndex);
              },
              index: currentIndex,
            ),
            body: tabsOdEditStore[currentIndex],
          );
        },
      ),
    );
  }
}
