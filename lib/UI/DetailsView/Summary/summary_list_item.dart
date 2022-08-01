import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterhf/UI/DetailsView/Member/member.dart';

class MemberListItem extends StatefulWidget {
  const MemberListItem({Key? key, required this.currentMember, required this.debitSum}) : super(key: key);

  final Member currentMember;
  final double debitSum;

  @override
  State<MemberListItem> createState() => _MemberListItemState();
}

class _MemberListItemState extends State<MemberListItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 5.0 ,sigmaX: 5.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 70,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.greenAccent.shade200.withOpacity(0.5),
                        Colors.greenAccent.shade100.withOpacity(0.5)
                      ],
                    stops: [0.2, 1.0]
                  ),
                  borderRadius: BorderRadius.circular(30),

              ),
            ),
          ),
        ),
      ],
    );
  }
}
