sealed class WidgetEvent {}

class SearchRoomEvent extends WidgetEvent {
  final String query;
  SearchRoomEvent(this.query);
}

class SearchClearEvent extends WidgetEvent {}
