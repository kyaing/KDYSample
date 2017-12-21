//
//  Tool.h
//  KYForm
//
//  Created by mac on 2017/12/19.
//

#import <UIKit/UIKit.h>

static inline NSString *objectToJson(id obj) {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = @"";
    
    if (!jsonData) {
        NSLog(@"error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

static inline id jsonToObject(NSString *str) {
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
    if (!jsonObject) {
        NSLog(@"error: %@", error);
    }
    
    return jsonObject;
}
