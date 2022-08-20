import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutterhf/UI/DetailsView/Member/member.dart';
import 'package:flutterhf/UI/DetailsView/Summary/member_carousel.dart';
import 'package:flutterhf/UI/DetailsView/Summary/summary_list_item.dart';
import 'package:flutterhf/UI/GroupView/group.dart';


class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key, required this.group}) : super(key: key);

  final Group group;

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  Color? backGroundColor = Colors.grey.shade300;
  late Member selectedMember;
  Map<int, double> memberDebits = {};

  @override
  void initState() {
    selectedMember = widget.group.members[0];
    backGroundColor = widget.group.members[0].color;
    sumDebit();
    super.initState();
  }

  void sumDebit() {
    memberDebits.clear();
    for (var debit in selectedMember.debits){
      if (memberDebits.containsKey(debit.memberId)){
        memberDebits.update(debit.memberId, (value) => debit.income ? value + debit.count : value - debit.count);
      } else {
        memberDebits.addAll({debit.memberId : debit.income ? debit.count : -debit.count});
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Összesítés"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Row(
            children: [
              AnimatedContainer(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width ,
                  decoration: BoxDecoration(
                      color: backGroundColor,
                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 30,
                            blurStyle: BlurStyle.normal
                        )
                      ]
                  ),
                  duration: const Duration(milliseconds: 500),
                  child: MemberCarousel(
                    group: widget.group,
                    onChange: (Member member) {
                      setState(() {
                          backGroundColor = member.color;
                          selectedMember = member;
                          sumDebit();
                      });
                    },
                  )
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: ListView.builder(
                itemCount: widget.group.members.length,
                itemBuilder: (context, index) {
                  var cm = widget.group.members[index];
                  if (memberDebits.containsKey(cm.id) && cm.id != selectedMember.id) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: MemberListItem(
                        currentMember: cm,
                        debitSum: memberDebits[cm.id]!,
                      ),
                    );
                  }
                  return Container();
                }
              ),
            ),
          )
        ],
      ),
    );
  }
}

