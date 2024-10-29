import 'dart:typed_data';
import 'dart:convert';
import 'big5_to_utf8_lookup_data.dart';

/// A decoder that converts Big5 encoded bytes to UTF-8 String.
///
/// This decoder handles both ASCII characters (0x00-0x7E) and Big5 encoded
/// characters. For Big5 characters, it uses a lookup table to convert them
/// to their corresponding Unicode code points.
///
/// Example usage:
/// ```dart
/// final decoder = Big5Decoder();
/// final big5Bytes = [0xA4, 0x40]; // Big5 encoding for "中"
/// final utf8String = decoder.convert(big5Bytes);
/// print(utf8String); // Outputs: 中
/// ```
class Big5Decoder extends Converter<List<int>, String> {
  /// Lookup table for converting Big5 codes to Unicode code points.
  ///
  /// Each entry in this table represents the Unicode code point for
  /// a corresponding Big5 character code.
  late Uint16List big5ToUtf8LookupTable;

  /// Character to use when an unknown or invalid Big5 sequence is encountered.
  ///
  /// Defaults to '�' (Unicode replacement character).
  late String unknownChar;

  /// Creates a new Big5Decoder instance.
  ///
  /// [unknownChar] specifies the character to use when an unknown or invalid
  /// Big5 sequence is encountered. Defaults to '�' (Unicode replacement character).
  Big5Decoder({String unknownChar = '�'}) {
    this.unknownChar = unknownChar;
    big5ToUtf8LookupTable = big5ToUtf8LookupData;
  }

  /// Loads a custom mapping table from a list of bytes.
  ///
  /// This method allows you to override the default Big5 to UTF8 mapping
  /// with a custom one. The input bytes should represent a Uint16 array
  /// where each entry maps to a Unicode code point.
  ///
  /// [bytesBufferAsUint16List] - List of integers representing the mapping table.
  void loadMappingFromBytes(List<int> bytesBufferAsUint16List) {
    big5ToUtf8LookupTable = Uint16List.fromList(bytesBufferAsUint16List);
  }

  /// Converts a list of Big5 encoded bytes to a UTF-8 String.
  ///
  /// This implementation handles:
  /// - ASCII characters (0x00-0x7E)
  /// - Two-byte Big5 characters
  /// - Unknown or invalid sequences (replaced with [unknownChar])
  ///
  /// [input] - List of integers representing Big5 encoded bytes.
  ///
  /// Returns a UTF-8 encoded String.
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

  /// Converts Big5 encoded bytes to UTF-8 String with optional whitespace stripping.
  ///
  /// This is a convenience method that wraps [convert] and adds the ability
  /// to strip whitespace from the result.
  ///
  /// [src] - List of integers representing Big5 encoded bytes.
  /// [strip] - If true, removes leading and trailing whitespace from the result.
  ///
  /// Returns a UTF-8 encoded String, optionally with whitespace removed.
  String big5ToUtf8String(List<int> src, {bool strip = false}) {
    String result = convert(src);
    return strip ? result.trim() : result;
  }
}
