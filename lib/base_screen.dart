import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yogita_agarwal_task_impero_it/base_view.dart';
import 'package:yogita_agarwal_task_impero_it/bloc/base_bloc.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  late BaseBloc _baseBloc;

  @override
  void initState() {
    _baseBloc = BaseBloc()..add(const GetBaseScreenDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BaseBloc>(
      create: (context) => _baseBloc,
      child: const BaseView(),
    );
  }
}
