import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/portfolio_repository_impl.dart';
import 'presentation/blocs/navigation/navigation_bloc.dart';
import 'presentation/blocs/portfolio/portfolio_bloc.dart';
import 'presentation/blocs/theme/theme_bloc.dart';
import 'presentation/pages/home/home_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = PortfolioRepositoryImpl();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc(),
        ),
        BlocProvider<PortfolioBloc>(
          create: (_) => PortfolioBloc(repository: repository),
        ),
        BlocProvider<NavigationBloc>(
          create: (_) => NavigationBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Asem El-Sayed Ammar | Senior Mobile Engineer',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const HomePage(),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(
                    MediaQuery.of(context).textScaleFactor.clamp(0.8, 1.2),
                  ),
                ),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
