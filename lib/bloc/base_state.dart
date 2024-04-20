part of 'base_bloc.dart';

class BaseState extends Equatable {
  const BaseState({
    this.baseModel,
    this.isLoading = false,
    this.category = const [],
    this.subCategories = const [],
    this.currentCategoryId = 0,
    this.currentIndex = 0,
    this.tabController,
    this.isTabChanged = false,
  });

  final BaseModel? baseModel;
  final bool isLoading;
  final List<Category> category;
  final List<SubCategories> subCategories;
  final int currentCategoryId;

  final int currentIndex;
  final TabController? tabController;
  final bool isTabChanged;

  BaseState copyWith({
    BaseModel? baseModel,
    bool? isLoading,
    List<Category>? category,
    List<SubCategories>? subCategories,
    int? currentCategoryId,
    int? currentIndex,
    TabController? tabController,
    bool? isTabChanged,
  }) {
    return BaseState(
      baseModel: baseModel ?? this.baseModel,
      isLoading: isLoading ?? this.isLoading,
      category: category ?? this.category,
      subCategories: subCategories ?? this.subCategories,
      currentCategoryId: currentCategoryId ?? this.currentCategoryId,
      currentIndex: currentIndex ?? this.currentIndex,
      tabController: tabController ?? this.tabController,
      isTabChanged: isTabChanged ?? isTabChanged ?? this.isTabChanged,
    );
  }

  @override
  List<Object?> get props => [
        baseModel,
        isLoading,
        category,
        subCategories,
        currentCategoryId,
        currentIndex,
        tabController,
        isTabChanged,
      ];
}
