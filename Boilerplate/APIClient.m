//
//  APIClient.m
//  Boilerplate
//
//  Created by agatsa on 4/30/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import "APIClient.h"
#import "iSecureDataModel.h"

@implementation APIClient


+(void) fetchiSecureData:(iSecureDataCompletionHandler)complete {
    
    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfiguration];
    NSString * completePath = @"https://hackerearth.0x10.info/api/isecure?type=json&query=list_product";
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:completePath] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      
    if (!error) {
            
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:
                                                NSJSONReadingAllowFragments| NSJSONReadingMutableContainers| NSJSONReadingMutableLeaves error:&error];

        iSecureDataModel *data = [[iSecureDataModel alloc]init];
        [data setQuota_available:[NSNumber numberWithInteger:[[responseDictionary valueForKeyPath:@"quote_available"]integerValue]]];
        [data setQuota_max:[NSNumber numberWithInteger:[[responseDictionary valueForKeyPath:@"quote_max"]integerValue]]];
        [data setProductArray:[responseDictionary valueForKeyPath:@"products"]];
        
        if(complete)
            complete(data,nil);
        }
        else {
           
            NSLog(@"error : %@",[error localizedDescription]);
            if(complete)
                complete(nil,error);
            
        }

    }];
    //start Task
    [task resume];
}


@end
