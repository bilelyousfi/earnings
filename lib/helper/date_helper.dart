


int getQuarter(DateTime date) {
  // Determine the quarter from the month
  int month = date.month;
  if (month >= 1 && month <= 3) {
    return 1; // Q1
  } else if (month >= 4 && month <= 6) {
    return 2; // Q2
  } else if (month >= 7 && month <= 9) {
    return 3; // Q3
  } else {
    return 4; // Q4
  }
}

int getYear(DateTime date) {
  return date.year;
}