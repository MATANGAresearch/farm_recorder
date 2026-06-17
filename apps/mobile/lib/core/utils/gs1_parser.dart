class Gs1ParseResult {
  final String? gtin;
  final String? lotNumber;
  final DateTime? expirationDate;

  Gs1ParseResult({this.gtin, this.lotNumber, this.expirationDate});

  @override
  String toString() {
    return 'Gs1ParseResult(gtin: $gtin, lotNumber: $lotNumber, expirationDate: $expirationDate)';
  }
}

class Gs1Parser {
  static Gs1ParseResult parse(String rawBarcode) {
    // Strip GS1 symbology prefixes (]C1 for GS1-128, ]d2 for GS1 DataMatrix)
    String cleanBarcode = rawBarcode.replaceAll(RegExp(r'^\]C1|^\]d2'), '');
    
    // Detect bracketed parenthesized format vs plain concatenated format
    if (cleanBarcode.contains('(') && cleanBarcode.contains(')')) {
      return _parseParenthesized(cleanBarcode);
    } else {
      return _parseConcatenated(cleanBarcode);
    }
  }

  static Gs1ParseResult _parseParenthesized(String barcode) {
    String? gtin;
    String? lotNumber;
    DateTime? expirationDate;

    final regExp = RegExp(r'\((\d{2})\)([^(\s]+)');
    final matches = regExp.allMatches(barcode);

    for (final match in matches) {
      final ai = match.group(1);
      final value = match.group(2);

      if (ai == '01') {
        gtin = value;
      } else if (ai == '10') {
        lotNumber = value;
      } else if (ai == '17' && value != null && value.length == 6) {
        expirationDate = _parseDate(value);
      }
    }

    return Gs1ParseResult(gtin: gtin, lotNumber: lotNumber, expirationDate: expirationDate);
  }

  static Gs1ParseResult _parseConcatenated(String barcode) {
    String? gtin;
    String? lotNumber;
    DateTime? expirationDate;

    int index = 0;
    while (index < barcode.length) {
      if (barcode.substring(index).startsWith('01') && index + 16 <= barcode.length) {
        gtin = barcode.substring(index + 2, index + 16);
        index += 16;
      } else if (barcode.substring(index).startsWith('17') && index + 8 <= barcode.length) {
        final dateStr = barcode.substring(index + 2, index + 8);
        expirationDate = _parseDate(dateStr);
        index += 8;
      } else if (barcode.substring(index).startsWith('10')) {
        final remaining = barcode.substring(index + 2);
        final gsIndex = remaining.indexOf('\u001d'); // Group separator ASCII 29 (FNC1)
        if (gsIndex != -1) {
          lotNumber = remaining.substring(0, gsIndex);
          index += 2 + gsIndex + 1;
        } else {
          lotNumber = remaining;
          break;
        }
      } else {
        index++;
      }
    }

    return Gs1ParseResult(gtin: gtin, lotNumber: lotNumber, expirationDate: expirationDate);
  }

  static DateTime? _parseDate(String dateStr) {
    try {
      final year = int.parse(dateStr.substring(0, 2)) + 2000;
      final month = int.parse(dateStr.substring(2, 4));
      final day = int.parse(dateStr.substring(4, 6));
      return DateTime.utc(year, month, day);
    } catch (_) {
      return null;
    }
  }
}
