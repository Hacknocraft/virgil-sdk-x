//
//  VKUpdatePublicKeyRequest.h
//  VirgilKeysSDK
//
//  Created by Pavel Gorb on 9/13/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VKBaseRequest.h"
#import <VirgilFrameworkiOS/VFTypes.h>

@class VKPublicKey;
@class VCKeyPair;

@interface VKUpdatePublicKeyRequest : VKBaseRequest

@property (nonatomic, strong, readonly) VKPublicKey *publicKey;

- (instancetype)initWithBaseURL:(NSString *)url publicKeyId:(GUID *)pkId newKeyPair:(VCKeyPair *)keyPair keyPassword:(NSString *)keyPassword NS_DESIGNATED_INITIALIZER;

@end
