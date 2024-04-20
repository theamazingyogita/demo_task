import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yogita_agarwal_task_impero_it/bloc/base_bloc.dart';
import 'package:yogita_agarwal_task_impero_it/custom_app_bar.dart';

import 'catrgory_screen.dart';

class BaseView extends StatefulWidget {
  const BaseView({super.key});

  @override
  State<BaseView> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseView> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final baseBloc = context.read<BaseBloc>();
    return BlocConsumer<BaseBloc, BaseState>(
      listener: (context, state) {
        if (state.isTabChanged) {
          baseBloc.add(const ToggleTabEvent());
        }
      },
      buildWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.isTabChanged != current.isTabChanged ||
          previous.currentIndex != current.currentIndex ||
          previous.category != current.category,
      builder: (context, state) {
        _tabController =
            TabController(length: state.category.length, vsync: this);
        return MaterialApp(
          home: DefaultTabController(
            initialIndex: state.currentIndex,
            length: state.category.length,
            child: Stack(
              children: [
                Scaffold(
                  backgroundColor: Colors.black,
                  appBar: CustomAppBar(
                    backgroundColor: Colors.black,
                    bottom: state.category.isNotEmpty
                        ? TabBar(
                            isScrollable: true,
                            physics: const ClampingScrollPhysics(),
                            indicatorSize: TabBarIndicatorSize.label,
                            dividerColor: Colors.transparent,
                            indicatorColor: Colors.transparent,
                            controller: _tabController,
                            tabAlignment: TabAlignment.start,
                            key: const ValueKey('tab_bar'),
                            onTap: (index) {
                              baseBloc.add(OnTapChangeTabEvent(index: index));
                            },
                            tabs: state.category
                                .map((category) => Tab(
                                        child: Text(
                                      category.name.toString(),
                                      style: TextStyle(
                                        color: state.currentIndex ==
                                                state.category.indexOf(category)
                                            ? Colors.white
                                            : Colors.grey,
                                        fontSize: 16,
                                      ),
                                    )))
                                .toList(),
                          )
                        : null,
                  ),
                  body: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12))),
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      key: const ValueKey('tab_bar_key'),
                      controller: _tabController,
                      children: state.category
                          .map((category) => const CategoryScreen())
                          .toList(), // Pass the category data to CategoryScreen
                    ),
                  ),
                ),
                state.isLoading
                    ? Container(
                        color: Colors.black.withOpacity(0.6),
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }
}
