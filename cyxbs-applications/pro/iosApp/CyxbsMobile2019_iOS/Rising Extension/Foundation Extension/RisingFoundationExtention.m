//
//  RisingFoundationExtension.m
//  Rising
//
//  Created by SSR on 2022/7/1.
//

#import "RisingFoundationExtension.h"

void RisingDetailLog(NSString *format, ...) {
    va_list list;
    va_start(list, format);
    printf("%s\n", [[NSString alloc] initWithFormat:format arguments:list].UTF8String);
    va_end(list);
}
