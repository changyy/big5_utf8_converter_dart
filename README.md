# Big5 to UTF-8 Converter

`big5_utf8_converter` is a Dart library for converting text encoded in Big5 to UTF-8. This library provides an efficient and easy-to-use method for handling Big5-encoded data, particularly useful for applications dealing with Traditional Chinese content.

## Features

- Conversion from Big5 to UTF-8
- Efficient lookup table implementation
- Support for loading mapping data from a file or using pre-generated data
- Flexible API to accommodate different use cases
- Comprehensive unit test coverage

## Installation

To use `big5_utf8_converter`, add it to your `pubspec.yaml` file:

```yaml
dependencies:
  big5_utf8_converter: ^1.0.0
```

Then run:

```
dart pub get
```

## Usage

Here's a simple usage example:

```dart
import 'package:big5_utf8_converter/big5_utf8_converter.dart';

void main() {
  // Create a Big5Decoder instance
  final decoder = Big5Decoder();

  // Example Big5 encoded data
  final List<int> big5Data = [0xa4, 0xa4, 0xa4, 0xe5];

  // Convert Big5 to UTF-8
  final utf8String = decoder.big5ToUtf8String(big5Data);

  print('Converted UTF-8 string: $utf8String');
}
```

### Loading Mapping Data from a File

If you want to load mapping data from a file:

```dart
final decoder = Big5Decoder(mappingFilePath: 'path/to/your/big5_to_utf8_lookup.bin');
```

## API Reference

### Big5Decoder

The main decoder class.

- `Big5Decoder({String unknownChar = '�', String? mappingFilePath})`: Creates a new decoder instance.
- `String big5ToUtf8String(List<int> src, {bool strip = false})`: Converts a list of Big5 encoded bytes to a UTF-8 string.

## Development

### Running Tests

To run unit tests, use the following command:

```
dart test
```

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please create an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
