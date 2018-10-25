//
//  LYTool.m
//  159qiuxing
//
//  Created by lx on 2017/9/29.
//  Copyright © 2017年 lx. All rights reserved.
//

#import "LYTool.h"
//#import "LYToastView.h"
//#import "Reachability.h"

//#import "LYShareThirdView.h"
//#import "LYTimeModel.h"


//#import <WXApi.h>
//#import <TencentOpenAPI/TencentOAuth.h>
@implementation LYTool


#pragma mark - 缓存处理

static LYTool *tool  =nil;
+ (LYTool *)shareLYTool{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[LYTool alloc] init];
    });
    return tool;
}

+ (NSString *)getCachesSize
{
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    
    if (![fileManager fileExistsAtPath:cachePath]) { return @"0 M"; }
    
    unsigned long long sumSize = 0;
    NSDictionary * attributeDic = [fileManager attributesOfItemAtPath:cachePath error:nil];
    NSString * fileType = attributeDic.fileType;
    
    //判断所给的路径是文件夹 还是文件
    if ([fileType isEqualToString:NSFileTypeDirectory])
    {
        //文件夹下的所有子文件路径, 包括文件夹套文件夹
        NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:cachePath];
        for (NSString *subpath in enumerator)
        {
            NSString * fullSubpath = [cachePath stringByAppendingPathComponent:subpath];
            unsigned long long subFileSize = [fileManager fileExistsAtPath:fullSubpath]?[[fileManager attributesOfItemAtPath:fullSubpath error:nil] fileSize]:0;
            sumSize += subFileSize;
            //NSLog(@"%@ %lld %lld", subpath, subFileSize, sumSize);
        }
    }
    else
    {
        sumSize = attributeDic.fileSize;
    }
    
    
    NSString * cacheSizeStr = [NSString stringWithFormat:@"%.1f M",sumSize/(1024.0*1024.0)];
    
    return cacheSizeStr;
    
}


- (void)clearCacheSuccess:(void (^)(void))success
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        
        NSArray * subPaths = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        //NSLog(@"files :%@",subPaths);
        for (NSString * subPath in subPaths)
        {
            NSString * fullSubpath = [cachPath stringByAppendingPathComponent:subPath];
            if ([[NSFileManager defaultManager] fileExistsAtPath:fullSubpath])
            {
                [[NSFileManager defaultManager] removeItemAtPath:fullSubpath error:nil];
            }
        }
        //[self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
        success();
    });
}

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor*)colorWithHexString:(NSString*)color
{
    NSString* cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString* rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString* gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString* bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r / 255.0f)green:((float)g / 255.0f)blue:((float)b / 255.0f)alpha:1.0f];
}

//获取字符串的宽度
+ (CGFloat) getWidthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height
{
    CGRect rect = [value boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect.size.width;
}
//带有字体的类型 获取字符串的宽度
+ (CGFloat) getWidthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height fontStyle:(NSString *)fontstyle{
    CGRect rect = [value boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:fontstyle == nil?[UIFont systemFontOfSize:fontSize]:[UIFont fontWithName:fontstyle size:fontSize]} context:nil];
    return rect.size.width;
}

//获取字符串的高度
+ (CGFloat) getHeightForString:(NSString *)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width
{
    CGRect rect = [value boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect.size.height;
    
}

//带有字体的类型 获取字符串的高度
+ (CGFloat) getHeightForString:(NSString *)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width fontStyle:(NSString *)fontstyle{
    
    CGRect rect = [value boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:fontstyle == nil?[UIFont systemFontOfSize:fontSize]:[UIFont fontWithName:fontstyle size:fontSize]} context:nil];
    return rect.size.height;
}


