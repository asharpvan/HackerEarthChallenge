//
//  iSecureDataModel.h
//  Boilerplate
//
//  Created by agatsa on 4/30/16.
//  Copyright © 2016 Agatsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iSecureDataModel : NSObject

@property (strong, nonatomic) NSArray *productArray;

@property (strong, nonatomic) NSNumber *quota_max;
@property (strong, nonatomic) NSNumber *quota_available;

@end
