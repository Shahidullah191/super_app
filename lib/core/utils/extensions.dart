import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String {
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  String get titleCase => split(' ')
      .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
      .join(' ');

  bool get isValidEmail =>
      RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  bool get isValidPhone =>
      RegExp(r'^\+?[0-9]{10,15}$').hasMatch(replaceAll(' ', ''));
}

extension IntExtensions on int {
  String get currency {
    final f = NumberFormat.currency(locale: 'bn_BD', symbol: '৳');
    return f.format(this);
  }

  String get compact => NumberFormat.compact().format(this);
}

extension DoubleExtensions on double {
  String get currency {
    final f = NumberFormat.currency(locale: 'bn_BD', symbol: '৳');
    return f.format(this);
  }

  String get compact => NumberFormat.compact().format(this);
}

extension DateTimeExtensions on DateTime {
  String get formatted => DateFormat('dd MMM yyyy').format(this);
  String get formattedWithTime =>
      DateFormat('dd MMM yyyy, hh:mm a').format(this);
  String get timeOnly => DateFormat('hh:mm a').format(this);
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}

extension WidgetExtensions on Widget {
  Widget get center => Center(child: this);
  Widget padAll(double v) => Padding(padding: EdgeInsets.all(v), child: this);
  Widget padH(double h) => Padding(
    padding: EdgeInsets.symmetric(horizontal: h),
    child: this,
  );
  Widget padV(double v) => Padding(
    padding: EdgeInsets.symmetric(vertical: v),
    child: this,
  );
}
