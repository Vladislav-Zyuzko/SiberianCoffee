import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/features/menu/bloc/order_bloc/order_bloc.dart';
import 'package:siberian_coffee/src/features/menu/models/product.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurchaseControllPanel extends StatelessWidget {
  final Product product;

  const PurchaseControllPanel({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    OrderBloc orderBloc = BlocProvider.of<OrderBloc>(context);
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        int currentProductCount = state is OrderActiveState
            ? state.orderList.where((product) => product == this.product).length
            : 0;
        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          firstChild: PurchaseControllBuyButton(
              onTap: () =>
                  orderBloc.add(OrderAddProductEvent(product: product)),
              productCost: "${product.productCost.toInt()}"),
          secondChild: PurchaseController(
            currentProductCount: currentProductCount,
            incrementFunction: () => orderBloc.add(OrderAddProductEvent(product: product)),
            decrementFunction: () => orderBloc.add(OrderRemoveProductEvent(product: product)),
          ),
          crossFadeState: currentProductCount == 0
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        );
      },
    );
  }
}

class PurchaseControllBuyButton extends StatelessWidget {
  final Function() onTap;
  final String productCost;
  const PurchaseControllBuyButton(
      {super.key, required this.onTap, required this.productCost});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryBlue,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        highlightColor: AppColors.middleBlue,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 24,
          width: 116,
          child: Center(
            child: Text(
                "$productCost ${AppLocalizations.of(context)!.shortRub}",
                style: Theme.of(context).textTheme.bodySmall),
          ),
        ),
      ),
    );
  }
}

class PurchaseController extends StatelessWidget {
  final int currentProductCount;
  final void Function() incrementFunction;
  final void Function() decrementFunction;
  const PurchaseController(
      {super.key,
      required this.currentProductCount,
      required this.incrementFunction,
      required this.decrementFunction});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PurchaseControllButton(
          onTap: decrementFunction,
          iconData: Icons.remove,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.primaryBlue,
          ),
          width: 52,
          height: 24,
          child: Center(
            child: Text(
              "$currentProductCount",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
        PurchaseControllButton(
          onTap: incrementFunction,
          iconData: Icons.add,
        ),
      ],
    );
  }
}

class PurchaseControllButton extends StatelessWidget {
  final void Function() onTap;
  final IconData iconData;
  const PurchaseControllButton(
      {super.key, required this.onTap, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: AppColors.primaryBlue,
      child: InkWell(
        highlightColor: AppColors.middleBlue,
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: SizedBox(
          width: 24,
          height: 24,
          child: Icon(iconData, color: AppColors.primaryWhite, size: 16),
        ),
      ),
    );
  }
}
