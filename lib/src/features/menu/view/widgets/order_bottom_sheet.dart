import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/common/widgets/sc_bottom_sheet.dart';
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
    return ScBottomSheet(
      height: MediaQuery.of(context).size.height * 0.92, 
      buttonText: AppLocalizations.of(context)!.submitOrder, 
      contentWidgets: [
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
      ], 
      onPressed: () {
        orderBloc.add(OrderSendOrderEvent());
        Navigator.pop(context);
      },
    );
  }
}
