import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../shared/components/components.dart';
import 'cubit_test/cubit.dart';
import 'cubit_test/states.dart';



class Test_Cubit extends StatelessWidget {
  const Test_Cubit({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var titleControlar = TextEditingController();
    var clockControlar = TextEditingController();
    var dateControlar = TextEditingController();
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (BuildContext context) => TestCubit()..createDatabase(),
      child: BlocConsumer<TestCubit, StatesOfTest>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = TestCubit.get(context);
          return  Scaffold(
            key: scaffoldKey,
            appBar: AppBar(),
            body:  cubit.screens[cubit.currentIndex],

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isSBS) {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    cubit.changeBottum(sbs: false, icons: Icons.add);

                    cubit
                        .insertToDatabase(
                            title: titleControlar.text,
                            time: clockControlar.text,
                            date: dateControlar.text)
                        .then((value) => print(value))
                        .catchError((e) => e.toString());
                    titleControlar.text = "";
                    clockControlar.text = "";
                    dateControlar.text = "";
                  }
                }
                else
                  {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Container(
                              color: Colors.grey[100],
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  formfield(
                                      pre_icon: const Icon(Icons.title),
                                      label: "Task title",
                                      type: TextInputType.text,
                                      validat: (var valed) {
                                        if (valed!.isEmpty) {
                                          return " Enter Title";
                                        }
                                        },
                                      controller: titleControlar),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  formfield(
                                      onlyread: true,
                                      ontap: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          clockControlar.text =
                                              value!.format(context).toString();
                                        });
                                      },
                                      pre_icon:
                                          const Icon(Icons.watch_later_outlined),
                                      label: "Time Taped",
                                      type: TextInputType.text,
                                      validat: (var valed) {
                                        if (valed!.isEmpty) {
                                          return " Enter Time";
                                        }
                                      },
                                      controller: clockControlar),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  formfield(
                                      onlyread: true,
                                      ontap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                              DateTime.parse("2024-01-01"),
                                        ).then((value) {
                                          dateControlar.text =
                                              DateFormat.yMMMd().format(value!);
                                        });
                                      },
                                      pre_icon:
                                          const Icon(Icons.watch_later_outlined),
                                      label: "Time Taped",
                                      type: TextInputType.text,
                                      validat: (var valed) {
                                        if (valed!.isEmpty) {
                                          return " Enter Time";
                                        }
                                      },
                                      controller: dateControlar),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottum(sbs: false, icons: Icons.add);
                  });
                  cubit.changeBottum(sbs: true, icons: Icons.edit);
                }
              },
              child: Icon(cubit.icon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changeScreenBouttmNivBar(index);
              },
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.restart_alt_sharp,
                    ),
                    label: "Tasks"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.trip_origin,
                    ),
                    label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive,
                    ),
                    label: "Archived"),
              ],
            ),
          );
        },
      ),
    );
  }
}
