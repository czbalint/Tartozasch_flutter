import 'package:flutter/material.dart';

import '../../Member/avatar.dart';
import '../../Member/member.dart';

class MemberPickerDropdown extends StatefulWidget {
  const MemberPickerDropdown({Key? key, required this.members, required this.onChange}) : super(key: key);

  final List<Member> members;
  final ValueChanged<Member?> onChange;

  @override
  State<MemberPickerDropdown> createState() => _MemberPickerDropdownState();
}

class _MemberPickerDropdownState extends State<MemberPickerDropdown> {

  Member? selectedMember;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 30, top: 10),
              child: Text(
                "Fizető személy",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: SizedBox(
                width: 220,
                height: 60,
                child: DropdownButtonFormField<Member>(
                  value: selectedMember,
                  elevation: 16,
                  focusColor: Colors.green,
                  hint: const Text("Személy kiválasztása"),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      )
                  ),
                  selectedItemBuilder: (context) {
                    return widget.members.map<Widget>((item) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(item.name),
                      );
                    }).toList();
                  },
                  menuMaxHeight: 250,
                  borderRadius: BorderRadius.circular(15),
                  items: widget.members.map<DropdownMenuItem<Member>>((member) =>
                      DropdownMenuItem(
                        alignment: AlignmentDirectional.topStart,
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
                  ).toList(),
                  onChanged: (Member? member){
                    setState(() {
                      selectedMember = member;
                    });
                    widget.onChange(selectedMember);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                  width: 45,
                  height: 45,
                  padding: const EdgeInsets.only(top: 4),
                  child: MemberAvatar(svgCode: selectedMember?.avatar ?? "", key: ObjectKey(selectedMember.hashCode))
              ),
            )
          ],
        ),
      ],
    );
  }
}
