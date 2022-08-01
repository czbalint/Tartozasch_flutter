import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutterhf/Cubit/receipt_cubit.dart';
import 'package:flutterhf/UI/DetailsView/Member/avatar_picker.dart';
import 'package:flutterhf/UI/DetailsView/Member/color_picker.dart';

import '../../../Cubit/member_cubit.dart';

class AddMemberDialog extends StatefulWidget {
  const AddMemberDialog({Key? key}) : super(key: key);

  @override
  State<AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<AddMemberDialog> {
  final TextEditingController textController = TextEditingController();

  Color selectedColor = Colors.greenAccent;
  late String selectedAvatar;

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<MemberCubit>();
    return AlertDialog(
      scrollable: true,
      content: Stack(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          SizedBox(
            height: 345,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Új csoporttag felvétele",
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
                          maxLength: 10,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Új személy neve'
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
                MemberColorPicker(
                    onChange: (Color color) => {
                      setState(() => selectedColor = color)
                    },
                    selectedColor: selectedColor
                ),
                MemberAvatarPicker(
                  seed: 'KOCSMA',
                  onChange: (String svg) => {
                    setState(() => selectedAvatar = svg)
                  },
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
                              detailsCubit.addMember(textController.value.text, selectedAvatar, selectedColor);
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
