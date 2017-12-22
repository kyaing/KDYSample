//
//  Tool.h
//  KYForm
//
//  Created by mac on 2017/12/19.
//

#import <UIKit/UIKit.h>

static inline UIFont *Font(NSInteger a) {
    return [UIFont systemFontOfSize:a];
}

static inline NSString *ObjectToJson(id obj) {
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

static inline id JsonToObject(NSString *str) {
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
    if (!jsonObject) {
        NSLog(@"error: %@", error);
    }
    
    return jsonObject;
}

static inline NSMutableArray* JsonToModel(NSString *fileName) {
    NSString *jsonName = [fileName componentsSeparatedByString:@"."].firstObject;
    NSString *type = [fileName componentsSeparatedByString:@"."].lastObject;
    
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:jsonName ofType:type]];
    NSMutableDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *array = [dataDic objectForKey:@"details"];
    
    return array;
}
