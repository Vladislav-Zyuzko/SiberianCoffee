import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/features/menu/models/address.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';
import 'package:siberian_coffee/src/theme/icons_source.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddressesScreeen extends StatelessWidget {
  final List<Address> addresses;

  const AddressesScreeen({super.key, required this.addresses});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              collapsedHeight: 60,
              automaticallyImplyLeading: false,
              pinned: true,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Container(
                      height: 52,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: AppColors.lightGreyE5,
                      ))),
                      child: Row(
                        children: [
                          IconButton(
                            splashColor: AppColors.darkBlue,
                            onPressed: () => Navigator.pop(context),
                            icon: Image.asset(
                              IconsSource.iconBackArrow,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 12)),
                          Text(
                            AppLocalizations.of(context)!.ourCoffeeShops,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.only(top: 16),
            ),
            SliverList.separated(
              itemCount: addresses.length,
              separatorBuilder: (_, __) {
                return const Padding(padding: EdgeInsets.only(top: 16));
              },
              itemBuilder: ((context, index) {
                return Material(
                  child: InkWell(
                    splashColor: AppColors.darkBlue,
                    onTap: () => Navigator.pop(context, addresses[index]),
                    child: SizedBox(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              addresses[index].address,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.primaryBlack,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
