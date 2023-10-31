import 'package:flutter/material.dart';

String? noValidate(String? value) {
  return null;
}

String? requiredValue(BuildContext context, value) {
  if (value == null) return 'Este campo es requerido';

  try {
    if (value.isEmpty) return 'Este campo es requerido';
  } catch (_) {}

  return null;
}

String? validateCellphone(BuildContext context, String? value) {
  if (value == null) {
    return 'El número de teléfono inválido';
  } else if (value.isEmpty) {
    return 'El número de teléfono inválido';
  } else if (value.length < 10) {
    return 'Ingresa un número de al menos 10 dígitos';
  } else {
    return null;
  }
}

String? validateEmail(BuildContext context, String? value) {
  const finalRegexChar = '\$';
  final regex = RegExp(
    '^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$finalRegexChar',
    multiLine: true,
  );

  if (value != null &&
      value.isNotEmpty &&
      value.length > 2 &&
      regex.hasMatch(value)) {
    return null;
  } else {
    return 'Ingresa un correo válido';
  }
}

String? validateDocument(String? value) {
  if (value != null && value.isNotEmpty && value.length > 2) {
    return null;
  } else if (value != null && value.isNotEmpty && value.length < 3) {
    return 'Tu número de documento es muy corto';
  } else {
    return 'Ingresa tu documento';
  }
}

String? validatePassword(String? value) {
  if (value != null && value.isNotEmpty && value.length > 2) {
    return null;
  } else if (value != null && value.isNotEmpty && value.length < 3) {
    return 'Tu password es muy corto, prueba con otro';
  } else {
    return 'Ingresa tu password';
  }
}

/// Valida que el formatdo de la fecha sea el correcto
String? validateDate(String? input) {
  try {
    if (input != null) {
      final date = DateTime.parse(input);
      final originalFormatString = dateToFormattedString(date);

      if (input == originalFormatString) return null;
    }

    return 'Debes ingresar una fecha válida';
  } catch (e) {
    return 'Debes ingresar una fecha válida';
  }
}

String? validateTime(String? time) {
  try {
    if (time != null && time.isNotEmpty) {
      final hour = hourIsValid(time.substring(0, 2));
      final minutes = minutesIsValid(time.substring(3));

      if (hour && minutes && time.split('')[2] == ':') {
        return null;
      }
    }

    return 'Debes ingresar una hora válida';
  } catch (e) {
    return 'Debes ingresar una hora válida';
  }
}

bool hourIsValid(String hourString) {
  final hour = int.tryParse(hourString);
  return hour is int && hourString.length == 2 && hour >= 0 && hour <= 23;
}

bool minutesIsValid(String minutesString) {
  final minutes = int.tryParse(minutesString);
  return minutes is int &&
      minutesString.length == 2 &&
      minutes >= 0 &&
      minutes <= 59;
}

/// Transforma un objeto de tipo [DateTime] en un string formato "YYYY-MM-DD"
String dateToFormattedString(DateTime date) {
  final year = date.year;
  final day = date.day < 10 ? '0${date.day}' : date.day;
  final month = date.month < 10 ? '0${date.month}' : date.month;
  return '$year-$month-$day';
}

// Transforma un objeto de tipo [DateTime] en un string formato 'DD/MM/YYYY'
String dateToHospiFormatString(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');

  return '$day/$month/${date.year}';
}

/// Transforma un objeto de tipo [TimeOfDay] en un string formato "HH:MM"
String timeToFormattedString(TimeOfDay time) {
  final hour = time.hour < 10 ? '0${time.hour}' : time.hour;
  final minutes = time.minute < 10 ? '0${time.minute}' : time.minute;
  return '$hour:$minutes';
}

String? string24HToLocal12HTime(String time) {
  if (time.isEmpty) return null;
  final hourAndMinutes = time.substring(0, 5);

  if (validateTime(hourAndMinutes) != null) {
    return null;
  }

  var hour = int.parse(hourAndMinutes.substring(0, 2));
  var minutes = int.parse(hourAndMinutes.substring(3));

  var suffix = 'AM';
  if (hour == 0) return '12:$minutes $suffix';

  if (hour >= 12) {
    hour -= 12;
    suffix = 'PM';
  }

  final stringHour = hour.toString().padLeft(2, '0');
  final stringMinutes = minutes.toString().padLeft(2, '0');

  return '$stringHour:$stringMinutes $suffix';
}

bool isTimeBetween(List<TimeOfDay> timesToCompare, TimeOfDay time) {
  return isTimeGreaterOrEqual(time, timesToCompare[0]) &&
      isTimeLowerOrEqual(time, timesToCompare[1]);
}

bool isTimeGreaterOrEqual(TimeOfDay time, TimeOfDay timeToCompare) {
  return time.hour >= timeToCompare.hour && time.minute >= timeToCompare.minute;
}

bool isTimeLowerOrEqual(TimeOfDay time, TimeOfDay timeToCompare) {
  return time.hour < timeToCompare.hour ||
      (time.hour == timeToCompare.hour && time.minute <= timeToCompare.minute);
}
