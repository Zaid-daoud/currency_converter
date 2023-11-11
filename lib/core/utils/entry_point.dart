import 'package:currency_converter/features/supported_currencies/presentation/controllers/currency_converter_cubit/currency_converter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../features/supported_currencies/presentation/controllers/supported_currencies_cubit/supported_currencies_cubit.dart';
import '../../features/supported_currencies/presentation/views/screens/home_screen/home_screen.dart';
import '../../features/supported_currencies/presentation/views/screens/splash_screen.dart';

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Currency Converter',
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        routes: appRoutes,
      ),
    );
  }

  List<SingleChildWidget> get providers => [
        BlocProvider(
          lazy: true,
          create: (BuildContext context) => SupportedCurrenciesCubit()..getSupportedCurrencies(),
        ),
        BlocProvider(
          lazy: true,
          create: (BuildContext context) => CurrencyConverterCubit(),
        ),
      ];

  Map<String, WidgetBuilder> get appRoutes => {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      };
}
