# Calendar week component difference

Build CalendarWeekDifference.m against Foundation/CoreFoundation (ARC or MRC) and run it under Darling. It asks a UTC Gregorian calendar for the week-of-year, week-of-month and year-for-week-of-year differences between fixed dates (forward and backward) and checks them against known values (21 days is 3 weeks; 2021-01-01 to 2022-03-01 is 60 weeks and 4 days).

Before the fix `_CFCalendarGetComponentDifferenceV` indexed `multiple_table` past its end for those units, so the difference came back as 0 (or garbage); candidate: zero failures.
