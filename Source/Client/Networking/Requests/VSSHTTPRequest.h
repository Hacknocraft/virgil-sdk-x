//
//  VSSHTTPRequest.h
//  VirgilSDK
//
//  Created by Pavel Gorb on 9/7/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define USE_SERVICE_REQUEST_DEBUG 1
#endif

/// Debugging macro
#if USE_SERVICE_REQUEST_DEBUG
#  define VSSRDLog(...) NSLog(__VA_ARGS__)
# else
#  define VSSRDLog(...) /* nothing to log */
#endif

#import "VSSHTTPRequestContext.h"

/**
 * Enum for HTTP Request methods.
 */
typedef NS_ENUM(NSUInteger, HTTPRequestMethod) {
    /// HTTP method GET.
    GET,
    /// HTTP method POST. Used by default.
    POST,
    /// HTTP method PUT.
    PUT,
    /// HTTP method DELETE.
    DELETE
};

@class VSSHTTPRequest;
/**
 * Callback for operation completion.
 */
typedef void (^VSSHTTPRequestCompletionHandler)(VSSHTTPRequest * __nonnull request);

/**
 * Default timeout value for the HTTP operations.
 */
extern const NSTimeInterval kVSSHTTPRequestDefaultTimeout;

/**
 * Default HTTP method for HTTP operations.
 */
extern NSString * __nonnull const kVSSHTTPRequestDefaultMethod;

/**
 * Error domain for the request errors.
 */
extern NSString * __nonnull const kVSSHTTPRequestErrorDomain;

/**
 * Header name for the Access token.
 */
extern NSString * __nonnull const kVSSAccessTokenHeader;

/**
 * Base wrapper class for HTTP requests.
 */
@interface VSSHTTPRequest : NSObject

/**
 * Context for the request.
 */
@property (nonatomic, strong, readonly) VSSHTTPRequestContext * __nonnull context;

/**
 * Underlying HTTP request.
 */
@property (nonatomic) NSURLRequest * __nonnull request;

/** 
 * Response for the underlying HTTP request.
 */
@property (nonatomic) NSHTTPURLResponse * __nullable response;

/** 
 * Error object if one occured.
 */
@property (nonatomic) NSError * __nullable error;

/**
 * HTTP response body data.
 */
@property (nonatomic) NSData * __nullable responseBody;

/** 
 * Callback for request completion. Also called in case of error.
 */
@property (nonatomic, copy) VSSHTTPRequestCompletionHandler __nullable completionHandler;

///------------------------------------------
/// @name Lifecycle
///------------------------------------------

/**
 * Designated constructor.
 * Initialize HTTP operation with HTTP request target URL.
 *
 * @param context The request context.
 *
 * @return Instance of particular network operation.
 */
- (instancetype __nonnull)initWithContext:(VSSHTTPRequestContext * __nonnull)context NS_DESIGNATED_INITIALIZER;

- (instancetype __nonnull)init NS_UNAVAILABLE;

///------------------------------------------
/// @name Setup
///------------------------------------------

/**
 * Sets the HTTP request method.
 *
 * @param method HTTP request method to set.
 */
- (void)setRequestMethod:(HTTPRequestMethod)method;

/**
 * Sets the HTTP headers with header name-value pairs derived from the dictionary. 
 * Existing headers are overwritten.
 *
 * @param headers String to String dictionary with key-value pars for the header names and values.
 */
- (void)setRequestHeaders:(NSDictionary * __nonnull)headers;

/**
 * Sets the HTTP request body with given data.
 */
- (void)setRequestBody:(NSData * __nonnull)body;

/**
 * Returns relative path of the particular request.
 * Root implementation returns empty string.
 * @warning Should be overriden in descendants.
 *
 * @return service method name (path to it) which should be called related to service base url.
 */
@property (nonatomic, readonly, copy) NSString * _Nonnull methodPath;

/**
 * This method is called when underlying request has been done by url session. It returns the object which is derived from the response data.
 * Root implementation returns nil.
 * @warning Should be overriden in descendants.
 * 
 * @return Some object derived from the response data. NSError in case of parsing error.
 */
- (NSObject * __nullable)parseResponse;

/**
 * This method is called when underlying request has been done by url session after parseResponse. 
 * It takes as parameter the object returned from parseResponse. 
 * If that object contains some logical service error or parsing error - this method should process this error and return it.
 * @warning Should be overriden. Descendants should call super.
 *
 * @param candidate NSObject received by call to parseResponse method.\
 *
 * @param code NSInteger http error code
 *
 * @return NSError in case of any errors inside response data or during the parsing. Otherwise returns nil.
 */
- (NSError * __nullable)handleError:(NSObject * __nullable)candidate code:(NSInteger)code;

/**
 * This method is called when underlying request has been done by url session, after parseResponse and after handleError. 
 * Because of this, parameter of this method should contain coorectly parsed object and it should never be NSError or any kind of logical service error. 
 * But even not-error response may sometimes be broken by absence some mandatory params, etc.
 * @warning Should be overriden. Descendants should call super and check for error in return value.
 * 
 * @param candidate NSObject received by call to -parseResponse method.
 *
 * @return NSError in case of error during handling the object. Otherwise - nil.
 */
- (NSError * __nullable)handleResponse:(NSObject * __nullable)candidate;

/**
 * Returns fully setup data task for given session ready for further usage.
 * 
 * @param session NSURLSession which is supposed to use returned task.
 *
 * @return Data task ready for usage by the session.
 */
- (NSURLSessionDataTask * __nonnull)taskForSession:(NSURLSession * __nonnull)session;

@end
