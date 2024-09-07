import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const primaryColor = Color(0xFF0B86E7);
const secondaryColor = Colors.white;

const defaultPadding = 16.0;

// Assuming item.publishedAt is a String in ISO 8601 format (e.g., "2024-08-23T16:16:21Z")
String formattedDate(DateTime publishedAt) {
  // Format the DateTime to 'yyyy-MM-dd HH:mm' format
  String formatted = DateFormat('yyyy-MM-dd HH:mm').format(publishedAt);
  return formatted;
}
