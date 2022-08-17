import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Cubit/group_cubit.dart';
import 'add_group_dialog.dart';
import 'group.dart';
import 'group_card.dart';

class ActiveGroupList extends StatefulWidget {
  const ActiveGroupList({Key? key}) : super(key: key);

  @override
  State<ActiveGroupList> createState() => _ActiveGroupListState();
}

class _ActiveGroupListState extends State<ActiveGroupList> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GroupCubit, GroupState>(
          builder: (context, state) {
            if (state is GroupInsertState) {
              listKey.currentState?.insertItem(state.newItemIndex);
              List<Group> groups = state.groups;
              int count = groups.length;
              return AnimatedList(
                key: listKey,
                initialItemCount: count,
                itemBuilder: (context, index, animation){
                  return GroupListItem(
                    key: ObjectKey(groups[index]),
                    group: groups[index],
                    animation: animation,
                  );
                },
              );
            }
            
            if (state is GroupRemoveState){
              List<Group> groups = state.groups;
              int count = groups.length;
              AnimatedListRemovedItemBuilder builder = (context, animation) {
                return GroupListItem(group: state.removedGroup, animation: animation);
              };
              listKey.currentState?.removeItem(state.removedIndex, builder);

              return AnimatedList(
                key: listKey,
                initialItemCount: count,
                itemBuilder: (context, index, animation){
                   return GroupListItem(
                     key: ObjectKey(groups[index]),
                     group: groups[index],
                     animation: animation,
                   );
                },
              );
            }

            if (state is GroupLoadedState) {
              List<Group> groups = state.groups;
              int count = groups.length;
              return AnimatedList(
                key: listKey,
                initialItemCount: count,
                itemBuilder: (context, index, animation) {
                  return GroupListItem(
                    key: ObjectKey(groups[index]),
                    group: groups[index],
                    animation: animation,
                  );
                },
              );
            }

            if (state is GroupLoadState) {
              return Container();
            }

            return Container();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return const AddGroupDialog();
          });
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
