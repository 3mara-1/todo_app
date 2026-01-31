import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPicture extends StatelessWidget {
  CustomSvgPicture({
    super.key,
    required this.imageSrc,
    this.width,
    this.height,
    this.colorFilter = true,
  });
 CustomSvgPicture.withoutcolor({
    super.key,
    required this.imageSrc,
    this.width,
    this.height,
  }) : colorFilter = false;
  final String imageSrc;
  double? width;
  double? height;
  bool colorFilter;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      width: width,
      height: height,
      imageSrc,
      colorFilter:colorFilter? ColorFilter.mode(
        Theme.of(context).colorScheme.secondary,
        BlendMode.srcIn,
      ):null
    );
  }
}
