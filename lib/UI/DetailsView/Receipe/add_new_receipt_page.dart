import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhf/Cubit/new_receipt_cubit.dart';
import 'package:flutterhf/Cubit/receipt_cubit.dart';
import 'package:flutterhf/UI/DetailsView/Member/member.dart';
import 'package:flutterhf/UI/DetailsView/Receipe/Components/divide_radio_button.dart';
import 'package:flutterhf/UI/DetailsView/Receipe/Components/member_picker.dart';
import 'package:flutterhf/UI/DetailsView/Receipe/Components/selected_members.dart';
import 'package:flutterhf/UI/DetailsView/Receipe/Components/value_textfield.dart';



class AddNewReceipt extends StatefulWidget {
  const AddNewReceipt({Key? key, required this.members}) : super(key: key);

  final List<Member> members;

  @override
  State<AddNewReceipt> createState() => _AddNewReceiptState();
}

class _AddNewReceiptState extends State<AddNewReceipt> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final valueController = TextEditingController();

  Member? selectedMember;
  DivideType? divideType = DivideType.multi;

  @override
  Widget build(BuildContext context) {
    final _maxWidth = MediaQuery.of(context).size.width;
    final receiptCubit = context.read<ReceiptCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Új számla hozzáadása"),
        backgroundColor: const Color.fromARGB(255, 66, 138, 40),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 30),
                    child: Text(
                      "Számla megnevezése",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: _maxWidth - 40,
                      height: 70,
                      child: TextFormField(
                        maxLength: 15,
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))
                          ),
                          label: Text("Megnevezés"),
                          contentPadding: EdgeInsets.only(left: 20),
                          labelStyle: TextStyle(
                            fontSize: 15
                          )
                        ),
                        style: const TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                ],
              ),
             MemberPickerDropdown(
                 members: widget.members,
                 onChange: (member) {
                   setState(() {
                     selectedMember = member;
                   });
                 }
             ),
              DivideRadioButtons(
                onChange: (type) {
                  setState(() {
                    divideType = type;
                  });
                },
              ),
              ValueTextField(
                divideType: divideType,
                valueController: valueController,
                members: widget.members,
              ),
              Builder(
                  builder: (context) {
                    if (divideType == DivideType.single){
                      return SelectedMembers();
                    }
                    return Container();
                  }
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: SizedBox(
                  height: 30,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                     onPressed: () {
                      final newReceiptCubit = context.read<NewReceiptCubit>();
                      var receiptCount = int.parse(valueController.value.text);
                      //print(newReceiptCubit.members);
                      receiptCubit.addNewReceipt(
                        _nameController.value.text,
                        selectedMember!,
                        receiptCount,
                        divideType == DivideType.single ? newReceiptCubit.members : widget.members
                      );
                      Navigator.pop(context);
                    },
                    child: const Text("HOZZÁAD"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum DivideType { single, multi }
