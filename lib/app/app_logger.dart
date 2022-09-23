import 'package:logger/logger.dart';

/// Simple class to print log to the system
var logger = Logger(
  printer: SimplePrinter(colors: true),
);
