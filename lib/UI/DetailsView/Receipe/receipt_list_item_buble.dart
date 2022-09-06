import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterhf/UI/DetailsView/Receipe/receipe.dart';

class ReceiptItemBubble extends StatefulWidget {
  const ReceiptItemBubble({Key? key, required this.receipt, required this.archive, required this.animation}) : super(key: key);

  final Receipt receipt;
  final bool archive;
  final Animation<double> animation;

  @override
  State<ReceiptItemBubble> createState() => _ReceiptItemBubbleState();
}

class _ReceiptItemBubbleState extends State<ReceiptItemBubble> {
  var _itemHeight = 80.0;
  var isOpen = false;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: widget.animation,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          alignment: Alignment.center,
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(),
            ),

            AnimatedContainer(
              width: 300,
              height: _itemHeight,
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54, width: 3),
                borderRadius: BorderRadius.circular(30),
               // color: Colors.white54
              ),
              duration: const Duration(milliseconds: 200),
              onEnd: () {
                setState(() {
                  isOpen = !isOpen;
                });
              },
              child: Material(
                color: Colors.transparent,

                child: InkWell(
                  borderRadius: BorderRadius.circular(27),
                  onTap: () {
                    if (!isOpen) {
                      setState(() {
                        _itemHeight = 200.0;

                      });
                    } else {
                      setState(() {
                        _itemHeight = 80.0;

                      });
                    }
                  },
                  splashColor: Theme.of(context).splashColor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                    child: Text(
                                      widget.receipt.name,
                                      style: Theme.of(context).textTheme.headlineLarge
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      "Megnevezés",
                                      style: Theme.of(context).textTheme.labelMedium
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                    child: Text(
                                      widget.receipt.count.toString() + " Ft",
                                      style: Theme.of(context).textTheme.headlineLarge
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      "Összeg",
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                        Builder(
                          builder: (context) {
                            if (isOpen) {
                              return Column(
                                children: [
                                  const Divider(
                                    color: Colors.black,
                                  ),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 3),
                                              child: Text(
                                                widget.receipt.member.name,
                                                style: Theme.of(context).textTheme.headlineMedium,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 2),
                                              child: Text(
                                                "Fizette",
                                                style: Theme.of(context).textTheme.labelMedium,
                                              ),
                                            )
                                          ],
                                        )
                                      ),

                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Divider(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Divider(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Text("Fizető személyek"),
                                          color: Theme.of(context).backgroundColor
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              );
                            }
                            return Container();
                          }
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
