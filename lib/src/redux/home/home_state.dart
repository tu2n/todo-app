class HomeState {
  final int indexTab;


  HomeState({
    this.indexTab,

  });

  factory HomeState.initial() => HomeState(
    indexTab: 0,

  );

  HomeState copyWith({
    int indexTab,

  }) => HomeState(
    indexTab: indexTab ?? this.indexTab,
  );
}