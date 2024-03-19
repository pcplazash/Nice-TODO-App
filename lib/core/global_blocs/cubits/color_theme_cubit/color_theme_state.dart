part of 'color_theme_cubit.dart';

class ColorThemeState extends Equatable {
  final ThemeMode themeMode;

  const ColorThemeState({required this.themeMode});

  factory ColorThemeState.initial(){
    return const ColorThemeState(themeMode: ThemeMode.light);
  }

  @override
  List<Object> get props => [themeMode];

  ColorThemeState copyWith({
    ThemeMode? themeMode,
  }) {
    return ColorThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  String toString() {
    return 'ThemeState{themeMode: $themeMode}';
  }
}
