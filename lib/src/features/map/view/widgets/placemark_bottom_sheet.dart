import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/common/widgets/sc_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:siberian_coffee/src/features/menu/models/address.dart';

class PlacemarkBottomSheet extends StatelessWidget {
  final Address choosedAddress;

  const PlacemarkBottomSheet({super.key, required this.choosedAddress});

  @override
  Widget build(BuildContext context) {
    return ScBottomSheet(
      height: MediaQuery.of(context).size.height * 0.21,
      buttonText: AppLocalizations.of(context)!.placemarkChoose,
      contentWidgets: [
        FittedBox(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.93,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  choosedAddress.address,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ),
        ),
      ],
      onPressed: () {
        Navigator.pop(context, choosedAddress);
      },
    );
  }
}
