import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';

class ScBottomSheet extends StatelessWidget {
  final double height;
  final String buttonText;
  final List<Widget> contentWidgets;
  final void Function() onPressed;

  const ScBottomSheet({
    super.key,
    required this.height,
    required this.buttonText,
    required this.contentWidgets,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
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
          const Padding(padding: EdgeInsets.only(top: 12)),
          ...contentWidgets,
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
                      Size(MediaQuery.of(context).size.width * 0.93, 56),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  onPressed: onPressed,
                  child: Text(
                    buttonText,
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
