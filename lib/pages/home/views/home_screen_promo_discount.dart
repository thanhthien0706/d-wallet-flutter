import 'package:carousel_slider/carousel_slider.dart';
import 'package:cn1_d_wallet/common/constant/app-colors.dart';
import 'package:cn1_d_wallet/common/constant/app-images.dart';
import 'package:cn1_d_wallet/common/constant/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreenPromoDiscount extends StatefulWidget {
  const HomeScreenPromoDiscount({Key? key}) : super(key: key);

  @override
  State<HomeScreenPromoDiscount> createState() =>
      _HomeScreenPromoDiscountState();
}

class _HomeScreenPromoDiscountState extends State<HomeScreenPromoDiscount> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List imageList = [
      {'id': 0, 'image_path': AppImages.imageDiscountBanner},
      {'id': 1, 'image_path': AppImages.imageDiscountBanner},
      {'id': 2, 'image_path': AppImages.imageDiscountBanner},
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Promo & Discount",
                style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "See More",
                style: AppStyles.h5.copyWith(color: AppColors.primaryColor),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        CarouselSlider(
          items: imageList.map(
            (item) {
              return Padding(
                padding: const EdgeInsets.only(left: 16),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: SvgPicture.asset(
                    item["image_path"],
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ).toList(),
          carouselController: carouselController,
          options: CarouselOptions(
            initialPage: 0,
            scrollDirection: Axis.horizontal,
            enableInfiniteScroll: true,
            padEnds: false,
            autoPlay: false,
            height: 170,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => carouselController.animateToPage(entry.key),
              child: Container(
                width: currentIndex == entry.key ? 30 : 7,
                height: 8.0,
                margin: const EdgeInsets.symmetric(
                  horizontal: 3.0,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: currentIndex == entry.key
                        ? AppColors.primaryColor
                        : AppColors.greyText),
              ),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}
