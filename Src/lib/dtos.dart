import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dtos.g.dart';

abstract class DateDto implements Built<DateDto, DateDtoBuilder>, Comparable<DateDto> {
  factory DateDto([void updates(DateDtoBuilder b)]) = _$DateDto;

  factory DateDto.withValues(int year, int month, int day) => _$DateDto._(year: year, month: month, day: day);

  factory DateDto.fromDateTime(DateTime dateTime) {
    assert(dateTime != null);
    return DateDto.withValues(dateTime.year, dateTime.month, dateTime.day);
  }

  DateDto._();

  static Serializer<DateDto> get serializer => _$dateDtoSerializer;

  int get year;
  int get month;
  int get day;

  @override
  String toString() => "$year-$month-$day";

  @override
  int compareTo(DateDto other) {
    if (other == null) {
      return 1;
    }

    if (year > other.year) {
      return 1;
    } else if (year < other.year) {
      return -1;
    }

    if (month > other.month) {
      return 1;
    } else if (month < other.month) {
      return -1;
    }

    if (day > other.day) {
      return 1;
    } else if (day < other.day) {
      return -1;
    }

    return 0;
  }

  DateTime toDateTime() => DateTime(year, month, day);

  String toPast() {
    const daysInAYear = 365;
    const daysInAMonth = 30;

    final now = DateTime.now();
    final difference = now.difference(this.toDateTime());

    if (difference.inDays >= daysInAYear * 2) {
      return "${(difference.inDays / daysInAYear).floor()} years ago";
    } else if (difference.inDays >= daysInAYear) {
      return "a year ago";
    }

    if (difference.inDays >= daysInAMonth * 2) {
      return "${(difference.inDays / daysInAMonth).floor()} months ago";
    } else if (difference.inDays >= daysInAMonth) {
      return "a month ago";
    }

    if (difference.inDays >= 2) {
      return "${difference.inDays} days ago";
    } else if (difference.inDays == 1) {
      return "yesterday";
    }

    if (difference.inHours >= 2) {
      return "${difference.inHours} hours ago";
    } else if (difference.inHours == 1) {
      return "an hour ago";
    }

    if (difference.inMinutes >= 2) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inMinutes == 1) {
      return "a minute ago";
    }

    return "just now";
  }
}