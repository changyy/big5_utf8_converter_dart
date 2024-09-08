//part of big5_utf8_converter;
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';
import 'big5_to_utf8_lookup_data.dart';

class Big5Decoder extends Converter<List<int>, String> {
  late Uint16List big5ToUtf8LookupTable;
  late String unknownChar;

  Big5Decoder({String unknownChar = '�', String mappingFilePath = ''}) {
    this.unknownChar = unknownChar;
    if (mappingFilePath != '') {
      loadMappingFromFile(mappingFilePath);
    } else {
      big5ToUtf8LookupTable = big5ToUtf8LookupData;
    }
  }

  void loadMappingFromFile(String filePath) {
    final file = File(filePath);
    final bytes = file.readAsBytesSync();
    big5ToUtf8LookupTable = Uint16List.fromList(bytes.buffer.asUint16List());
  }

  @override
  String convert(List<int> input) {
    final buffer = StringBuffer();
    int i = 0;
    while (i < input.length) {
      if (input[i] <= 0x7E) {
        // ASCII character
        buffer.writeCharCode(input[i]);
        i++;
      } else if (i + 1 < input.length) {
        // Potential Big5 character
        final index = ((input[i] << 8) | input[i + 1]) - 0x8000;
        if (index >= 0 && index < big5ToUtf8LookupTable.length) {
          final unicode = big5ToUtf8LookupTable[index];
          if (unicode != 0) {
            buffer.write(String.fromCharCode(unicode));
          } else {
            // Unknown Big5 sequence, you might want to handle this case
            buffer.write(unknownChar);
          }
        } else {
          // Invalid Big5 sequence
          buffer.write(unknownChar);
        }
        i += 2;
      } else {
        // Incomplete sequence at the end
        buffer.write(unknownChar);
        i++;
      }
    }
    return buffer.toString();
  }

  String big5ToUtf8String(List<int> src, {bool strip = false}) {
    String result = convert(src);
    return strip ? result.trim() : result;
  }
}
