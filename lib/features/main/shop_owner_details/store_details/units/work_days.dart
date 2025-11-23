part of '../other_details.dart';
class WorkDaysAndTimes extends StatelessWidget {
   WorkDaysAndTimes({
    super.key,
    required this.isWorkDay,
  });
  List<String>workDays=[
    'Saturday','Sunday','Monday'
  ];

  final bool isWorkDay;

  @override
  Widget build(BuildContext context) {
    return Column(
        spacing: 10,
        children: List.generate(
            3,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                      child: Row(
                        children: [
                          CustomSvg(svg: AppSvg.date),
                          const SizedBox(width: 8),
                          Text(
                            workDays[index],
                            style:
                            const TextStyle(color: Colors.white),
                          ),
                          const Spacer(),
                          Container(
                            width: 60,
                            height: 30,
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius:
                                BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Work',
                                style: TextStyle(
                                    fontSize: AppSize.getSize(14),
                                    color: isWorkDay ? Colors.black : AppColors.white),
                              ),),)],),),
                    const SizedBox(height: 8),
                    Row(
                        spacing: 5,
                        children: [
                          Expanded(
                            child:Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isWorkDay
                                    ? Colors.grey[900]
                                    : const Color(0xff545454),
                                borderRadius:
                                BorderRadius.circular(22),
                              ),
                              child: Row(
                                children: [
                                  CustomSvg(svg: AppSvg.solidTime),
                                  const SizedBox(width: 8),
                                  Text(
                                    "12:10",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: AppSize.getSize(14),
                                        fontWeight:
                                        FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isWorkDay
                                    ? Colors.grey[900]
                                    : const Color(0xff545454),
                                borderRadius:
                                BorderRadius.circular(22),
                              ),
                              child: Row(
                                children: [
                                  CustomSvg(svg: AppSvg.solidTime),
                                  const SizedBox(width: 8),
                                  Text(
                                    "10:00",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: AppSize.getSize(14),
                                        fontWeight:
                                        FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ])
                  ],
                )));
  }
}
