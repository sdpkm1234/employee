import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_data/utils/app_img_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class AppImage extends StatelessWidget {
  const AppImage({super.key, required this.image});

  final Widget image;

  AppImage.network(
    String imageUrl, {
    super.key,
    double? width,
    double? height,
    BoxFit? fit,
  }) : image = CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          errorWidget: (context, url, _) =>
              Center(child: AppImage.placeholder()),
        );

  AppImage.asset(
    String asset, {
    super.key,
    double? width,
    double? height,
    BoxFit? fit,
  }) : image = Image.asset(
          asset,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => AppImage.placeholder(),
        );

  AppImage.svg(
    String asset, {
    super.key,
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) : image = SvgPicture.asset(
          asset,
          width: width,
          height: height,
          color: color,
          fit: fit ?? BoxFit.contain,
        );

  AppImage.placeholder({
    super.key,
    double? width,
    double? height,
  }) : image = SvgPicture.asset(
          AppImgConst.icPlaceholder,
          width: width,
          height: height,
        );

  @override
  Widget build(BuildContext context) {
    return image;
  }
}
