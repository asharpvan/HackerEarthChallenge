//
//  APIClient.h
//  Boilerplate
//
//  Created by agatsa on 4/30/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>
@class iSecureDataModel;

typedef void(^iSecureDataCompletionHandler) (iSecureDataModel *, NSError *);


@interface APIClient : NSObject

+(void) fetchiSecureData:(iSecureDataCompletionHandler)complete;

@end
