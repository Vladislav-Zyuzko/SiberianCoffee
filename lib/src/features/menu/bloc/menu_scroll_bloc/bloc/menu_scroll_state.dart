part of 'menu_scroll_bloc.dart';

@immutable
sealed class MenuScrollState {
  final ScrollController contentScrollController;
  final ScrollController appBarScrollController;

  const MenuScrollState({required this.contentScrollController, required this.appBarScrollController});
}

final class MenuScrollInitialState extends MenuScrollState {
  MenuScrollInitialState() : super(contentScrollController: ScrollController(), appBarScrollController: ScrollController());
}

final class MenuScrollBaseState extends MenuScrollState {
  const MenuScrollBaseState({required super.contentScrollController, required super.appBarScrollController});
}
