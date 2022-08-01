import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhf/Cubit/new_receipt_cubit.dart';
import 'package:flutterhf/UI/DetailsView/Member/avatar.dart';
import 'package:flutterhf/UI/DetailsView/Member/member.dart';
import 'package:flutterhf/UI/DetailsView/Receipe/Components/overlapping_avatars.dart';
import 'package:flutterhf/UI/DetailsView/Receipe/add_new_receipt_page.dart';

class ValueTextField extends StatelessWidget {
  ValueTextField({Key? key, required this.divideType, required this.valueController, required this.members}) : super(key: key) {
    memberCopy = members.toList();
  }

  final TextEditingController valueController;
  final DivideType? divideType;
  final List<Member> members;
  late List<Member> memberCopy;

  @override
  Widget build(BuildContext context) {
    final newReceiptCubit = context.read<NewReceiptCubit>();
    return Column(
      children: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 30, top: 20),
              child: Text(
                "Fizetett összeg",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Row(
            children: [
              SizedBox(
                width: 220,
                height: 70,
                child: TextFormField(
                  maxLength: 7,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      label: const Text("Fizetett összeg"),
                      contentPadding: const EdgeInsets.only(left: 20),
                      labelStyle: const TextStyle(
                          fontSize: 15
                      )
                  ),
                  controller: valueController,
                  style: const TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
              Builder(
                  builder: (context) {
                    if (divideType == DivideType.single) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 45, bottom: 20),
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: PopupMenuButton<Member>(
                            itemBuilder: (context) => listItemGenerator(),
                            icon: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(Icons.add),
                            ),
                            constraints: const BoxConstraints(
                              maxHeight: 250
                            ),
                            splashRadius: 30,
                            onSelected: (member) {
                              newReceiptCubit.addMember(member);
                              memberCopy.remove(member);
                            },
                          )
                        )
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(left: 35, bottom: 20),
                        child: OverlappingAvatars(
                          members: members,
                        ),
                      );
                    }
                  }
              )
            ],
          ),
        ),
      ],
    );
  }

  List<PopupMenuEntry<Member>> listItemGenerator() {
    List<PopupMenuItem<Member>> menuList = List<PopupMenuItem<Member>>.empty(growable: true);
    for (var member in memberCopy) {
      menuList.add(
        PopupMenuItem(
          value: member,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: member.color,
                borderRadius: BorderRadius.circular(30)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, left: 10),
                      child: MemberAvatar(svgCode: member.avatar!,),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: 120,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 35, top: 15),
                      child: Text(member.name),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      );
    }
    return menuList;
  }

}
