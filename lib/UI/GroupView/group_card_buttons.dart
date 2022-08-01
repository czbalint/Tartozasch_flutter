import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import '../../Cubit/archive_group_cubit.dart';
import '../../Cubit/group_cubit.dart';
import 'group.dart';

class GroupCardButtons extends StatefulWidget {
  final Group group;
  const GroupCardButtons({Key? key, required this.group}) : super(key: key);

  @override
  State<GroupCardButtons> createState() => _GroupCardButtonsState();
}

class _GroupCardButtonsState extends State<GroupCardButtons> {
  @override
  Widget build(BuildContext context) {
    var groupCubit = context.read<GroupCubit>();
    var archiveCubit = context.read<ArchiveCubit>();
    if (!widget.group.archive) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: IconButton(
              icon: const Icon(FontAwesome5.archive),
              color: Colors.black87,
              onPressed: () async {
                await groupCubit.archiveGroup(widget.group);
                await archiveCubit.emitAllArchiveGroup();
              },
              iconSize: 30,
              tooltip: "Csoport archiválás",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: IconButton(
              icon: const Icon(FontAwesome5.trash_alt),
              color: Colors.black87,
              onPressed: () {
                groupCubit.removeGroup(widget.group);
              },
              iconSize: 30,
              tooltip: "Csoport törlése",
            ),
          )
        ],
      );
    }
    return Row();
  }
}


