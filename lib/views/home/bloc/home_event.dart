import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// Fired when user taps bottom navigation
class HomeTabChanged extends HomeEvent {
  final int index;

  const HomeTabChanged(this.index);

  @override
  List<Object?> get props => [index];
}
