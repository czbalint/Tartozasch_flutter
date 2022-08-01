import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhf/Cubit/new_receipt_cubit.dart';
import '../add_new_receipt_page.dart';

class DivideRadioButtons extends StatefulWidget {
  const DivideRadioButtons({Key? key, required this.onChange}) : super(key: key);

  final ValueChanged<DivideType?> onChange;

  @override
  State<DivideRadioButtons> createState() => _DivideRadioButtonsState();
}

class _DivideRadioButtonsState extends State<DivideRadioButtons> {
  DivideType? divideType = DivideType.multi;

  @override
  Widget build(BuildContext context) {
    final newReceiptCubit = context.read<NewReceiptCubit>();
    return Column(
      children: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 30, top: 30),
              child: Text(
                "Elosztás típusa",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: SizedBox(
                height: 120,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RadioListTile<DivideType>(
                      title: const Text("Szétosztás mindenki között"),
                      value: DivideType.multi,
                      groupValue: divideType,
                      onChanged: (DivideType? type) {
                        setState(() {
                          divideType = type;
                        });
                        widget.onChange(divideType);
                        newReceiptCubit.reloadList();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      selectedTileColor: Colors.lightGreen.shade300,
                      selected: divideType == DivideType.multi ? true : false,
                      activeColor: Colors.black,

                    ),
                    RadioListTile<DivideType>(
                      title: const Text("Szétosztás adott emberek között"),
                      value: DivideType.single,
                      groupValue: divideType,
                      onChanged: (DivideType? type) {
                        setState(() {
                          divideType = type;
                        });
                        widget.onChange(divideType);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      selectedTileColor: Colors.lightGreen.shade300,
                      selected: divideType == DivideType.single ? true : false,
                      activeColor: Colors.black,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
