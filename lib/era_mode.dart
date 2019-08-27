enum EraMode { BUDDHIST_YEAR, CHRIST_YEAR }

calculateYearEra(EraMode era, int christYear) {
  if (era == EraMode.BUDDHIST_YEAR) {
    return christYear + 543;
  }
  return christYear;
}
