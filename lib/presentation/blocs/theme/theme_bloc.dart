import 'package:flutter_bloc/flutter_bloc.dart';

// ── Events ────────────────────────────────────────────────────────────────────
abstract class ThemeEvent {
  const ThemeEvent();
}

class ToggleThemeEvent extends ThemeEvent {
  const ToggleThemeEvent();
}

class SetThemeEvent extends ThemeEvent {
  final bool isDark;
  const SetThemeEvent({required this.isDark});
}

// ── State ─────────────────────────────────────────────────────────────────────
class ThemeState {
  final bool isDark;
  const ThemeState({this.isDark = true}); // Default: dark mode

  ThemeState copyWith({bool? isDark}) =>
      ThemeState(isDark: isDark ?? this.isDark);
}

// ── BLoC ──────────────────────────────────────────────────────────────────────
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(isDark: true)) {
    on<ToggleThemeEvent>((event, emit) {
      emit(state.copyWith(isDark: !state.isDark));
    });
    on<SetThemeEvent>((event, emit) {
      emit(state.copyWith(isDark: event.isDark));
    });
  }
}