+ (NSAttributedString *)willBecomeColorNeedStringOfAllString:(NSString *)allString needBecomeString:(NSString *)becomeString needColor:(UIColor *)color needFont:(UIFont *)font
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:allString];
    NSRange range = [allString rangeOfString:becomeString];
    if (color) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    if (font) {
        [attributedString addAttribute:NSFontAttributeName value:font range:range];
    }
    return attributedString;
}
////展示网络加载动画
//+ (void)showMBProgressHUDView:(UIView *)view{
//    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hub.userInteractionEnabled = NO;
//    hub.label.text = @"获取数据中...";
//}
////隐藏网络加载动画
//+ (void)hidenMBProgressHUDView:(UIView *)view{
//    [MBProgressHUD hideHUDForView:view animated:YES];
//}
//
//+ (void)showToastViewTimeToHiden:(NSString *)toastStr{
//
//    CGRect frame;
//    CGFloat width = [LYTool getWidthForString:toastStr fontSize:KPT_SCAlE(14) andHeight:KPT_SCAlE(30) fontStyle:@"PingFang-SC-Regular"];
//    if (width>KPT_SCAlE(257)) {
//        CGFloat height = [LYTool getHeightForString:toastStr fontSize:KPT_SCAlE(14) andWidth:KPT_SCAlE(257) fontStyle:@"PingFang-SC-Regular"];
//        frame = CGRectMake(0, 0, KPT_SCAlE(323), height+KPT_SCAlE(25));
//    }else{
//        frame = CGRectMake(0, 0, width+KPT_SCAlE(34)*2, KPT_SCAlE(30));
//    }
//    LYToastView *toasView = [LYToastView creatLYToastView:frame];
//    toasView.layer.cornerRadius = KPT_SCAlE(15);
//    toasView.clipsToBounds = YES;
//    toasView.backgroundColor = [[LYTool colorWithHexString:@"47484C"] colorWithAlphaComponent:0.6];
//    toasView.toastStr = toastStr;
//    toasView.center = [UIApplication sharedApplication].keyWindow.center;
//    [[UIApplication sharedApplication].keyWindow addSubview:toasView];
//    __block LYToastView *blockToasView =  toasView;
//    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5/*延迟执行时间*/ * NSEC_PER_SEC));
//    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//        [UIView animateWithDuration:0.5 animations:^{
////            [blockToasView removeFromSuperview];
//            blockToasView.backgroundColor = [[LYTool colorWithHexString:@"47484C"] colorWithAlphaComponent:0];
//        } completion:^(BOOL finished) {
//            [blockToasView removeFromSuperview];
//            blockToasView = nil;
//        }];
//    });
//
//}


//// 网络判断
//+(BOOL) isConnectionAvailable{
//
//    BOOL isExistenceNetwork = YES;
//    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
//    switch ([reach currentReachabilityStatus]) {
//        case NotReachable:
//            isExistenceNetwork = NO;
//            break;
//        case ReachableViaWiFi:
//            isExistenceNetwork = YES;
//            break;
//        case ReachableViaWWAN:
//            isExistenceNetwork = YES;
//            break;
//    }
//    return isExistenceNetwork;
//}


//带有多个按钮的提示框
+(void)showToastViewCancelAndSendButtonWithTitle:(NSString *)title buttonsList:(NSArray *)array target:(id)target onCliclk:(void(^)(NSInteger index))onCliclkButtonIndex{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    if (array == nil) {
        UIAlertAction *left_action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            onCliclkButtonIndex(0);
        }];
        [alertVC addAction:left_action];
        
        UIAlertAction *right_action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            onCliclkButtonIndex(1);
        }];
        [alertVC addAction:right_action];
    }else{
        int i = 0;
        for (NSString *str in array) {
            UIAlertAction *right_action = [UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                onCliclkButtonIndex(i);
            }];
            [alertVC addAction:right_action];
            i++;
        }
    }
    
    [target presentViewController:alertVC animated:YES completion:nil];
    
}

////创建底部的footerView
//+ (UIView *)creatTableViewFooterView:(NSString *)titleStr{
//
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KPT_SCAlE(40))];
//    footerView.backgroundColor = [UIColor whiteColor];
//
//    UIView * line = [[UIView alloc] init];
//    line.size =CGSizeMake(SCREEN_WIDTH-KPT_SCAlE(109)- KPT_SCAlE(102), 0.5);
//    line.backgroundColor = [LYTool colorWithHexString:@"DBDBDB"];
//    line.center = footerView.center;
//    line.centerY -= KPT_SCAlE(7);
//    [footerView addSubview:line];
//
//    CGFloat title_width = [LYTool getWidthForString:titleStr fontSize:KPT_SCAlE(13) andHeight:KPT_SCAlE(12.5) fontStyle:@"PingFang-SC-Medium"];
//    UILabel *titleLbl = [[UILabel alloc] init];
//    titleLbl.size = CGSizeMake(title_width+KPT_SCAlE(10), KPT_SCAlE(12.5));
//    titleLbl.center = line.center;
//    titleLbl.text = titleStr;
//    titleLbl.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:KPT_SCAlE(13)];
//    titleLbl.textColor = [LYTool colorWithHexString:@"999999"];
//    titleLbl.textAlignment = NSTextAlignmentCenter;
//    [footerView addSubview:titleLbl];
//    titleLbl.backgroundColor = [UIColor whiteColor];
//
//    return footerView;
//}


//图片压缩到指定大小
+ (NSData *)imageByScalingAndCroppingForSize:(CGSize)targetSize withImage:(UIImage *)image
{
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.7);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(newImage, 0.8);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
}


////分享的界面的展示
//+ (void)showShareViewToSupviewWithFrame:(CGRect)frame WithList:(NSArray *)list delegate:(id)delegate{
//
//    LYShareThirdView *shareView = [LYShareThirdView creatLYShareThirdViewWithFrame:frame withList:list];
//    shareView.delegate = delegate;
//    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
//}

