import 'package:equatable/equatable.dart';

enum CheckoutStatus {
  initial,
  loading,
  success,
  failure,
}

class CheckoutState extends Equatable {
  final CheckoutStatus status;
  final String? errorMessage;

  const CheckoutState({
    this.status = CheckoutStatus.initial,
    this.errorMessage,
  });

  CheckoutState copyWith({
    CheckoutStatus? status,
    String? errorMessage,
  }) {
    return CheckoutState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
