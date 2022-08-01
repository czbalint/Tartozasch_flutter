import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class MemberColorPicker extends StatelessWidget {
  const MemberColorPicker({Key? key, required this.onChange, required this.selectedColor}) : super(key: key);

  final ValueChanged<Color> onChange;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          const Text(
              "Szín kiválasztása: "
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selectedColor,
            ),
            margin: const EdgeInsets.only(left: 20),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => {
                  showDialog(context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Válassz színt"),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                          pickerColor: Colors.greenAccent,
                          onColorChanged: (Color color) => {
                            onChange(color)
                          },
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                            onPressed: () => {
                              Navigator.of(context).pop()
                            },
                            child: const Text("Vissza")
                        )
                      ],
                    );
                  })
                },
                borderRadius: BorderRadius.circular(20),
                child: const SizedBox(
                  height: 45,
                  width: 45,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
