//
//  RequestDataManager.h
//  PerfectDay
//
//  Created by debin on 12-11-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "NSString+SBJSON.h"

@interface RequestDataManager : NSObject

+ (RequestDataManager *)shareSendRequestManager;

/// 通过json格式访问数据
- (void)getTheByJson:(NSDictionary *)bodyDict headDict:(NSMutableDictionary*)headDict action:(NSString *)action method:(NSString *)method target:(id)target selector:(SEL)selector;

//pt域名访问数据
- (void)getTheByJsonPT:(NSDictionary *)bodyDict headDict:(NSMutableDictionary*)headDict action:(NSString *)action method:(NSString *)method target:(id)target selector:(SEL)selector;

//AFNetWorking 网络请求

/**
 *  GET请求
 *  @param url     请求链接
 *  @param params  请求参数
 *  @param set
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params acceptableContentTypes:(NSSet *)set success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 *  POST请求
 *  @param url     请求链接
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params acceptableContentTypes:(NSSet *)set success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;



/**
 POST请求上传

 @param url 请求链接
 @param params 请求参数
 @param file 文件名
 @param set set
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params filename:(NSData *)file acceptableContentTypes:(NSSet *)set success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;


@end