+ (NSString *)getValueStr:(NSString *)valueStr{
    
    NSString *tempStr;
    CGFloat tempValue = [valueStr floatValue];
    int temp = [valueStr intValue];
    if (tempValue >= 10000) {
        tempStr = temp%10000 == 0? [NSString stringWithFormat:@"%.f万",tempValue/10000]:[NSString stringWithFormat:@"%.2f万",tempValue/10000];
    }else{
        tempStr = [NSString stringWithFormat:@"%.f",tempValue];
    }
    return tempStr;
    
}



////签到成功
//+ (void)showSignAlterViewWithLevel:(int)level levelStr:(NSString *)levelStr target:(id)target isShowTitle:(BOOL)isShowTitle{
//
//    NSString *title = isShowTitle == YES? @"签到成功！":nil;
//
//    NSString *message;
//    if (isShowTitle) {
//        message = [NSString stringWithFormat:@"今日第%d名签到\n贡献值+%@",level,levelStr];
//    }else{
//        message = [NSString stringWithFormat:@"经验值：%d/%@",level,levelStr];
//    }
//    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:nil];
//    [cancelAction setValue:[LYTool colorWithHexString:@"007AFF"] forKey:@"titleTextColor"];
//    [alterVC addAction:cancelAction];
//
//
//    if (title) {
//        NSMutableAttributedString *titilAttribute = [[NSMutableAttributedString alloc] initWithString:title];
//        [titilAttribute setAttributes:@{NSForegroundColorAttributeName:[LYTool colorWithHexString:@"333333"],NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:KPT_SCAlE(17)]} range:NSMakeRange(0, title.length)];
//        [alterVC setValue:titilAttribute forKey:@"attributedTitle"];
//    }
//
//
//    NSMutableAttributedString *messageAttribute = [[NSMutableAttributedString alloc] initWithString:message];
//    [messageAttribute setAttributes:@{NSForegroundColorAttributeName:[LYTool colorWithHexString:@"333333"],NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size:KPT_SCAlE(17)]} range:NSMakeRange(0, message.length)];
//
//    NSRange rangeOne = [message rangeOfString:[NSString stringWithFormat:@"%d",level]];
//    NSRange rangeTwo = [message rangeOfString:[NSString stringWithFormat:@"+%@",levelStr]];
//    if (isShowTitle) {
//        [messageAttribute setAttributes:@{NSForegroundColorAttributeName:[LYTool colorWithHexString:@"0FC4C4"]} range:rangeTwo];
//        [messageAttribute setAttributes:@{NSForegroundColorAttributeName:[LYTool colorWithHexString:@"0FC4C4"]} range:rangeOne];
//    }
//    [alterVC setValue:messageAttribute forKey:@"attributedMessage"];
//
//    [target presentViewController:alterVC animated:YES completion:nil];
//
//}


//弹出框的提示
+ (void)showAlterViewWithTitle:(NSString *)title message:(NSString *)message completeBlock:(void(^)(NSInteger index))completeBlock{
    
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completeBlock(0);
    }];
    [alter addAction:cancel];
    UIAlertAction *complete = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completeBlock(1);
    }];
    [alter addAction:complete];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alter animated:YES completion:nil];
}

