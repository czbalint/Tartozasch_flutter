import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhf/Cubit/receipt_cubit.dart';
import 'package:flutterhf/Cubit/member_cubit.dart';
import 'package:flutterhf/UI/DetailsView/Member/add_member_dialog.dart';
import 'package:flutterhf/UI/DetailsView/Member/members_list.dart';
import 'package:flutterhf/UI/DetailsView/details_sum_dialog.dart';
import 'package:flutterhf/UI/GroupView/group.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import 'Receipe/receipt_list.dart';


class GroupDetails extends StatefulWidget {
  final Group group;

  const GroupDetails({Key? key, required this.group}) : super(key: key);

  @override
  State<GroupDetails> createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {

  @override
  Widget build(BuildContext context) {
    context.read<ReceiptCubit>().refreshGroup(widget.group);
    context.read<MemberCubit>().refreshGroup(widget.group);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.title),
        backgroundColor: const Color.fromARGB(255, 66, 138, 40),
        actions: <Widget>[
          Builder(
            builder: (context) {
              if (!widget.group.archive) {
                return IconButton(
                  tooltip: "Új csoporttag felvétele",
                  onPressed: () {
                      showDialog(context: context, builder: (BuildContext context) {
                          return const AddMemberDialog();
                      });
                  },
                  icon: const Icon(
                    Icons.person_add,
                    size: 30,
                  )
                );
              }
              return Container();
            }
          )
        ],
      ),
      body: Column(
        children: [
          MembersListWidget(archive: widget.group.archive,),
          Expanded(
            child: ReceiptListWidget(members: widget.group.members, archive: widget.group.archive,)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  height: 35,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      // showDialog(context: context, builder: (BuildContext contex) {
                      //   return SummarizeWidget(group: widget.group);
                      // });
                      Navigator.pushNamed(
                        context,
                        "/summaryPage",
                        arguments: widget.group
                      );
                    },
                    child: const Text("Összegzés"),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
