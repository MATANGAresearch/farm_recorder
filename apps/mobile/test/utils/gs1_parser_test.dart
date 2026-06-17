import 'package:farm_recorder_mobile/core/utils/gs1_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Gs1Parser', () {
    test('parses parenthesized GS1 barcode correctly', () {
      final barcode = '(01)00871234567890(17)260630(10)LOT123XYZ';
      final result = Gs1Parser.parse(barcode);

      expect(result.gtin, equals('00871234567890'));
      expect(result.lotNumber, equals('LOT123XYZ'));
      expect(result.expirationDate, equals(DateTime.utc(2026, 6, 30)));
    });

    test('parses concatenated GS1 barcode with group separator correctly', () {
      final barcode = '01008712345678901726063010LOT999\u001dotherAI';
      final result = Gs1Parser.parse(barcode);

      expect(result.gtin, equals('00871234567890'));
      expect(result.lotNumber, equals('LOT999'));
      expect(result.expirationDate, equals(DateTime.utc(2026, 6, 30)));
    });

    test('strips symbology prefix ]C1 and ]d2', () {
      final barcodeDataMatrix = ']d201008712345678901726063010LOTDATA';
      final resultDM = Gs1Parser.parse(barcodeDataMatrix);

      expect(resultDM.gtin, equals('00871234567890'));
      expect(resultDM.lotNumber, equals('LOTDATA'));
      expect(resultDM.expirationDate, equals(DateTime.utc(2026, 6, 30)));

      final barcodeGS128 = ']C1(01)00871234567890(17)260630(10)LOT128';
      final result128 = Gs1Parser.parse(barcodeGS128);

      expect(result128.gtin, equals('00871234567890'));
      expect(result128.lotNumber, equals('LOT128'));
      expect(result128.expirationDate, equals(DateTime.utc(2026, 6, 30)));
    });
  });
}
