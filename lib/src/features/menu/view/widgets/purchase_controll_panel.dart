import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/features/menu/bloc/product_counter_bloc/product_counter_bloc.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurchaseControllPanel extends StatelessWidget {
  final double productCost;

  const PurchaseControllPanel({super.key, required this.productCost});

  @override
  Widget build(BuildContext context) {
    final productCounterBloc = ProductCounterBloc();
    return BlocProvider<ProductCounterBloc>(
      create: (context) => productCounterBloc,
      child: BlocBuilder<ProductCounterBloc, ProductCounterState>(
        builder: (context, state) {
          return AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            firstChild: PurchaseControllBuyButton(
                onTap: () => productCounterBloc.add(ProductCounterActivateEvent()),
                productCost: "${productCost.toInt()}"),
            secondChild: PurchaseController(
              currentProductCount: productCounterBloc.state.countProducts,
              incrementFunction: () =>
                  productCounterBloc.add(ProductCounterIncEvent()),
              decrementFunction: () =>
                  productCounterBloc.add(ProductCounterDecEvent()),
            ),
            crossFadeState: !state.counterIsActive
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          );
        },
      ),
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
        highlightColor: AppColors.darkBlue,
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
        highlightColor: AppColors.darkBlue,
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
