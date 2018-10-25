//
//  RequestDataManager.m
//  PerfectDay
//
//  Created by debin on 12-11-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RequestDataManager.h"

@implementation RequestDataManager

static RequestDataManager *requestManager;


+ (RequestDataManager *)shareSendRequestManager
{
    if (requestManager == nil) {
        requestManager = [[RequestDataManager alloc] init];
    }
    return requestManager;
}

//#pragma mark - 新增 使用AFNetwrking框架
//
//+ (void)get:(NSString *)url params:(NSDictionary *)params acceptableContentTypes:(NSSet *)set success:(void (^)(id))success failure:(void (^)(NSError *))failure
//{
//    if(url == nil) return;
//
//    //3.8要求所有的接口都要添加的参数
//    NSMutableDictionary * addParamsDict = [NSMutableDictionary dictionaryWithDictionary:params];
//    id channelStr = [addParamsDict objectForKey:@"channel"];
//    id versionStr = [addParamsDict objectForKey:@"version"];
//    id cfromStr = [addParamsDict objectForKey:@"cfrom"];
//
//    if (versionStr == nil) {
//        [addParamsDict setObject:[NSString stringWithFormat:@"%@",version] forKey:@"version"];
//    }
//
//    if (channelStr == nil) {
//        [addParamsDict setObject:channel forKey:@"channel"];
//    }
//
//    if (cfromStr == nil) {
//        [addParamsDict setObject:cfrom forKey:@"cfrom"];
//    }
//
//#ifdef DEBUG
//    //链接拼接
//    NSMutableString * urlParamString = [NSMutableString stringWithFormat:@"%@?",url];
//    [addParamsDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        [urlParamString appendFormat:@"%@=%@&",key,obj];
//    }];
//    if ([urlParamString hasSuffix:@"&"]||[urlParamString hasSuffix:@"?"])
//    {
//        [urlParamString deleteCharactersInRange:NSMakeRange(urlParamString.length-1, 1)];
//    }
//    NSLog(@"get ---- %@", urlParamString);
//#endif
//
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//
//    if (set != nil && [set isKindOfClass:[NSSet class]])
//    {
//        manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
//        manager.responseSerializer.acceptableContentTypes = set;
//    }else{
//        manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
//    }
//    if(IOS_VERSION >=9.0){
//        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "] invertedSet]];
//    }else{
//        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    }
//    [manager GET:url parameters:addParamsDict progress:^(NSProgress * _Nonnull downloadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        //Log(@"get success ---- response = %@", NSStringFromClass([responseObject class]));
//        LYNSLog(@"get success ---- %@",url);
//        if (success) {
//            if ([responseObject isKindOfClass:[NSData class]])
//            {
//                id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//                //Log(@"get ---- changed=%@", NSStringFromClass([response class]));
//                success(response);
//            }
//            else
//            {
//                success(responseObject);
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        LYNSLog(@"get failure --- error = %@ ", error);
//        if (failure) {
//            failure(error);
//        }
//    }];
//
//}
//
//+ (void)post:(NSString *)url params:(NSDictionary *)params acceptableContentTypes:(NSSet *)set success:(void (^)(id))success failure:(void (^)(NSError *))failure
//{
//    if(url == nil) return;
//
//    //3.8要求所有的接口都要添加的参数
//    NSMutableDictionary * addParamsDict = [NSMutableDictionary dictionaryWithDictionary:params];
//    id channelStr = [addParamsDict objectForKey:@"channel"];
//    id versionStr = [addParamsDict objectForKey:@"version"];
//    id cfromStr = [addParamsDict objectForKey:@"cfrom"];
//
//
//    if (versionStr == nil) {
//        [addParamsDict setObject:[NSString stringWithFormat:@"%@",version] forKey:@"version"];
//    }
//
//    if (channelStr == nil) {
//        [addParamsDict setObject:channel forKey:@"channel"];
//    }
//
//
//    if (cfromStr == nil) {
//        [addParamsDict setObject:cfrom forKey:@"cfrom"];
//    }
//
//#ifdef DEBUG
//    NSMutableString * urlParamString = [NSMutableString stringWithFormat:@"%@?",url];
//    [addParamsDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        [urlParamString appendFormat:@"%@=%@&",key,obj];
//    }];
//    if ([urlParamString hasSuffix:@"&"]||[urlParamString hasSuffix:@"?"])
//    {
//        [urlParamString deleteCharactersInRange:NSMakeRange(urlParamString.length-1, 1)];
//    }
//    NSLog(@"post ---- %@", urlParamString);
//#endif
//
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    if (set != nil && [set isKindOfClass:[NSSet class]])
//    {
//        manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
//        manager.responseSerializer.acceptableContentTypes = set;
//    }else{
//        manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
//    }
//
//    if(IOS_VERSION >=9.0){
//        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "] invertedSet]];
//    }else{
//        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    }
//
//    [manager POST:url parameters:addParamsDict progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        //Log(@"post success ---- response = %@  isData=%d ", NSStringFromClass([responseObject class]), [responseObject isKindOfClass:[NSData class]]);
//        LYNSLog(@"post success ---- %@ ", url);
//
//        if (success) {
//            if ([responseObject isKindOfClass:[NSData class]])
//            {
//                id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//                //Log(@"post ---- changed=%@", NSStringFromClass([response class]));
//                success(response);
//            }
//            else
//            {
//                success(responseObject);
//
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        LYNSLog(@"post failure --- error %@  %@ ", urlParamString, error);
//
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//
////上传文件
//+ (void)post:(NSString *)url params:(NSDictionary *)params filename:(NSData *)file acceptableContentTypes:(NSSet *)set success:(void (^)(id))success failure:(void (^)(NSError *))failure{
//
//    if(url == nil) return;
//
//    //3.8要求所有的接口都要添加的参数
//    NSMutableDictionary * addParamsDict = [NSMutableDictionary dictionaryWithDictionary:params];
//    id channelStr = [addParamsDict objectForKey:@"channel"];
//    id versionStr = [addParamsDict objectForKey:@"version"];
//    id cfromStr = [addParamsDict objectForKey:@"cfrom"];
//
//
//    if (channelStr == nil) {
//        [addParamsDict setObject:channel forKey:@"channel"];
//    }
//
//    if (versionStr == nil) {
//        [addParamsDict setObject:[NSString stringWithFormat:@"%@",version] forKey:@"version"];
//    }
//
//    if (cfromStr == nil) {
//        [addParamsDict setObject:cfrom forKey:@"cfrom"];
//    }
//
//    NSMutableString * urlParamString = [NSMutableString stringWithFormat:@"%@?",url];
//    [addParamsDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        [urlParamString appendFormat:@"%@=%@&",key,obj];
//    }];
//    if ([urlParamString hasSuffix:@"&"]||[urlParamString hasSuffix:@"?"])
//    {
//        [urlParamString deleteCharactersInRange:NSMakeRange(urlParamString.length-1, 1)];
//    }
//    NSLog(@"post ---- %@", urlParamString);
//    url = [urlParamString copy];;
//
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    if (set != nil && [set isKindOfClass:[NSSet class]])
//    {
//        manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
//        manager.responseSerializer.acceptableContentTypes = set;
//    }else{
//        manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
//    }
//
//    if(IOS_VERSION >=9.0){
//        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "] invertedSet]];
//    }else{
//        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    }
//
//    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        [formData appendPartWithFileData:file name:@"uploadFile" fileName:@"headimage.png" mimeType:@"image/png"];//给定数据流的数据名，文件名，文件类型（以图片为例）
//
//        /*常用数据流类型：
//
//         @"image/png" 图片
//
//          @“video/quicktime” 视频流
//
//         */
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        //Log(@"post success ---- response = %@  isData=%d ", NSStringFromClass([responseObject class]), [responseObject isKindOfClass:[NSData class]]);
//        LYNSLog(@"post success ---- %@ ", url);
//
//        if (success) {
//            if ([responseObject isKindOfClass:[NSData class]])
//            {
//                id response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//                //Log(@"post ---- changed=%@", NSStringFromClass([response class]));
//                success(response);
//            }
//            else
//            {
//                success(responseObject);
//
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        LYNSLog(@"post failure --- error %@  %@ ", urlParamString, error);
//
//        if (failure) {
//            failure(error);
//        }
//    }];
//
//}
//
//
//#pragma mark - -----
//
//
///// 通过json格式访问数据
///*! 通过json格式访问数据*/
//- (void)getTheByJson:(NSDictionary *)bodyDict headDict:(NSMutableDictionary*)headDict action:(NSString *)action method:(NSString *)method target:(id)target selector:(SEL)selector
//{
//
//    NSString * urlStr = [NSString stringWithFormat:@"%@%@", webSide, action];
//
//
//    [RequestDataManager post:urlStr params:bodyDict acceptableContentTypes:[NSSet setWithObjects:@"text/xml",nil] success:^(id responseObj) {
//        [target performSelector:selector withObject:responseObj];
//    } failure:^(NSError *error) {
//        [target performSelector:selector withObject:nil];
//    }];
//
//}
//
///*！pt域名 请求数据 */
//-(void)getTheByJsonPT:(NSDictionary *)bodyDict headDict:(NSMutableDictionary *)headDict action:(NSString *)action method:(NSString *)method target:(id)target selector:(SEL)selector
//{
//    NSString * urlStr = [NSString stringWithFormat:@"%@%@", webSideJson, action];
//
//
//    [RequestDataManager post:urlStr params:bodyDict acceptableContentTypes:[NSSet setWithObjects:@"text/xml",nil] success:^(id responseObj) {
//        [target performSelector:selector withObject:responseObj];
//    } failure:^(NSError *error) {
//        [target performSelector:selector withObject:nil];
//    }];
//}
//
////{
////    dispatch_queue_t requestQueue = dispatch_queue_create("Httprequest.MyQueue", DISPATCH_QUEUE_CONCURRENT);
////
////    dispatch_block_t block = ^{
////
////        @autoreleasepool{
////
////            // 通过get方法请求数据
////
////            NSMutableString *url = [[NSMutableString alloc] init];
////            if (method&&[method isEqualToString:@"GET"]) {
////                if ([bodyDict count]>0) {
////                    [url appendFormat:@"%@%@?",webSide,action];
////                }
////                for (id key in [bodyDict allKeys]) {
////
////                    [url appendFormat:@"%@=%@&",key,[bodyDict objectForKey:key]];
////                }
////                if ([bodyDict count]>0) {
////                    [url deleteCharactersInRange:NSMakeRange([url length] - 1, 1)];
////                }
////            }else{
////                [url appendFormat:@"%@%@",webSide,action];
////            }
////            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
////            //NSLog(@"request url=%@",url);
////            [request setTimeOutSeconds:REQUEST_TIME_OUT_SEC];       // 超时时间
////            if (method&&[method isEqualToString:@"GET"]) {
////                if (headDict) {
////                    [request setRequestHeaders:headDict];
////                }
////
////                [request setRequestMethod:method];
////            }else if(method&&[method isEqualToString:@"PUT"])
////            {
////                [request setRequestMethod:@"PUT"];
////                for (id key in [bodyDict allKeys]) {
////                    [request setPostValue:[bodyDict objectForKey:key] forKey:key];
////                }
////            }else
////            {
////                [request setRequestMethod:@"POST"];
////                //[request setPostBody:(NSMutableData *)[bodyDict JSONData]]; 这句话有严重BUG!!!!
////                for (id key in bodyDict)
////                {
////                    [request setPostValue:[bodyDict objectForKey:key] forKey:key];
////                    NSLog(@"key: %@ ,value: %@",key,[bodyDict objectForKey:key]);
////                }
////                if (headDict) {
////                    [request setRequestHeaders:headDict];
////                }
////            }
////
////            [request startSynchronous];
////            NSString *response = [request responseString];
////            id result = [response JSONValue];
////
////            dispatch_async(dispatch_get_main_queue(), ^{
////
////                [target performSelector:selector withObject:result];
////
////
////            });
////        }
////    };
////    dispatch_async(requestQueue, block);
////
////}
//

@end
