import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';

class ProductImage extends StatefulWidget {
  final String imagePath;
  final double imageHeight;
  final LinearGradient linearGradient;

  const ProductImage(
      {super.key,
      required this.imagePath,
      required this.imageHeight,
      required this.linearGradient
  });

  @override
  State createState() => _ProductCardImageState();
}

class _ProductCardImageState extends State<ProductImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerController;
  Gradient get gradient => LinearGradient(
        colors: widget.linearGradient.colors,
        stops: widget.linearGradient.stops,
        begin: widget.linearGradient.begin,
        end: widget.linearGradient.end,
        transform:
            _SlidingGradientTransform(slidePercent: _shimmerController.value),
      );

  @override
  void initState() {
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
    super.initState();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imagePath,
      height: widget.imageHeight,
      placeholder: (BuildContext context, String url) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            gradient: gradient,
          ),
          child: const SizedBox(
            height: 100,
            width: double.infinity,
          ),
        );
      },
      errorWidget: (context, url, error) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: AppColors.primaryPlatinum,
          ),
          child: SizedBox(
            height: widget.imageHeight,
            width: double.infinity,
            child: const Icon(
              Icons.coffee_rounded,
              size: 30,
              color: AppColors.priamaryGrey,
            ),
          ),
        );
      },
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
