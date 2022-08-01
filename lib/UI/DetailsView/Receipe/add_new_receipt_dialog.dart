import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterhf/Cubit/receipt_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Member/member.dart';

class AddNewReceiptDialog extends StatefulWidget {
  const AddNewReceiptDialog({Key? key, required this.members}) : initMember = null, super(key: key);

  final List<Member> members;

  const AddNewReceiptDialog.fromMemberList({Key? key, required this.members, required this.initMember}) : super(key: key);

  final Member? initMember;

  @override
  State<AddNewReceiptDialog> createState() => _AddNewReceiptDialogState();
}

class _AddNewReceiptDialogState extends State<AddNewReceiptDialog> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  Member? selectedValue;

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<ReceiptCubit>();
    selectedValue ??= widget.initMember;
    return AlertDialog(
      scrollable: true,
      content: Stack(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          SizedBox(
            height: 410,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Új fogyasztás hozzáadása",
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
                          maxLength: 15,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Megnevezés'
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
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 80,
                        child: TextField(
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Fizetett összeg'
                          ),
                          controller: numberController,
                          style: const TextStyle(
                              fontSize: 18
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 195,
                        height: 50,
                        child: DropdownButton<Member>(
                          value: selectedValue,
                          underline: Container(
                            height: 2,
                            color: Colors.green,
                          ),
                          elevation: 16,
                          focusColor: Colors.green,
                          hint: const Text("Személy kiválasztása"),
                          items: widget.members.map<DropdownMenuItem<Member>>((member) =>
                            DropdownMenuItem(
                              value: member,
                              child: Text(member.name),
                            )
                          ).toList(),
                          onChanged: (Member? newValue){
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("MÉGSE"),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedValue != null) {
                              // detailsCubit.addNewReceipt(
                              //     textController.value.text,
                              //     selectedValue!,
                              //     int.parse(numberController.value.text));
                              textController.clear();
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text("Válassz személyt!"),
                                  action: SnackBarAction(
                                    label: 'OK',
                                    onPressed: () {},
                                  ),
                                )
                              );
                            }
                          },
                          child: const Text("HOZZÁAD"),
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
