import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterhf/Cubit/receipt_cubit.dart';
import 'package:flutterhf/Cubit/member_cubit.dart';
import 'package:flutterhf/UI/DetailsView/Member/avatar.dart';
import 'package:flutterhf/UI/DetailsView/Member/member.dart';
import 'package:flutterhf/UI/DetailsView/Member/member_list_item.dart';

import '../Receipe/add_new_receipt_dialog.dart';
import 'avatar_picker.dart';

class MembersListWidget extends StatefulWidget {
  const MembersListWidget({Key? key, required this.archive}) : super(key: key);

  final bool archive;

  @override
  State<MembersListWidget> createState() => _MembersListWidgetState();
}

class _MembersListWidgetState extends State<MembersListWidget> {

  final GlobalKey<AnimatedListState> memberListKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberCubit, MemberCubitState>(
      builder: (context, state) {
       return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: SizedBox(
                height: 100,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                      color: Color.fromARGB(120, 146, 247, 158)
                  ),
                  child: Builder(
                    builder: (context) {
                      if (state is MemberRemove) {
                        memberListKey.currentState?.removeItem(state.index, (context, animation) =>
                          MemberListItem(
                            member: state.removed,
                            archive: widget.archive,
                            members: state.members,
                            animation: animation,

                          ),
                        );
                        return _renderList(state.members);
                      }

                      if (state is MemberInsert) {
                        memberListKey.currentState?.insertItem(state.newIndex);
                        return _renderList(state.members);
                      }

                      if (state is MemberLoaded) {
                        return _renderList(state.members);

                      }

                      return Container(
                        alignment: Alignment.center,
                        child: const Text("Üres"),
                      );
                    }
                  ),
                ),
              ),
            )
          ],     );
      }
    );
  }

  Widget _renderList(List<Member> members) {
    if (members.isNotEmpty) {
      return AnimatedList(
          key: memberListKey,
          scrollDirection: Axis.horizontal,
          initialItemCount: members.length,
          itemBuilder: (context, index, animation) {
            return MemberListItem(
              member: members[index],
              archive: widget.archive,
              members: members,
              animation: animation,
            );
          }
      );
    }
    return Container(
      alignment: Alignment.center,
      child: const Text(
        "Még nem vettél fel csoporttagot!",
        style: TextStyle(
            fontSize: 20
        ),
      ),
    );
  }
}
