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
    var screenWidth = MediaQuery.of(context).size.width * 0.7;

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: 50,
        height: 70,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(),
            ),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.lightGreenAccent, width: 5),
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.5),
                    Theme.of(context).primaryColor.withOpacity(0.1),
                  ]
                )
              ),
            ),
            
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Nev: ${widget.currentMember.name} Tartozas: ${widget.debitSum}")
              ),
            )
          ],
        ),
      ),
    );
  }
}
