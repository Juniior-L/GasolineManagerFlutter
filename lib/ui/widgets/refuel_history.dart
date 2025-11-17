import 'package:flutter/material.dart';

class FuelHistory extends StatelessWidget {
  final List<Map<String, String>> history;

  const FuelHistory({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    if (history.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            "None refuel yet 😴.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Refuel history",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...history.map(
          (h) => Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: colors.secondary,
                child: Icon(Icons.local_gas_station, color: colors.onSecondary),
              ),
              title: Text(h["station"]!, style: theme.textTheme.titleMedium),
              subtitle: Text(h["date"]!, style: theme.textTheme.bodyMedium),
              trailing: Text(
                h["value"]!,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

