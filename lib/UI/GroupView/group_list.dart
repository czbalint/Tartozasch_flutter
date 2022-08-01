import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhf/UI/GroupView/archive_group_list.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

import '../../Cubit/group_cubit.dart';
import 'active_group_list.dart';

class GroupList extends StatefulWidget {
    const GroupList({Key? key}) : super(key: key);

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> with TickerProviderStateMixin {

  late TabController tabController;
  final TextEditingController textController = TextEditingController();

  @override
  void dispose(){
    textController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }
  _GroupListState();

  @override
  Widget build(BuildContext context) {
    var groupCubit = context.read<GroupCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Csoportok"),
        backgroundColor: const Color.fromARGB(255, 66, 138, 40),

        bottom: TabBar(
          controller: tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Elusive.group),
            ),
            Tab(
              icon: Icon(FontAwesome5.history),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const <Widget>[
            ActiveGroupList(),
            ArchiveGroupList(),
        ],
      ),
    );
  }

  
}

