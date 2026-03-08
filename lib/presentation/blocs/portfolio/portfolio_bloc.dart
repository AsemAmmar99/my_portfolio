import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/portfolio_repository_impl.dart';
import 'portfolio_state_event.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final PortfolioRepositoryImpl _repository;

  PortfolioBloc({required PortfolioRepositoryImpl repository})
      : _repository = repository,
        super(PortfolioInitial()) {
    on<LoadPortfolioEvent>(_onLoadPortfolio);
  }

  Future<void> _onLoadPortfolio(
    LoadPortfolioEvent event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(PortfolioLoading());
    try {
      final results = await Future.wait([
        _repository.getProjects(),
        _repository.getExperience(),
        _repository.getSkillCategories(),
      ]);

      emit(PortfolioLoaded(
        projects: results[0] as dynamic,
        experience: results[1] as dynamic,
        skillCategories: results[2] as dynamic,
      ));
    } catch (e) {
      emit(PortfolioError('Failed to load portfolio: ${e.toString()}'));
    }
  }
}

