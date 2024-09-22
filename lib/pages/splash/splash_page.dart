import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:co_table/theme/theme_bloc.dart';
import 'package:co_table/theme/theme_event.dart';
import 'package:co_table/theme/theme_state.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _showText = false;

  @override
  void initState() {
    super.initState();
    _loadSplash();
  }

  void _loadSplash() async {
    if (!mounted) return;
    context.read<ThemeBloc>().add(ChangeToDarkTheme());
    await Future.delayed(const Duration(seconds: 4));
    if (!mounted) return;
    context.read<ThemeBloc>().add(LoadTheme());
    setState(() {
      _showText = true;
    });
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              gradient: state.backgroundGradient,
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  top: _showText
                      ? MediaQuery.of(context).size.height * 0.1 - 150
                      : MediaQuery.of(context).size.height * 0.5 - 500,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Lottie.asset(
                      'assets/logos/splash_animate.json',
                      width: 1000,
                      height: 1000,
                      fit: BoxFit.contain,
                      repeat: false,
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  bottom: _showText
                      ? MediaQuery.of(context).size.height * 0.5 - 100
                      : -100,
                  left: 0,
                  right: 0,
                  child: const Text(
                    'CO-TABLE SPACE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
