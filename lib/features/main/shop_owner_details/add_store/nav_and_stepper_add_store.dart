import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/helper/app_toast.dart';
import 'package:dalil_2020_app/features/auth/presentation/city_and_country/cubit/location_cubit.dart';
import 'package:dalil_2020_app/features/controller/upload_profie_image_cubit/upload_photo_cubit.dart';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/widgets/auth_appbar.dart';
import '../../../auth/presentation/controllers/map_cubit.dart';
import '../../../widgets/custpm_store_nav_bar.dart';
import '../../../widgets/stepper.dart';
import '../../controller/stepper_and_add_product_cubit.dart';

class NavAddStore extends StatelessWidget {
  const NavAddStore({super.key, this.storeId});
  final int? storeId;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => StepperAndNavAddProductCubit(),
        ),
        BlocProvider(
          create: (_) => StoreAndProductCubit()..getCategories(),
        ),
        BlocProvider(
          create: (_) => UploadPhotoCubit(),
        ),
        BlocProvider(
          create: (_) => LocationCubit(),
        ),
        BlocProvider(create: (_) => MapCubit()),
      ],
      child: BlocBuilder<StepperAndNavAddProductCubit, int>(
        builder: (context, currentIndex) {
          final cubit = context.read<StepperAndNavAddProductCubit>();
          final addCubit = context.read<StoreAndProductCubit>();
          final uploadCubit = context.read<UploadPhotoCubit>();
          final locCubit = context.read<LocationCubit>();
          final map = context.read<MapCubit>();
          return Scaffold(
            appBar: AuthAppbar(
              onTap: AppNavigator.pop,
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
                if (currentIndex == 0 && uploadCubit.profileImage == null) {
                  AppToast.error("Upload Store Image First");

                  // yahan chahe to snackbar/dialog bhi dikha sakte ho
                  return;
                }
                print("Final location before signup: ${map.selectedLocation}");
                if (currentIndex != 2 &&
                    currentIndex != 3 &&
                    !cubit.formKey.currentState!.validate()) {
                  return;
                }
                if (currentIndex == 3) {
                  final location = context.read<MapCubit>().state.location;

                  if (location == null) {
                    print("❌ Location null hai, pehle select/update karo");
                    return;
                  }

                  addCubit.addStore(
                    locCubit.cityId ?? 0,
                    locCubit.countryId ?? 0,
                    uploadCubit.profileImage,
                    locCubit.selectedValue ?? '',
                    location,
                  );

                  print("📌 Location saved with store: $location");
                }

                print("UPDATEDs dd${context.read<MapCubit>().state.location}");

                print("UPDATEDs  dd${context.read<MapCubit>().state.location}");

                cubit.nextSection(currentIndex);
              },
              onBack: () {
                cubit.backSection(currentIndex);
              },
              index: currentIndex,
            ),
            body: cubit.tabs[currentIndex],
          );
        },
      ),
    );
  }
}
