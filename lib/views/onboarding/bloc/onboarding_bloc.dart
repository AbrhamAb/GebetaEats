import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebeta_eats/models/mock_data.dart';

import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc
    extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingState()) {
    on<OnboardingPageChanged>(_onPageChanged);
    on<OnboardingNextPressed>(_onNextPressed);
  }

  void _onPageChanged(
    OnboardingPageChanged event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(currentPage: event.page));
  }

  void _onNextPressed(
    OnboardingNextPressed event,
    Emitter<OnboardingState> emit,
  ) {
    final isLastPage =
        state.currentPage == onboardingPages.length - 1;

    if (isLastPage) {
      emit(state.copyWith(completed: true));
    } else {
      emit(
        state.copyWith(currentPage: state.currentPage + 1),
      );
    }
  }
}
