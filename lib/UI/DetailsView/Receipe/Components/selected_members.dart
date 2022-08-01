import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhf/Cubit/new_receipt_cubit.dart';
import 'package:flutterhf/Database/Groups/floor_group_database.dart';

import '../../Member/avatar.dart';
import '../../Member/member.dart';

class SelectedMembers extends StatelessWidget {
  SelectedMembers({Key? key}) : super(key: key);

  final GlobalKey<AnimatedListState> selectedMemberListKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(120, 146, 247, 158),
        borderRadius: BorderRadius.circular(15)
      ),
      height: 100,
      width: MediaQuery.of(context).size.width * 0.9,
      child: BlocBuilder<NewReceiptCubit, NewReceiptCubitState>(
          builder: (context, state) {
            if (state is NewReceiptInit){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Még nem adtál hozzá csoporttagot",
                    style: TextStyle(
                      fontSize: 17
                    ),
                  )
                ],
              );
            }

            if (state is NewReceiptAddMember){
              selectedMemberListKey.currentState?.insertItem(state.newIndex);
              List<Member> members = state.members;
              return _renderList(members);
            }

            return Container();
          }
      ),
    );
  }

  Widget _renderList(List<Member> members) {
    return AnimatedList(
      key: selectedMemberListKey,
      scrollDirection: Axis.horizontal,
      initialItemCount: members.length,
      itemBuilder: (context, index, animation) {
        return SelectedMemberListItem(
          member: members[index],
          animation: animation
        );
      },
    );
  }
}


class SelectedMemberListItem extends StatelessWidget {
  const SelectedMemberListItem({Key? key, required this.member, required this.animation}) : super(key: key);

  final Member member;
  final Animation<double> animation;
  
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      key: Key(member.hashCode.toString()),
      scale: animation,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: member.color ?? Colors.greenAccent,
          child: InkWell(
            onLongPress: () { },
            onTap: () { },
            splashColor: Colors.red,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  width: 55,
                  child: Row(
                    children: [ if (member.avatar == null) const Icon(
                      Icons.account_circle_outlined,
                      size: 50,
                    ) else Padding(
                      padding: const EdgeInsets.only(top: 5, left: 5),
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

