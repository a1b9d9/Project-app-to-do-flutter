 import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/layout/test_navigation_cubit/cubit_test/states.dart';

import '../../../modulse/archived_navigation/archived_screan.dart';
import '../../../modulse/done_navigation/done_screan.dart';
import '../../../modulse/tasks_navigation/tasks_screan.dart';


class TestCubit extends Cubit<StatesOfTest> {
  TestCubit() : super(TestInitialState());

  static TestCubit get(context) => BlocProvider.of(context);

  late Database db;
  int currentIndex = 0;
  List<Map> newListData = [];
  List<Map> donListData = [];
  List<Map> archivedListData = [];

  List<Widget> screens = [
    Task(),
    Done(),
    const Archived(),
  ];

  void changeScreenBouttmNivBar(int index) {
    currentIndex = index;
    emit(TestChangeNivBarState());
  }

  void createDatabase() {
    openDatabase("first_test.db", version: 1, onCreate: (data, version) {
      data
          .execute(
              'CREATE TABLE Test (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,state TEXT)')
          .then((value) => "created")
          .catchError((e) {
        print("error");
      });
    }, onOpen: (data) {
      getData(data);
    }).then((value) {
      db = value;
      emit(TestCreateDataState());
    });
  }

  Future insertToDatabase({
    @required String? title,
    @required String? date,
    @required String? time,
  }) async {
    db.transaction((txn) => txn
            .rawInsert(
                "INSERT INTO Test(title, date, time,state) VALUES('$title','$date','$time','new')")
            .then((value) {
          print("success");
        }).catchError((e) {
          print("error");
        }));
    emit(TestInsertDataState());

    getData(db);
  }

  void getData(db) {
    newListData = [];
    donListData = [];
    archivedListData = [];
    db.rawQuery('SELECT * FROM Test').then((value) {
      value.forEach((element) {
        if (element["state"] == "new") {
          newListData.add(element);
        } else if (element["state"] == "Done") {
          donListData.add(element);
        } else {
          archivedListData.add(element);
        }
      });

      emit(TestGetDataState());
    }).catchError((e) {
      print(e.toString());
    });
  }

  bool isSBS = false;
  var icon = Icons.add;

  void changeBottum({required bool sbs, required IconData icons}) {
    isSBS = sbs;
    icon = icons;
    emit(TestchangeFlotingButton());
  }

  void updateData(state, id) {
    db
        .rawUpdate('UPDATE Test SET state = ? WHERE id = ?', ['$state', id])
        .then((value) => value)
        .catchError((e) {
          print(e);
        });
    emit(TestUpdateDataState());
    getData(db);
  }
  void deleteData(id) {

    db
        .rawDelete('DELETE FROM Test WHERE id = ?', [id])
        .then((value) => value)
        .catchError((e) {
          print(e);
        });
    emit(TestUpdateDataState());
    getData(db);
  }
}
