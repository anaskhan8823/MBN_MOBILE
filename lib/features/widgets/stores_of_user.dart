part of '../main/home/components/home_shop_owner.dart';

class StoresOfUser extends StatelessWidget {
  StoresOfUser({
    super.key,
    required this.success,
    required this.successLoadUserData,
    this.loading,
    required this.cubit,
  });

  final bool successLoadUserData;
  final GetStoresSuccess? success;
  final bool? loading;
  final cubit;

  @override
  Widget build(BuildContext context) {
    if (success is GetStoresSuccess && success?.stores != null) {
      if (success!.stores.isEmpty) return const EmptyStores();

      final isEn = context.locale.languageCode == 'en';

      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.32,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: success!.stores.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, childAspectRatio: 1.4),
              itemBuilder: (context, index) {
                final store = success!.stores[index];

                // Safe access to first category/subCategory
                final mainCategory = store.category?.isNotEmpty == true
                    ? store.category!.first
                    : '';
                final subCategory = store.subCategory?.isNotEmpty == true
                    ? store.subCategory!.first
                    : '';

                final storeImage = store.images?.isNotEmpty == true
                    ? store.images!.first.url ?? ''
                    : '';

                return GestureDetector(
                  onTap: () {
                    // print(
                    //     "store.products store.products store.products${store.products![0].price}");
                    // Skip if essential data is missing
                    if (store.storeName == null ||
                        store.description == null ||
                        store.location?.country == null ||
                        store.location?.city == null) return;

                    AppNavigator.push(
                      StoreDetailsScreen(
                        mainCategoryName: mainCategory,
                        subCategoryName: subCategory,
                        storeArabicName: store.storeName?.ar ?? '',
                        storeEnglishName: store.storeName?.en ?? '',
                        storeArabicDesc: store.description?.ar ?? '',
                        storeEnglishDesc: store.description?.en ?? '',
                        location: store.location,
                        address: store.contactInfo?.address ?? '',
                        phone: store.contactInfo?.mobileNumber ?? '',
                        workingTimes: store.workingTimes ?? [],
                        dialCode: store.location!.country!.dialCode ?? '',
                        country: store.location!.country!.name ?? '',
                        city: store.location!.city!.name ?? '',
                        description: isEn
                            ? store.description!.en ?? ''
                            : store.description!.ar ?? '',
                        onDelete: () => cubit.deleteStore(store.id ?? 0),
                        storeId: store.id ?? 0,
                        rating: store.rating.toString() ?? "0.0",
                        views: 0,
                        storeName: isEn
                            ? store.storeName!.en ?? ''
                            : store.storeName!.ar ?? '',
                        storeImage: storeImage,
                        endDate: store.subscriptionEndDate ?? '',
                        products: store.products ?? [],
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSize.getHeight(8),
                      horizontal: AppSize.getWidth(4),
                    ),
                    child: StoreCard(
                      imageUrl: storeImage,
                      products: store.productsCount ?? 0,
                      rating: store.rating.toString() ?? "0",
                      storeName: isEn
                          ? store.storeName!.en ?? ''
                          : store.storeName!.ar ?? '',
                      views: 0,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return Skeletonizer(
        enabled: loading == true,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.36,
          child: const StoresLoading(),
        ),
      );
    }
  }
}
