import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/features/menu/bloc/order_bloc/order_bloc.dart';
import 'package:siberian_coffee/src/features/menu/view/widgets/order_divider.dart';
import 'package:siberian_coffee/src/features/menu/view/widgets/product_image.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:siberian_coffee/src/theme/icons_source.dart';

class OrderBottomSheet extends StatelessWidget {
  final OrderBloc orderBloc;

  const OrderBottomSheet({super.key, required this.orderBloc});

  @override
  Widget build(BuildContext context) {
    OrderActiveState orderState = orderBloc.state as OrderActiveState;
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
                IconButton(
                  onPressed: () {
                    orderBloc.add(OrderClearEvent());
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    IconsSource.iconDelete,
                    width: 24,
                    height: 24,
                  ),
                )
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 5)),
          const OrderDivider(),
          Padding(
            padding:
                const EdgeInsets.only(top: 15, bottom: 10, left: 10, right: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: RawScrollbar(
                radius: const Radius.circular(5),
                thickness: 10,
                scrollbarOrientation: ScrollbarOrientation.left,
                thumbColor: AppColors.darkGrey,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: orderState.orderList.length,
                  separatorBuilder: (_, __) => const Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 100),
                                child: ProductImage(
                                  imagePath:
                                      orderState.orderList[index].imagePath,
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
            ),
          ),
          const OrderDivider(),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.primaryBlue),
                    overlayColor:
                        MaterialStateProperty.all<Color>(AppColors.darkBlue),
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
                  onPressed: () {
                    orderBloc.add(OrderSendOrderEvent());
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.submitOrder,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
