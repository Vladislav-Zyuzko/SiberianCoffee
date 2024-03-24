part of 'menu_scroll_bloc.dart';

@immutable
sealed class MenuScrollEvent {}

class MenuScrollAddContentListenerEvent extends MenuScrollEvent {}

class MenuScrollAppBarToBeginingEvent extends MenuScrollEvent {}

class MenuScrollShowActiveCategoryEvent extends MenuScrollEvent {
  final GlobalKey categoryKey;

  MenuScrollShowActiveCategoryEvent({required this.categoryKey});
}
