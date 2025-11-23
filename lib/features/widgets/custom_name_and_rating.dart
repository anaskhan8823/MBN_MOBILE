import 'package:dalil_2020_app/features/widgets/rating_.dart';
import 'package:flutter/material.dart';

class CustomNameAndItsRating extends StatelessWidget {
  const CustomNameAndItsRating({
    super.key,
    required this.color,
    required this.name,
    required this.rating,
  });

  final Color color;
  final String name;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name,
                style: TextStyle(
                    color: color, fontSize: 18, fontWeight: FontWeight.bold)),
            RatingWidget(
              startFirst: true,
              rating: rating,
              color: color,
            ),
          ],
        ),
      ],
    );
  }
}
