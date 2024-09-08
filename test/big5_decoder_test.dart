import 'package:test/test.dart';
import 'package:big5_utf8_converter/big5_utf8_converter.dart';

void main() {
  group('Big5Decoder Tests', () {
    late Big5Decoder decoderPregen;
    late Big5Decoder decoderFile;

    setUp(() {
      decoderPregen = Big5Decoder();
      decoderFile =
          Big5Decoder(mappingFilePath: 'assets/big5_to_utf8_lookup.bin');
    });

    test('Decode "中文" using pre-generated data', () {
      final big5Data = [0xa4, 0xa4, 0xa4, 0xe5];
      expect(decoderPregen.big5ToUtf8String(big5Data), equals('中文'));
    });

    test('Decode "中文" using file data', () {
      final big5Data = [0xa4, 0xa4, 0xa4, 0xe5];
      expect(decoderFile.big5ToUtf8String(big5Data), equals('中文'));
    });

    test('Decode "Hello, 中文" using pre-generated data', () {
      final mixedData = [
        0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x2C, 0x20, // "Hello, " in ASCII
        0xa4, 0xa4, 0xa4, 0xe5 // "中文" in Big5
      ];
      expect(decoderPregen.big5ToUtf8String(mixedData), equals('Hello, 中文'));
    });

    test('Decode "Hello, 中文" using file data', () {
      final mixedData = [
        0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x2C, 0x20, // "Hello, " in ASCII
        0xa4, 0xa4, 0xa4, 0xe5 // "中文" in Big5
      ];
      expect(decoderFile.big5ToUtf8String(mixedData), equals('Hello, 中文'));
    });

    //test('Handle invalid Big5 sequence', () {
    //  final invalidData = [0xFF, 0xFF];
    //  expect(decoderPregen.big5ToUtf8String(invalidData), equals('��'));
    //  expect(decoderFile.big5ToUtf8String(invalidData), equals('��'));
    //});

    test('Handle incomplete Big5 sequence', () {
      final incompleteData = [0xa4];
      expect(decoderPregen.big5ToUtf8String(incompleteData), equals('�'));
      expect(decoderFile.big5ToUtf8String(incompleteData), equals('�'));
    });

    test('Test strip option', () {
      final big5Data = [0xa4, 0xa4, 0xa4, 0xe5];
      expect(
          decoderPregen.big5ToUtf8String(big5Data, strip: true), equals('中文'));
      expect(decoderFile.big5ToUtf8String(big5Data, strip: true), equals('中文'));
    });
  });
}
