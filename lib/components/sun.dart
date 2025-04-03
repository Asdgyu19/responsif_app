import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../size_config.dart';

class Sun extends StatelessWidget {
  const Sun({
    Key? key, // Menyesuaikan dengan null safety
    required Duration duration, // Menyesuaikan dengan null safety
    required this.isFullSun, // Menyesuaikan dengan null safety
  })  : _duration = duration,
        super(key: key);

  final Duration _duration;
  final bool isFullSun;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: _duration,
      curve: Curves.easeInOut,
      left: getProportionateScreenWidth(30), // Mengatur posisi matahari secara horizontal
      bottom: getProportionateScreenWidth(isFullSun ? -45 : -120), // Mengatur posisi vertikal berdasarkan status
      child: SvgPicture.asset("assets/icons/Sun.svg"), // Menampilkan gambar SVG untuk matahari
    );
  }
}
