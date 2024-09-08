# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-09-08

### Added
- Initial release of the `big5_utf8_converter` package.
- Implemented `Big5Decoder` class for converting Big5 encoded text to UTF-8.
- Support for loading custom mapping data from files.
- Efficient lookup table implementation for fast conversion.
- Comprehensive unit tests to ensure reliability.
- Option to use pre-generated mapping data or load from a file.
- Handling of invalid and incomplete Big5 sequences with customizable unknown character replacement.

### Features
- Convert Big5 encoded byte lists to UTF-8 strings.
- Support for mixed ASCII and Big5 content.
- Optional stripping of whitespace from conversion results.
- Flexible API allowing for various use cases and integration scenarios.
