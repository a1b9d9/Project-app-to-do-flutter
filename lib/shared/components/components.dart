import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../layout/test_navigation_cubit/cubit_test/cubit.dart';


Widget formfield({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required FormFieldValidator<String>? validat,
  ValueChanged<String>? onchange,
  ValueChanged<String>? onFieldSubmitted,
  GestureTapCallback? ontap,
  Widget? pre_icon,
  Widget? suf_icon,
  TextStyle? labelStyle,
  InputBorder? focusedBorder,
  InputBorder? enabledBorder,
  bool obscure = false,
  bool onlyread = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onChanged: onchange,
      onFieldSubmitted: onFieldSubmitted,
      onTap: ontap,
      readOnly: onlyread,
      obscureText: obscure,
      validator: validat,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: pre_icon,
        suffixIcon: suf_icon,
        labelStyle: labelStyle,
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );

Widget buildInfo(listData, context) {
  return Dismissible(
    key: Key(listData["id"].toString()),
    onDismissed: (d) {
      TestCubit.get(context).deleteData(listData["id"]);
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
            radius: 25,
            child: Text("${listData["time"]}"),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${listData["title"]}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${listData["date"]}",
                  style: TextStyle(fontSize: 15, color: Colors.grey[400]),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                TestCubit.get(context).updateData("Done", listData["id"]);
              },
              icon: const Icon(
                Icons.trip_origin,
                color: Colors.green,
              )),
          const SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                TestCubit.get(context).updateData("Archived", listData["id"]);
              },
              icon: const Icon(
                Icons.archive,
                color: Colors.grey,
              )),
        ],
      ),
    ),
  );
}

Widget title({String? data}) {
  return Center(
      child: Text(
        "$data",
        style: const TextStyle(fontSize: 30, color: Colors.blue),
      ));
}


//news Screenss


Widget padContainer() =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 1,
        color: Colors.grey[100],
      ),
    );




navigator(context, widget) {
  Navigator.push(
      context, MaterialPageRoute(
    builder: (context) => widget,
  ));
}
