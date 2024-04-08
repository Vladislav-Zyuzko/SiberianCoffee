import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/features/menu/bloc/order_bloc/order_bloc.dart';
import 'package:siberian_coffee/src/features/menu/view/widgets/product_image.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:siberian_coffee/src/theme/image_sources.dart';

class OrderBottomSheet extends StatelessWidget {
  final OrderActiveState orderState;

  const OrderBottomSheet({super.key, required this.orderState});

  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.92,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 12)),
          const DecoratedBox(
            decoration: BoxDecoration(
                color: AppColors.lightGreyD9,
                borderRadius: BorderRadius.all(Radius.circular(2))),
            child: SizedBox(
              height: 4,
              width: 48,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.yourOrder,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Image.asset(
                  ImageSources.iconDelete,
                  width: 24,
                  height: 24,
                )
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 5)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 9),
            child: Divider(
              thickness: 1,
              color: AppColors.lightGreyD9,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: orderState.orderList.length,
              separatorBuilder: (_, __) => const Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 100),
                            child: ProductImage(
                              imagePath: orderState.orderList[index].imagePath,
                              imageHeight: 55,
                              linearGradient: AppColors.shimmerGradient,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                          ),
                          Text(
                            orderState.orderList[index].productName,
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      ),
                      Text(
                        "${orderState.orderList[index].productCost.toInt()} ₽", 
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColors.primaryBlue),
            overlayColor: MaterialStateProperty.all<Color>(AppColors.darkBlue),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 16),
            ),
            fixedSize: MaterialStateProperty.all<Size>(
              Size(MediaQuery.of(context).size.width * 0.94, 56),
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          onPressed: () => {},
          child: Text(
            AppLocalizations.of(context)!.submitOrder,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ),
          )
        ],
      ),
    );
  }
}
