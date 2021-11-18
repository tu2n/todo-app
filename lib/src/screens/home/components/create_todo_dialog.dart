// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../input_validator.dart';
//
// class CreateTodoDialog extends StatelessWidget {
//   final TextEditingController controller;
//   final Function save;
//   final Function cancel;
//
//   const CreateTodoDialog({Key key,
//     @required this.controller,
//     @required this.save,
//     @required this.cancel
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoAlertDialog(
//       title: const Text("Create new todo"),
//       content: CupertinoTextFormFieldRow(
//         validator: (value) => InputValidator.validate(value),
//         controller: controller,
//         padding: const EdgeInsets.all(10),
//         placeholder: "Todo title",
//         style: const TextStyle(color: Colors.black54),
//         decoration: BoxDecoration(
//           color: CupertinoColors.extraLightBackgroundGray,
//           border: Border.all(
//               color: CupertinoColors.lightBackgroundGray,
//               width: 2
//           ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       actions: [
//         CupertinoDialogAction(
//           child: const Text("Cancel"),
//           onPressed: cancel
//         ),
//         CupertinoDialogAction(
//           child: const Text("Save"),
//           onPressed: save
//         )
//       ],
//     );
//   }
// }
