import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:yogita_agarwal_task_impero_it/base_model.dart';

part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc() : super(const BaseState()) {
    on<BaseEvent>(_mapEventToState);
  }

  int _pageNumber = 1;

  void _mapEventToState(BaseEvent event, Emitter<BaseState> emit) {
    if (event is GetBaseScreenDataEvent) {
      return _mapGetBaseScreenDataEventToState(event, emit);
    } else if (event is LoadMoreDataEvent) {
      return _mapLoadMoreDataEventToState(event, emit);
    } else if (event is GetCategoryDataEvent) {
      return _mapGetCategoryDataEventToState(event, emit);
    } else if (event is OnTapChangeTabEvent) {
      return _mapOnTapChangeTabEventToState(event, emit);
    } else if (event is ToggleTabEvent) {
      return _mapToggleTabEventToState(event, emit);
    }
  }

  void _mapGetBaseScreenDataEventToState(
      GetBaseScreenDataEvent event, Emitter<BaseState> emit) async {
    emit(state.copyWith(isLoading: true));
    const url = 'http://esptiles.imperoserver.in/api/API/Product/DashBoard';
    final Map<String, dynamic> requestBody = {
      "CategoryId": 0,
      "DeviceManufacturer": "Google",
      "DeviceModel": "Android SDK built for x86",
      "DeviceToken": " ",
      "PageIndex": 1
    };

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      emit(state.copyWith(isLoading: false));
      BaseModel baseModel = BaseModel.fromJson(jsonDecode(response.body));
      emit(state.copyWith(
          baseModel: baseModel, category: baseModel.result?.category));
      add(GetCategoryDataEvent(categoryId: state.category[0].id ?? 0));
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _mapLoadMoreDataEventToState(
      LoadMoreDataEvent event, Emitter<BaseState> emit) {
    _pageNumber = _pageNumber + 1;
    add(GetCategoryDataEvent(categoryId: state.currentCategoryId));
  }

  void _mapGetCategoryDataEventToState(
      GetCategoryDataEvent event, Emitter<BaseState> emit) async {
    emit(state.copyWith(isLoading: true));
    const url = 'http://esptiles.imperoserver.in/api/API/Product/DashBoard';
    final Map<String, dynamic> requestBody = {
      "CategoryId": event.categoryId,
      "PageIndex": _pageNumber,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      emit(state.copyWith(isLoading: false));
      BaseModel baseModel = BaseModel.fromJson(jsonDecode(response.body));
      final List<SubCategories> subCategoryList = state.subCategories.toList();
      final List<Category> categoryList = state.category.toList();

      final list = baseModel.result!.category?[0].subCategories;
      if (list != null) {
        if (list.isNotEmpty) {
          subCategoryList.addAll(list);
        }
        categoryList.where((element) {
          if (element.id == event.categoryId) {
            element.subCategories = subCategoryList;
          }
          return true;
        });

        emit(state.copyWith(
          subCategories: subCategoryList,
          category: categoryList,
        ));
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _mapOnTapChangeTabEventToState(
      OnTapChangeTabEvent event, Emitter<BaseState> emit) {
    _pageNumber = 1;
    add(GetCategoryDataEvent(categoryId: state.category[event.index].id ?? 0));
    emit(state.copyWith(
        currentIndex: event.index,
        currentCategoryId: state.category[event.index].id,
        subCategories: []));

    add(const ToggleTabEvent());
  }

  void _mapToggleTabEventToState(
      ToggleTabEvent event, Emitter<BaseState> emit) {
    emit(state.copyWith(isTabChanged: !state.isTabChanged));
  }
}
