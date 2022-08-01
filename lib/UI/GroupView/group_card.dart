import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhf/Cubit/archive_group_cubit.dart';
import 'package:flutterhf/Cubit/member_cubit.dart';
import 'package:flutterhf/UI/GroupView/group_card_buttons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import '../../Cubit/receipt_cubit.dart';
import '../../Cubit/group_cubit.dart';
import 'group.dart';

class GroupListItem extends StatefulWidget {
  const GroupListItem({Key? key, required this.group, required this.animation}) : super(key: key);
  final Group group;
  final Animation<double> animation;

  @override
  State<StatefulWidget> createState() => _GroupListItemState();
}

class _GroupListItemState extends State<GroupListItem> {
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget.animation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
              color: Colors.lightGreenAccent,
              shadowColor: Colors.black87,
              elevation: 10,
              margin: const EdgeInsets.symmetric(vertical: 15.0),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(25)
                  )
              ),
              child: SizedBox(
                  width: 300,
                  height: 200,
                  child: InkWell(
                    key: ObjectKey(widget.group),
                    onTap: () => {
                      Navigator.pushNamed(
                          context,
                          "/detailsPage",
                          arguments: widget.group
                      )
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(
                                widget.group.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                              child: Text(
                                "Csoport létszáma: ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                              child: BlocBuilder<MemberCubit, MemberCubitState>(
                                builder: (context, state) {
                                  if (state is MemberLoaded){
                                    return Text(
                                      widget.group.membersCount.toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 18
                                      ),
                                    );
                                  }

                                  return Text(
                                    widget.group.membersCount.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 18
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(),
                              child: Icon(
                                Icons.group,
                                color: Colors.black87,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                              child: Text(
                                "Összes kiadás: ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                              child: BlocBuilder<ReceiptCubit, ReceiptCubitState>(
                                builder: (context, state) {
                                  if (state is ReceiptLoaded) {
                                    return Text(
                                    widget.group.sumSpending.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic
                                    ),
                                  );
                                  }

                                  return Text(
                                    widget.group.sumSpending.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Icon(
                                Icons.monetization_on_outlined,
                                color: Colors.black87,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                       GroupCardButtons(group: widget.group)
                      ],
                    ),
                  )
              )
          ),
        ],
      ),
    );
  }
}




