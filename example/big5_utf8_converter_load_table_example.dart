//import 'package:big5_utf8_converter/big5_utf8_converter.dart';
import '../lib/big5_utf8_converter.dart';

void main() {
  // 示例 Big5 编码的数据
  // 这里的数据代表 "中文"（中文） 这个词
  final List<int> big5Data = [0xa4, 0xa4, 0xa4, 0xe5];

  // 创建 Big5Decoder 实例
  final decoder =
      Big5Decoder(mappingFilePath: 'assets/big5_to_utf8_lookup.bin');

  // 转换 Big5 到 UTF-8
  final utf8String = decoder.big5ToUtf8String(big5Data);

  // 打印结果
  print('Big5 数据: $big5Data');
  print('转换后的 UTF-8 字符串: $utf8String');

  // 使用 strip 选项
  final strippedString = decoder.big5ToUtf8String(big5Data, strip: true);
  print('使用 strip 选项后的结果: $strippedString');

  // 处理包含 ASCII 和 Big5 混合的数据
  final mixedData = [
    0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x2C, 0x20, // "Hello, " in ASCII
    0xa4, 0xa4, 0xa4, 0xe5 // "中文" in Big5
  ];
  final mixedResult = decoder.big5ToUtf8String(mixedData);
  print('混合数据转换结果: $mixedResult');
}
