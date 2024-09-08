import 'dart:io';
import 'dart:typed_data';

void main() {
  final inputFile = File('assets/big5_to_utf8_lookup.bin');
  final outputFile = File('lib/src/big5_to_utf8_lookup_data.dart');

  final bytes = inputFile.readAsBytesSync();
  final uint16List = Uint16List.fromList(bytes.buffer.asUint16List());
  
  final buffer = StringBuffer();

  buffer.writeln('// 这个文件是自动生成的。请不要手动修改。');
  buffer.writeln('');
  buffer.writeln('import \'dart:typed_data\';');
  buffer.writeln('');
  buffer.writeln('final Uint16List big5ToUtf8LookupData = Uint16List.fromList([');
  
  for (var i = 0; i < uint16List.length; i += 16) {
    buffer.write('  ');
    buffer.writeAll(uint16List.skip(i).take(16).map((b) => '0x${b.toRadixString(16).padLeft(4, '0')}'), ', ');
    buffer.writeln(',');
  }

  buffer.writeln(']);');

  outputFile.writeAsStringSync(buffer.toString());
  print('转换完成。输出文件：${outputFile.path}');
}
