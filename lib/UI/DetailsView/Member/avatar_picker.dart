import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MemberAvatarPicker extends StatefulWidget {
  const MemberAvatarPicker({Key? key, required this.seed, required this.onChange}) : super(key: key);

  final String seed;
  final ValueChanged<String> onChange;

  @override
  State<MemberAvatarPicker> createState() => _MemberAvatarPickerState();
}

class _MemberAvatarPickerState extends State<MemberAvatarPicker> {
  late String svgCode;
  DrawableRoot? svgRoot;

  _generateSvg() async {
    return SvgWrapper(svgCode).generateLogo().then((value) {
      setState(() {
        svgRoot = value;
      });
    }).then((value) => widget.onChange(svgCode));
  }

  @override
  void initState() {
    super.initState();
    svgCode = multiavatar(widget.seed);
    _generateSvg();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 20),
      child: Row(
        children: [
          const Text(
              "Válassz avatárt: "
          ),
          Container(
            height: 45,
            width: 45,
            margin: const EdgeInsets.only(left: 33),
            child: svgRoot == null
              ? const SizedBox.shrink()
              : CustomPaint(
                  painter: MyPainter(svgRoot!, const Size(45,45)),
                  child: Container(),
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: IconButton(
              onPressed: () {
                var l = List.generate(12, (_) => Random().nextInt(100));
                setState(() {
                  svgCode = multiavatar(l.join());
                });
                _generateSvg();
              },
              icon: const Icon(Icons.refresh),
              color: Colors.black,
              iconSize: 35,
              splashRadius: 25,
            )
          )
        ],
      ),
    );
  }
}

class SvgWrapper {
  final String rawSvg;

  SvgWrapper(this.rawSvg);

  Future<DrawableRoot?> generateLogo() async {
    try {
      //print(rawSvg);
      return await svg.fromSvgString(rawSvg, rawSvg);
    } catch (e) {
      //print(e);
      return null;
    }
  }
}

class MyPainter extends CustomPainter {
  MyPainter(this.svg, this.avatarSize);

  final DrawableRoot svg;
  final Size avatarSize;
  @override
  void paint(Canvas canvas, Size size) {
    svg.scaleCanvasToViewBox(canvas, avatarSize);
    svg.clipCanvasToViewBox(canvas);
    svg.draw(canvas, Rect.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

