class HomeState {
  final bool? isOpenNotification;
  final bool? checkInOpen;
  final bool? checkOutOpen;

  HomeState({this.isOpenNotification, this.checkInOpen, this.checkOutOpen});

  HomeState copyWith({
    bool? isOpenNotification,
    bool? checkInOpen,
    bool? checkOutOpen,
  }) {
    return HomeState(
      isOpenNotification: isOpenNotification ?? this.isOpenNotification,
      checkInOpen: checkInOpen ?? this.checkInOpen,
      checkOutOpen: checkOutOpen ?? this.checkOutOpen,
    );
  }

  List<Object> get props =>
      [isOpenNotification ?? true, checkInOpen ?? true, checkOutOpen ?? true];
}
