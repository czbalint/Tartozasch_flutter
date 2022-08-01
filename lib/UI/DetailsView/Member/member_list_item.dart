import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhf/Cubit/member_cubit.dart';
import 'package:flutterhf/UI/DetailsView/Member/member.dart';

import '../Receipe/add_new_receipt_dialog.dart';
import 'avatar.dart';

class MemberListItem extends StatelessWidget {
  final Member member;
  final bool archive;
  final List<Member> members;
  final Animation<double> animation;

  const MemberListItem({Key? key, required this.member, required this.archive, required this.members, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var detailsCubit = context.read<MemberCubit>();
    return ScaleTransition(
      key: Key(member.hashCode.toString()),
      scale: animation,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: member.color ?? Colors.greenAccent,
          child: InkWell(
            onLongPress: () {
              if (!archive) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Biztos szeretnéd törölni a ${member.name} nevű csoporttagot?"),
                      action: SnackBarAction(
                          label: "OK",
                          onPressed: () => detailsCubit.removeMember(member)),
                    )
                );
              }
            },
            onTap: () {
              showDialog(context: context, builder: (BuildContext context) {
                return AddNewReceiptDialog.fromMemberList(members: members, initMember: member,);
              });
            },
            splashColor: Colors.red,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Row(
                    children: [ if (member.avatar == null) const Icon(
                      Icons.account_circle_outlined,
                      size: 50,
                    ) else Padding(
                      padding: const EdgeInsets.only(top: 5, left: 2),
                      child: MemberAvatar(svgCode: member.avatar!),
                    )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                      child: Text(
                        member.name,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
