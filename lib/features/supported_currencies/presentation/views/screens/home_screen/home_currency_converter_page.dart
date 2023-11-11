import 'package:currency_converter/features/supported_currencies/domain/entity/currency.dart';
import 'package:currency_converter/features/supported_currencies/presentation/controllers/currency_converter_cubit/currency_converter_cubit.dart';
import 'package:currency_converter/features/supported_currencies/presentation/controllers/currency_converter_cubit/currency_converter_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/currencies_button.dart';

class HomeCurrencyConverterPage extends StatelessWidget {
  final List<Currency> data;
  const HomeCurrencyConverterPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final converterCubit = context.read<CurrencyConverterCubit>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Currency Converter",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 2),
            Text(
              "Select the base and target currencies to start..",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CurrenciesButton(
                            label: "Base Currency",
                            data: data,
                            initialValue: converterCubit.base,
                            onChanged: (value) {
                              converterCubit.base = value;
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: CurrenciesButton(
                            label: "Target Currency",
                            data: data,
                            initialValue: converterCubit.target,
                            onChanged: (value) {
                              converterCubit.target = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    TextFormField(controller: converterCubit.controller),
                    const SizedBox(height: 16),
                    BlocBuilder<CurrencyConverterCubit, CurrencyConverterStates>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              child: state is CurrencyConverterLoadingState
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(color: Colors.white),
                                    )
                                  : const Text("Convert"),
                              onPressed: () {
                                converterCubit.getResult(context, num.tryParse(converterCubit.controller.text));
                              },
                            ),
                            const SizedBox(height: 16),
                            if (state is CurrencyNewStateState)
                              Text(
                                "Result : ${converterCubit.state.value?.toStringAsFixed(2)}",
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.green[700]),
                              ),
                            if (state is CurrencyNewStateState && (converterCubit.history?.isNotEmpty ?? false)) const SizedBox(height: 32),
                            if (state is CurrencyNewStateState && (converterCubit.history?.isNotEmpty ?? false))
                              Text(
                                "7 Days Ago:",
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            if (state is CurrencyNewStateState && (converterCubit.history?.isNotEmpty ?? false))
                              ListView.builder(
                                itemCount: converterCubit.history!.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          converterCubit.history![index].date ?? "",
                                          style: Theme.of(context).textTheme.bodyLarge,
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [Text("${converterCubit.history![index].code} : ${converterCubit.history![index].value?.toStringAsFixed(2)}")],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
