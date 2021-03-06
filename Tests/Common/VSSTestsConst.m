//
//  VSSTestsConst.m
//  VirgilSDK
//
//  Created by Oleksandr Deundiak on 10/24/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#define STRINGIZE(x) #x
#define STRINGIZE2(x) STRINGIZE(x)

#import "VSSTestsConst.h"

@implementation VSSTestsConst

- (NSString *)applicationToken {
    return @STRINGIZE2(APPLICATION_TOKEN);
}

- (NSString *)applicationPrivateKeyBase64 {
    return @STRINGIZE2(APPLICATION_PRIVATE_KEY_BASE64);
}

- (NSString *)applicationPrivateKeyPassword {
    return @STRINGIZE2(APPLICATION_PRIVATE_KEY_PASSWORD);
}

- (NSString *)applicationIdentityType {
    return @STRINGIZE2(APPLICATION_IDENTITY_TYPE);
}

- (NSString *)applicationId {
    return @STRINGIZE2(APPLICATION_ID);
}

- (NSString *)mailinatorToken {
    return @STRINGIZE2(MAILINATOR_TOKEN);
}

- (NSURL *)cardsServiceURL {
    NSString *str = [@STRINGIZE2(CARDS_SERVICE_URL) stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    return [[NSURL alloc] initWithString:str];
}

- (NSURL *)cardsServiceROURL {
    NSString *str = [@STRINGIZE2(CARDS_SERVICE_RO_URL) stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    return [[NSURL alloc] initWithString:str];
}

- (NSURL *)identityServiceURL {
    NSString *str = [@STRINGIZE2(IDENTITY_SERVICE_URL) stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    return [[NSURL alloc] initWithString:str];
}

- (NSURL *)registrationAuthorityURL {
    NSString *str = [@STRINGIZE2(REGISTRATION_AUTHORITY_URL) stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    return [[NSURL alloc] initWithString:str];
}

- (NSURL *)authServiceURL {
    NSString *str = [@STRINGIZE2(AUTH_SERVICE_URL) stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    return [[NSURL alloc] initWithString:str];
}

- (NSString *)authServicePublicKeyBase64 {
    return @STRINGIZE2(AUTH_SERVICE_PUBLIC_KEY_BASE64);
}

@end
