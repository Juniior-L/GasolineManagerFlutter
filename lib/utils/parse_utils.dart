 double parseDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      return 1.0;
    }
  }

  double parseNumber(String text) {
    if (text.isEmpty) return 0.0;
    var cleaned = text.replaceAll('R\$', '').trim();
    cleaned =
        cleaned.replaceAll('.', '').replaceAll(',', '.').replaceAll(' ', '');
    return double.tryParse(cleaned) ?? 0.0;
  }