import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterhf/UI/DetailsView/Member/avatar.dart';
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


    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 50, right: 20),
            width: 300,
            height: 80,
           
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(),
                ),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightGreenAccent, width: 3),
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
                  padding: const EdgeInsets.only(left: 40),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Nev: ${widget.currentMember.name} Tartozas: ${widget.debitSum}")
                  ),
                ),


            ],
          ),
        ),
          Positioned(
            left: 25,
            top: 11,
            child: Container(
              width: 60,
              height: 60,
              padding: EdgeInsets.only(top: 3, left: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.lightGreenAccent,

              ),
              child: MemberAvatar(
                svgCode: widget.currentMember.avatar!,
                size: const Size(53, 53),
              ),
            ),
          )
        ]
      ),
    );
  }
}
