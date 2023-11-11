import 'package:currency_converter/core/extensions/context_extension.dart';
import 'package:currency_converter/core/extensions/string_extension.dart';
import 'package:currency_converter/features/supported_currencies/presentation/views/screens/home_screen/home_currency_converter_page.dart';
import 'package:currency_converter/features/supported_currencies/presentation/views/screens/home_screen/home_supported_currencies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/supported_currencies_cubit/supported_currencies_cubit.dart';
import '../../../controllers/supported_currencies_cubit/supported_currency_states.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home_screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final result = await _askBeforeLeaving(context);
        return Future.value(result);
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<SupportedCurrenciesCubit, SupportedCurrencyStates>(
            builder: (BuildContext context, SupportedCurrencyStates state) {
              if (state is SupportedCurrencyLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SupportedCurrencyNoDataState) {
                return Center(
                  child: "no_data_found".toLottieAsset(width: context.screenWidth, repeat: true),
                );
              } else if (state is SupportedCurrencyLoadedState) {
                return _selectedPage == 0 ? HomeSupportedCurrenciesPage(data: state.data) : HomeCurrencyConverterPage(data: state.data);
              } else if (state is SupportedCurrencyErrorState) {
                return Center(
                  child: Text(state.message ?? "Something Went Wrong"),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.currency_exchange, size: 30), label: "Convert"),
          ],
          elevation: 10,
          currentIndex: _selectedPage,
          onTap: (index) {
            setState(() {
              _selectedPage = index;
            });
          },
        ),
      ),
    );
  }

  Future<bool?> _askBeforeLeaving(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.exit_to_app, size: 60, color: Colors.blue),
        title: Text(
          "Would you like to leave the app ?",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        content: Row(
          children: [
            ElevatedButton(
              child: const Text("Exit"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            const Spacer(),
            OutlinedButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
