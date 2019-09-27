import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class MakeARoomState {
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool onPlay;
  final String email;
  MakeARoomState(
      {@required this.isSubmitting,
      @required this.isSuccess,
      @required this.isFailure,
      this.email,
      this.onPlay});
  factory MakeARoomState.empty() {
    return MakeARoomState(
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        onPlay: false,
        email: "zharfan.akbar104@gmail.com");
  }
  factory MakeARoomState.loading() {
    return MakeARoomState(
        isSubmitting: true, isSuccess: false, isFailure: false, onPlay: false);
  }

  factory MakeARoomState.failure() {
    return MakeARoomState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      onPlay: false,
    );
  }

  factory MakeARoomState.success() {
    return MakeARoomState(
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      onPlay: true,
    );
  }

  factory MakeARoomState.updateEmail({
    String email,
    bool onPlay,
  }) {
    return MakeARoomState(
      email: email,
      onPlay: onPlay,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  MakeARoomState update({String email, bool onPlay}) {
    return copyWith(
      email: email,
      onPlay: false,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  MakeARoomState copyWith({
    String email,
    bool onPlay,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return MakeARoomState(
      email: email ?? this.email,
      onPlay: onPlay ?? this.onPlay,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
