import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ── State ─────────────────────────────────────────────────────────────────────
class NavigationState extends Equatable {
  final int activeIndex; // index into AppConstants.navSections
  final bool isScrolled;

  const NavigationState({
    this.activeIndex = 0,
    this.isScrolled = false,
  });

  NavigationState copyWith({int? activeIndex, bool? isScrolled}) {
    return NavigationState(
      activeIndex: activeIndex ?? this.activeIndex,
      isScrolled: isScrolled ?? this.isScrolled,
    );
  }

  @override
  List<Object?> get props => [activeIndex, isScrolled];
}

// ── Events ─────────────────────────────────────────────────────────────────────
abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
  @override
  List<Object?> get props => [];
}

class UpdateActiveSectionEvent extends NavigationEvent {
  final int index;
  const UpdateActiveSectionEvent(this.index);
  @override
  List<Object?> get props => [index];
}

class UpdateScrolledEvent extends NavigationEvent {
  final bool isScrolled;
  const UpdateScrolledEvent(this.isScrolled);
  @override
  List<Object?> get props => [isScrolled];
}

// ── BLoC ──────────────────────────────────────────────────────────────────────
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState()) {
    on<UpdateActiveSectionEvent>(_onUpdateSection);
    on<UpdateScrolledEvent>(_onUpdateScrolled);
  }

  void _onUpdateSection(
      UpdateActiveSectionEvent event, Emitter<NavigationState> emit) {
    emit(state.copyWith(activeIndex: event.index));
  }

  void _onUpdateScrolled(
      UpdateScrolledEvent event, Emitter<NavigationState> emit) {
    emit(state.copyWith(isScrolled: event.isScrolled));
  }
}
