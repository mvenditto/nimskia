import ../wrapper/sk_types

import times

converter DateTimeToSkTimeDateTime*(datetime: DateTime): sk_time_datetime_t =
  
  let zone = datetime.hour - datetime.utc.hour
  
  result = sk_time_datetime_t(
    fTimeZoneMinutes: (zone * 60).int16,
    fYear: datetime.year.uint16,
    fMonth: datetime.month.uint8,
    fDayOfWeek: datetime.weekday.uint8,
    fDay: datetime.monthday.uint8,
    fHour: datetime.hour.uint8,
    fMinute: datetime.minute.uint8,
    fSecond: datetime.second.uint8
  )