// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dalil_2020_app/core/style/app_size.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/style/app_colors.dart';
// import '../../controller/slider_cubit.dart';
// import 'dotted_slider.dart';

// class CustomSliderItem extends StatelessWidget {
//   const CustomSliderItem({
//     super.key,
//     this.color,
//   });
//   final Color? color;
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => SliderCubit(),
//       child: BlocBuilder<SliderCubit, int>(
//         builder: (context, currentIndex) {
//           final cubit = context.read<SliderCubit>();
//           return Column(
//             spacing: 12,
//             children: [
//               CarouselSlider(
//                 options: CarouselOptions(
//                     height: AppSize.getHeight(170),
//                     enlargeCenterPage: false,
//                     autoPlay: true,
//                     viewportFraction: 1.0,
//                     onPageChanged: (index, reason) {
//                       cubit.changeSliderIndex(index);
//                     }),
//                 items: cubit.sliderImages.map((item) {
//                   return Builder(
//                     builder: (BuildContext context) {
//                       return Container(
//                         width: MediaQuery.of(context).size.width * 0.9,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                               color: color ?? AppColors.primary, width: 4),
//                           borderRadius: BorderRadius.circular(15),
//                           color: color ?? AppColors.primary,
//                           image: DecorationImage(
//                             image: AssetImage(item),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }).toList(),
//               ),
//               DottedSlider(
//                 sliderImages: cubit.sliderImages,
//                 currentIndex: currentIndex,
//                 color: color,
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dalil_2020_app/core/style/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/style/app_colors.dart';
import '../../controller/slider_cubit.dart';
import 'dotted_slider.dart';

class CustomSliderItem extends StatelessWidget {
  const CustomSliderItem({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SliderCubit()..fetchSliderImages(),
      child: BlocBuilder<SliderCubit, SliderState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: AppSize.getHeight(170),
                  enlargeCenterPage: false,
                  autoPlay: true,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    context.read<SliderCubit>().changeSliderIndex(index);
                  },
                ),
                items: state.images.map((item) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: color ?? AppColors.primary, width: 4),
                      borderRadius: BorderRadius.circular(15),
                      color: color ?? AppColors.primary,
                      image: DecorationImage(
                        image: NetworkImage(item), // ✅ API image
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 10,
              ),
              DottedSlider(
                sliderImages: state.images,
                currentIndex: state.currentIndex,
                color: color,
              ),
            ],
          );
        },
      ),
    );
  }
}
