part of 'base_bloc.dart';

class BaseEvent extends Equatable {
  const BaseEvent();

  @override
  List<Object?> get props => [];
}

class GetBaseScreenDataEvent extends BaseEvent {
  const GetBaseScreenDataEvent();
}

class LoadMoreDataEvent extends BaseEvent {
  const LoadMoreDataEvent();
}

class GetCategoryDataEvent extends BaseEvent {
  const GetCategoryDataEvent({
    required this.categoryId,
  });

  final int categoryId;
}

class OnTapChangeTabEvent extends BaseEvent {
  const OnTapChangeTabEvent({
    required this.index,
  });

  final int index;
}

class ToggleTabEvent extends BaseEvent {
  const ToggleTabEvent();
}