//// 获取某年某月到某年某月的之间的所有年月
//+ (NSArray *)getDatesWithFromDateStr:(NSString *)fromDateStr  withToDateStr:(NSString *)toDateStr{
//
//    NSMutableArray *tempDateS = [[NSMutableArray alloc] init];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM"];
//    NSDate *fromDate = [formatter dateFromString:fromDateStr];
//    CGFloat monthNum = 0;
//    NSString *tempDateStr = fromDateStr;
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    while (![tempDateStr isEqualToString: toDateStr]) {
//        [comps setMonth:monthNum];
//        NSDate *dateTime = [calendar dateByAddingComponents:comps toDate:fromDate options:0];
//        tempDateStr = [formatter stringFromDate:dateTime];
//        LYTimeModel *model = [[LYTimeModel alloc] init];
//        model.year = [tempDateStr substringToIndex:4];
//        model.month = [tempDateStr substringWithRange:NSMakeRange(5, 2)];
//        [tempDateS addObject:model];
//        monthNum ++;
//    }
//
//    return [tempDateS copy];
//
//}
//
//// 获取从某年开始往前往后推的几个月的所有年月
//+ (NSArray *)getDatesWithFromDateStr:(NSString *)fromDateStr  withNumberMonth:(NSInteger)numberMonth isContainBegin:(BOOL)isContainBegin{
//
//    NSMutableArray *tempDateS = [[NSMutableArray alloc] init];
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM"];
//    //设置时区
//    NSTimeZone* timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];//设置时区
//    [formatter setTimeZone:timeZone];
//    NSDate *fromDate = [formatter dateFromString:fromDateStr];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSTimeInterval time1970 = [fromDate timeIntervalSince1970];
//
//    NSUInteger numberOffDaysInMonth = 0;
//    //计算当月的所有的天数
//    for (NSInteger i= 0 ; i<numberMonth; i++) {
//        NSDate *dateTime = [NSDate dateWithTimeIntervalSince1970:time1970+(86400*numberOffDaysInMonth)];
//        [formatter stringFromDate:dateTime];
//        NSString *string = [NSString stringWithFormat:@"%@",dateTime];
//        LYTimeModel *model = [[LYTimeModel alloc] init];
//        model.year = [string substringToIndex:4];
//        model.month = [string substringWithRange:NSMakeRange(5, 2)];
//        [tempDateS addObject:model];
//        //计算当月的所有的天数
//        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dateTime];
//        NSInteger  CuurentNumberOffDaysInMonth = range.length;
//        numberOffDaysInMonth += CuurentNumberOffDaysInMonth;
//
//    }
//    if (isContainBegin == NO) {
//        [tempDateS removeObjectAtIndex:0];
//    }
//    return [tempDateS copy];
//}


/**
// 返回完整图片的url
//
// @param imageStr 图片的url
// */
//+ (NSString *)getImageUrlStrWithimageStr:(NSString *)imageStr{
//
//    NSString *tempImageStr = imageStr;
//
//    if ([tempImageStr hasPrefix:@"http"]) {
//        return tempImageStr;
//    }
//
//    tempImageStr  = [NSString stringWithFormat:@"%@/%@",webSide,tempImageStr];
//
//    return tempImageStr;
//}

/**
 获取分享类别集合
 
 @return 数组
 */
//+ (NSArray *)shareTypeList{
//    
//    NSMutableArray *temp = [NSMutableArray array];
//    
//    //是否安装了微信
//    if ([WXApi isWXAppInstalled]) {
//        [temp addObject:@{@"image":@"share_detail_wx",@"title":@"微信",@"type":@"wx"}];
//        [temp addObject:@{@"image":@"share_detail_wxp",@"title":@"朋友圈",@"type":@"wxp"}];
//    }
//    //微博网页可以分享
//    [temp addObject:@{@"image":@"share_detail_wb",@"title":@"微博",@"type":@"wb"}];
//    
//    //是否安装了qq
//    if ([TencentOAuth iphoneQQInstalled]) {
//        [temp addObject:@{@"image":@"share_detail_qq",@"title":@"QQ",@"type":@"qq"}];
//    }
//    return [temp copy];
//}


+ (NSString *)getNumberShowStatus:(NSInteger)tempNumber{
    
    NSString *tempStr = [NSString stringWithFormat:@"%ld",(long)tempNumber];
    
    if (tempStr.length <= 3) {
        return tempStr;
    }
    
    NSInteger leftNumber = tempStr.length % 3;
    
    NSInteger number = tempStr.length / 3;
    if (leftNumber > 0) {
        number ++ ;
    }
    
    if (leftNumber > 0 ) {
        NSString *addString = [@"000" substringFromIndex:leftNumber];
        tempStr = [tempStr stringByReplacingCharactersInRange:NSMakeRange(0, 0) withString:addString];
    }
   
    NSMutableArray *tempArray  = [NSMutableArray array];
    for (int i = 0; i<number; i++) {
        NSString *tempArrayStr = [tempStr substringWithRange:NSMakeRange(i*3, 3)];
        [tempArray addObject:tempArrayStr];
    }
    
    if (leftNumber > 0) {
        return [[tempArray componentsJoinedByString:@","] stringByReplacingCharactersInRange:NSMakeRange(0, 3-leftNumber) withString:@""];
    }
    return [tempArray componentsJoinedByString:@","];
    
    
}


//+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width WithLabel:(UILabel *)label{
//
//    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
//
//    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
//
//    paraStyle.alignment = NSTextAlignmentLeft;
//
//    paraStyle.lineSpacing = KPT_SCAlE(5);
//
//    paraStyle.hyphenationFactor = 1.0;
//
//    paraStyle.firstLineHeadIndent = 0.0;
//
//    paraStyle.paragraphSpacingBefore = 0.0;
//
//    paraStyle.headIndent = 0;
//
//    paraStyle.tailIndent = 0;
//
//    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
//                          };
//
//    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
//
//    label.attributedText = attributeStr;
//
//    CGSize size = [str boundingRectWithSize:CGSizeMake(width, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
//
//    return size.height;
//
//}


@end
