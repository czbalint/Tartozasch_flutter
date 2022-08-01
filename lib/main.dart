import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterhf/Cubit/archive_group_cubit.dart';
import 'package:flutterhf/Cubit/member_cubit.dart';
import 'package:flutterhf/Cubit/new_receipt_cubit.dart';
import 'package:flutterhf/Cubit/receipt_cubit.dart';
import 'package:flutterhf/Cubit/group_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhf/Database/Groups/data_source.dart';
import 'package:flutterhf/Database/Groups/floor_group_repository.dart';
import 'package:flutterhf/UI/DetailsView/Member/member.dart';
import 'package:flutterhf/UI/DetailsView/Receipe/add_new_receipt_page.dart';
import 'package:flutterhf/UI/DetailsView/Summary/summary_page.dart';
import 'package:flutterhf/UI/DetailsView/group_details.dart';
import 'package:flutterhf/UI/GroupView/group.dart';
import 'package:provider/provider.dart';
import 'UI/GroupView/group_list.dart';
import 'UI/GroupView/group.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dataSource = DataSource(FloorGroupRepository());

  await dataSource.init();

  runApp(
      Provider<DataSource>(
        create: (_) => dataSource,
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider<GroupCubit>(
          create: (BuildContext context) => GroupCubit(context.read<DataSource>())
        ),
        BlocProvider<ArchiveCubit>(
            create: (BuildContext context) => ArchiveCubit(context.read<DataSource>())
        ),
        BlocProvider<ReceiptCubit>(
            create: (BuildContext context) => ReceiptCubit(context.read<DataSource>())
        ),
        BlocProvider<MemberCubit>(
            create: (BuildContext context) => MemberCubit(context.read<DataSource>())
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 66, 138, 40),
          primarySwatch: Colors.green,
        ),
        home: const GroupList(),
        onGenerateRoute: (route) {
            switch (route.name){
              case "/detailsPage":
                return MaterialPageRoute(
                  settings: const RouteSettings(name: "/detailsPage"),
                  builder: (context) => GroupDetails(
                    group: route.arguments as Group,
                  )
                );
              case "/receiptAddPage":
                return MaterialPageRoute(
                    settings: const RouteSettings(name: "/receiptAddPage"),
                    builder: (context) => BlocProvider(
                      create: (BuildContext context) => NewReceiptCubit(),
                      child: AddNewReceipt(
                        members: route.arguments as List<Member>,
                      ),
                    )
                );
              case "/summaryPage":
                return MaterialPageRoute(
                  settings: const RouteSettings(name: "/summaryPage"),
                  builder: (context) => SummaryPage(
                    group: route.arguments as Group,
                  )
                );
            }
            return null;
        },
      ),
    );
  }
}


