//
//  VSSResetPublicKeyRequest.m
//  VirgilKeysSDK
//
//  Created by Pavel Gorb on 9/13/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSResetPublicKeyRequest.h"
#import "VSSBaseModel.h"
#import "VSSActionToken.h"
#import "VSSKeysModelCommons.h"
#import <VirgilFrameworkiOS/NSObject+VSSUtils.h>

@interface VSSResetPublicKeyRequest ()

@property (nonatomic, strong, readwrite) VSSActionToken * __nullable actionToken;
@property (nonatomic, strong) GUID * __nonnull publicKeyId;

@end

@implementation VSSResetPublicKeyRequest

@synthesize actionToken = _actionToken;
@synthesize publicKeyId = _publicKeyId;

#pragma mark - Lifecycle

- (instancetype)initWithBaseURL:(NSString *)url publicKeyId:(GUID *)publicKeyId publicKey:(NSData *)publicKey {
    self = [super initWithBaseURL:url];
    if (self == nil) {
        return nil;
    }
    
    _publicKeyId = publicKeyId;
    
    [self setRequestMethod:POST];
    NSMutableDictionary *dto = [[NSMutableDictionary alloc] init];
    if (publicKey != nil) {
        NSString *encodedPk = [publicKey base64EncodedStringWithOptions:0];
        if (encodedPk != nil) {
            dto[kVSSKeysModelPublicKey] = encodedPk;
        }
    }
    [self setRequestBodyWithObject:dto useUUID:@YES];
    
    return self;
}

- (instancetype)initWithBaseURL:(NSString *)url {
    return [self initWithBaseURL:url publicKeyId:@"" publicKey:[NSData data]];
}

#pragma mark - Overrides

- (NSString *)methodPath {
    return [NSString stringWithFormat:@"public-key/%@/actions/reset", self.publicKeyId];
}

- (NSError *)handleResponse:(NSObject *)candidate {
    NSError *error = [super handleResponse:candidate];
    if (error != nil) {
        return error;
    }
    
    // Action token always will be returned when Reset Public Key is called.
    self.actionToken = [VSSActionToken deserializeFrom:[candidate as:[NSDictionary class]]];
    if (![[self.actionToken isValid] boolValue]) {
        self.actionToken = nil;
        return [NSError errorWithDomain:kVSSKeysBaseRequestErrorDomain code:kVSSKeysBaseRequestErrorCode userInfo:@{ NSLocalizedDescriptionKey: @"Action token deserialization from the service response has been unsuccessful." }];
    }
    
    return nil;
}

@end
