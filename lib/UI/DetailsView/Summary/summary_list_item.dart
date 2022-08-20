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
  List<Color> greenGradient = [
    Colors.lightGreen.withOpacity(0.5),
    Colors.lightGreen.withOpacity(0.1),
  ];

  List<Color> redGradient = [
    Colors.redAccent.withOpacity(0.5),
    Colors.redAccent.withOpacity(0.1),
  ];

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
                      colors: widget.debitSum < 0.0 ? redGradient : greenGradient
                    )
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  widget.currentMember.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17
                                  ),
                                ),
                              ),
                              const Text(
                                "Név",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  widget.debitSum.toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17
                                  ),
                                ),
                              ),
                              const Text(
                                "Összeg",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
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
              padding: const EdgeInsets.only(top: 3, left: 4),
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
