//
//  VSSCreateGlobalCardHTTPRequest.m
//  VirgilSDK
//
//  Created by Oleksandr Deundiak on 1/25/17.
//  Copyright © 2017 VirgilSecurity. All rights reserved.
//

#import "VSSCreateGlobalCardHTTPRequest.h"
#import "VSSModelCommons.h"
#import "VSSCreateCardSnapshotModelPrivate.h"
#import "VSSCreateCardRequest.h"
#import "VSSSignableRequestPrivate.h"
#import "VSSCardResponsePrivate.h"
#import "NSObject+VSSUtils.h"
#import "VSSModelKeys.h"

@implementation VSSCreateGlobalCardHTTPRequest

#pragma mark - Lifecycle

- (instancetype)initWithContext:(VSSHTTPRequestContext *)context createCardRequest:(VSSCreateCardRequest *)request validationToken:(NSString *)validationToken {
    self = [super initWithContext:context];
    if (self) {
        NSMutableDictionary *body = [[request serialize] mutableCopy];
        
        NSMutableDictionary *metaDict = body[kVSSCModelMeta];
        metaDict[kVSSCModelValidation] = @{
                                           kVSSCModelToken: validationToken
                                           };
        
        [self setRequestBodyWithObject:body];
    }
    
    return self;
}

#pragma mark - Overrides

- (NSString *)methodPath {
    return @"card";
}

- (NSError *)handleResponse:(NSObject *)candidate {
    NSError *error = [super handleResponse:candidate];
    if (error != nil) {
        return error;
    }
    
    /// Deserialize actual card
    self.cardResponse = [[VSSCardResponse alloc] initWithDict:[candidate as:[NSDictionary class]]];
    return nil;
}

@end
