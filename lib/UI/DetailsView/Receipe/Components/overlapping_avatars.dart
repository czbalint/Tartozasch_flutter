import 'package:flutter/material.dart';
import 'package:flutterhf/UI/DetailsView/Member/avatar.dart';

import '../../Member/member.dart';

class OverlappingAvatars extends StatelessWidget {
  const OverlappingAvatars({Key? key, required this.members}) : super(key: key);

  final List<Member> members;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 95,
      child: Stack(
        children: [
          MemberAvatar(
              svgCode: members[0].avatar ?? ""
          ),
          Builder(
            builder: (context) {
              if (members.length > 1) {
                return Positioned(
                  left: 25,
                  child:  MemberAvatar(
                      svgCode: members[1].avatar ?? "a"
                  )
                );
              }
              return Container();
            }
          ),
          Builder(
            builder: (context) {
              if (members.length > 2) {
                return Positioned(
                  left: 50,
                  child: MemberAvatar(
                      svgCode: members[2].avatar ?? "a"
                  )
                );
              }
              return Container();
            }
          ),
        ],
      ),
    );
  }
}
