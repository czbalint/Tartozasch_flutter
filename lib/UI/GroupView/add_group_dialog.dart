import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../Cubit/group_cubit.dart';

class AddGroupDialog extends StatefulWidget {

  const AddGroupDialog({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddGroupStateDialog();
}

class _AddGroupStateDialog extends State<AddGroupDialog> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var groupCubit = context.read<GroupCubit>();
    return AlertDialog(
      content: Stack(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          SizedBox(
            height: 200,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Új csoport felvétele",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 80,
                        child: TextField(
                          maxLength: 20,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Új csoport neve'
                          ),
                          controller: textController,
                          style: const TextStyle(
                              fontSize: 18
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("MÉGSE"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              groupCubit.addGroup(textController.value.text);
                              textController.clear();
                              Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}