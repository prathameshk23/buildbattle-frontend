import 'package:intl/intl.dart';

String formatFriendlyDate(DateTime date) =>
    DateFormat('EEE, MMM d').format(date);
String formatCompactDate(DateTime date) =>
    DateFormat('MMM d, yyyy').format(date);
