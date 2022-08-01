import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhf/Cubit/archive_group_cubit.dart';
import 'package:flutterhf/Cubit/group_cubit.dart';
import 'package:flutterhf/UI/GroupView/group.dart';
import 'package:flutterhf/UI/GroupView/group_card.dart';

class ArchiveGroupList extends StatefulWidget {
  const ArchiveGroupList({Key? key}) : super(key: key);

  @override
  State<ArchiveGroupList> createState() => _ArchiveGroupListState();
}

class _ArchiveGroupListState extends State<ArchiveGroupList> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ArchiveCubit, ArchiveGroupState>(
        builder: (context, state) {
            if (state is LoadedArchiveState) {
              List<Group> groups = state.groups;
              int count = groups.length;
              return AnimatedList(
                key: listKey,
                initialItemCount: count,
                itemBuilder: (context, index, animation) {
                  return GroupListItem(
                      key: ObjectKey(groups[index]),
                      group: groups[index],
                      animation: animation
                  );
                },
              );
            }
            return Container();
        },
      )
    );
  }
}
