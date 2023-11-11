import 'package:currency_converter/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../domain/entity/currency.dart';

class HomeSupportedCurrenciesPage extends StatelessWidget {
  final List<Currency> data;
  const HomeSupportedCurrenciesPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi There,",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 2),
                Text(
                  "We are supporting ${data.length} currencies",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final model = data[index];
              final currency = model.exchangeRate?.toStringAsFixed(model.decimalDigits?.toInt() ?? 0) ?? "";
              return Container(
                width: context.screenWidth,
                decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (model.flag != null)
                      SvgPicture.network(
                        model.flag ?? "",
                        width: 32,
                        fit: BoxFit.fitWidth,
                      ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            model.code ?? "",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            model.name?.toString() ?? "",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "$currency \$",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.green[600], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          ),
        ],
      ),
    );
  }
}
