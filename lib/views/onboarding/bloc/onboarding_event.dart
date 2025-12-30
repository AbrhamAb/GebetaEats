import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

/// Fired when page is swiped
class OnboardingPageChanged extends OnboardingEvent {
  final int page;

  const OnboardingPageChanged(this.page);

  @override
  List<Object?> get props => [page];
}

/// Fired when Next button is pressed
class OnboardingNextPressed extends OnboardingEvent {}
