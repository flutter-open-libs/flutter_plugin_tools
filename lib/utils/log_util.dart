library log_util;

import 'package:logger/logger.dart';

class Log {

  static var _logger = Logger();

  static init(bool isLogEnable){
    _logger = Logger(
      printer: PrettyPrinter(
          methodCount: 2, // Number of method calls to be displayed
          errorMethodCount: 4, // Number of method calls if stacktrace is provided
          lineLength: 120, // Width of the output
          colors: true, // Colorful log messages
          printEmojis: false, // Print an emoji for each log message
          printTime: true, // Should each log print contain a timestamp
      ),
      level: isLogEnable ? Level.debug : Level.off,
    );
  }

  static e(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}){
    _logger.e(message, time: time,error : error,stackTrace:stackTrace);
  }

  static i(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}){
    _logger.i(message, time: time,error : error,stackTrace:stackTrace);
  }

  static t(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}){
    _logger.t(message, time: time,error : error,stackTrace:stackTrace);
  }

  static w(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}){
    _logger.w(message, time: time,error : error,stackTrace:stackTrace);
  }
}