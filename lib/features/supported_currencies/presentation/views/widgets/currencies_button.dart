import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../domain/entity/currency.dart';

class CurrenciesButton extends StatefulWidget {
  final String label;
  final Currency? initialValue;
  final List<Currency> data;
  final Function(Currency?)? onChanged;

  const CurrenciesButton({
    super.key,
    required this.data,
    required this.label,
    this.initialValue,
    this.onChanged,
  });

  @override
  State<CurrenciesButton> createState() => _CurrenciesButtonState();
}

class _CurrenciesButtonState extends State<CurrenciesButton> {
  Currency? _selectedValue;
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _selectedValue = widget.initialValue;
    }
  }

  @override
  void didUpdateWidget(covariant CurrenciesButton oldWidget) {
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        _selectedValue = widget.initialValue;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_selectedValue != null)
          Text(
            widget.label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButton<Currency>(
              hint: Text(widget.label),
              underline: const SizedBox(),
              isExpanded: true,
              alignment: Alignment.center,
              isDense: true,
              value: _selectedValue,
              items: widget.data
                  .map(
                    (item) => DropdownMenuItem<Currency>(
                      value: item,
                      child: Row(
                        children: [
                          if (item.flag != null) SvgPicture.network(item.flag ?? "", width: 32, fit: BoxFit.fitWidth),
                          const SizedBox(width: 16),
                          Text(item.code ?? ""),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (widget.onChanged != null) widget.onChanged!(value);
                setState(() {
                  _selectedValue = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
