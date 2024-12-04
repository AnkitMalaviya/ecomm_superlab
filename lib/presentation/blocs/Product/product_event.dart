abstract class SearchEvent {}

class FetchSearchResults extends SearchEvent {
  final String query;
  final int page;
  FetchSearchResults(this.query, this.page);
}
