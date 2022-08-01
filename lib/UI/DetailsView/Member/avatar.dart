import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'avatar_picker.dart';

class MemberAvatar extends StatefulWidget {
  const MemberAvatar({Key? key, required this.svgCode, this.size = const Size(45, 45)}) : super(key: key);

  final String svgCode;
  final Size size;

  @override
  State<MemberAvatar> createState() => _MemberAvatarState();
}

class _MemberAvatarState extends State<MemberAvatar> {

  DrawableRoot? svgRoot;

  _generateSvg() async {
    return SvgWrapper(widget.svgCode).generateLogo().then((value) {
      setState(() {
        svgRoot = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _generateSvg();
  }

  @override
  Widget build(BuildContext context) {
    if (svgRoot != null) {
      return  CustomPaint(
        painter: MyPainter(svgRoot!, widget.size),
        child: Container(),
      );
    }
    return Container();
  }
}
