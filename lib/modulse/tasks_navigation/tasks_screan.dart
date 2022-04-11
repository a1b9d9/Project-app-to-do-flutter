import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../layout/test_navigation_cubit/cubit_test/cubit.dart';
import '../../layout/test_navigation_cubit/cubit_test/states.dart';
import '../../shared/components/components.dart';

class Task extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestCubit,StatesOfTest>(
      listener: (context, state) {},
      builder: (context, state) {
        var listData=TestCubit.get(context).newListData;
        return ListView.separated(
            itemBuilder: (context, index) => buildInfo(listData[index],context),
            separatorBuilder: (context, index) => Container(
                  color: Colors.grey[500],
                  width: double.infinity,
                  height: 1,
                ),
            itemCount: listData.length);
      },
    );
  }
}
