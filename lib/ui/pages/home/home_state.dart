class HomeState {
  final int count;

  HomeState({this.count = 0});

  HomeState copyWith({
    int? count,
  }) {
    return HomeState(
      count: count ?? this.count,
    );
  }
}
