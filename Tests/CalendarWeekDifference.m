#import <Foundation/Foundation.h>
#include <stdio.h>

static int failures;

static void check_result(const char *label, BOOL ok)
{
    printf("%s %s\n", ok ? "PASS" : "FAIL", label);
    failures += !ok;
}

int main(void)
{
    @autoreleasepool
    {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:(NSString *)kCFGregorianCalendar];
        [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

        // 2021-01-01 and 2021-01-22 00:00 UTC
        NSDate *start = [NSDate dateWithTimeIntervalSince1970:1609459200];
        NSDate *threeWeeks = [NSDate dateWithTimeIntervalSince1970:1609459200 + 21 * 86400];
        // 2022-03-01 00:00 UTC
        NSDate *later = [NSDate dateWithTimeIntervalSince1970:1646092800];

        NSDateComponents *c = [calendar components:NSCalendarUnitWeekOfYear fromDate:start toDate:threeWeeks options:0];
        check_result("weekOfYear forward", [c weekOfYear] == 3);

        c = [calendar components:NSCalendarUnitWeekOfMonth fromDate:start toDate:threeWeeks options:0];
        check_result("weekOfMonth forward", [c weekOfMonth] == 3);

        c = [calendar components:NSCalendarUnitWeekOfYear fromDate:threeWeeks toDate:start options:0];
        check_result("weekOfYear backward", [c weekOfYear] == -3);

        c = [calendar components:NSCalendarUnitYearForWeekOfYear fromDate:start toDate:later options:0];
        check_result("yearForWeekOfYear forward", [c yearForWeekOfYear] == 1);

        c = [calendar components:NSCalendarUnitWeekOfYear | NSCalendarUnitDay fromDate:start toDate:later options:0];
        check_result("weekOfYear with day remainder", [c weekOfYear] == 60 && [c day] == 4);
    }
    return failures != 0;
}
