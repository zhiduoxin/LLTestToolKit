//
//  LYTool.h
//  159qiuxing
//
//  Created by lx on 2017/9/29.
//  Copyright © 2017年 lx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface LYTool : NSObject

+ (LYTool *)shareLYTool;

/*
*  @return 缓存的大小, 单位MB, 2.00M
*/
+ (NSString *)getCachesSize;

/**
 *  清理缓存
 */
- (void)clearCacheSuccess:(void (^)(void))success;


//颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor*)colorWithHexString:(NSString*)color;



//获取字符串的宽度
+ (CGFloat) getWidthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height;
//带有字体的类型
+ (CGFloat) getWidthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height fontStyle:(NSString *)fontstyle;

//获取字符串的高度
+ (CGFloat) getHeightForString:(NSString *)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width;
//带有字体的类型
+ (CGFloat) getHeightForString:(NSString *)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width fontStyle:(NSString *)fontstyle;



// 改变字符串中的某个字符串的颜色
+ (NSAttributedString *)willBecomeColorNeedStringOfAllString:(NSString *)allString needBecomeString:(NSString *)becomeString needColor:(UIColor *)color needFont:(UIFont *)font;

//网络加载动画显示隐藏
+ (void)showMBProgressHUDView:(UIView *)view;
+ (void)hidenMBProgressHUDView:(UIView *)view;

//提示弹框
+ (void)showToastViewTimeToHiden:(NSString *)toastStr;

//判断网络状况
+(BOOL) isConnectionAvailable;

//带有多个按钮的提示框
+(void)showToastViewCancelAndSendButtonWithTitle:(NSString *)title buttonsList:(NSArray *)array target:(id)target onCliclk:(void(^)(NSInteger index))onCliclkButtonIndex;


//创建底部的footerView
+ (UIView *)creatTableViewFooterView:(NSString *)titleStr;

//图片 压 缩 到指定大小
+ (NSData *)imageByScalingAndCroppingForSize:(CGSize)targetSize withImage:(UIImage *)image;

//分享的界面的展示
+ (void)showShareViewToSupviewWithFrame:(CGRect)frame WithList:(NSArray *)list delegate:(id)delegate;

//保留两位小数的方法
+ (NSString *)getValueStr:(NSString *)valueStr;

/**
 签到展示

 @param level 签到排名
 @param levelStr 签到的积分
 @param target self
 @param isShowTitle 是否有标题
 */
+ (void)showSignAlterViewWithLevel:(int)level levelStr:(NSString *)levelStr target:(id)target isShowTitle:(BOOL)isShowTitle;

/**
 获取某年某月到某年某月的之间的所有年月

 @param fromDateStr 开始的年月
 @param toDateStr 结束的年月
 @return 中间的年月的集合
 */
+ (NSArray *)getDatesWithFromDateStr:(NSString *)fromDateStr  withToDateStr:(NSString *)toDateStr;

/**
 获取从某年开始往前往后推的几个月的所有年月

 @param fromDateStr 开始年月
 @param numberMonth 往前或者往后几个月
 @return 返回年月的数组
 */
+ (NSArray *)getDatesWithFromDateStr:(NSString *)fromDateStr  withNumberMonth:(NSInteger)numberMonth isContainBegin:(BOOL)isContainBegin;


/**
 弹出框的提示
 
 @param title 标题
 @param message 内容
 @param completeBlock 点击回掉
 */
+ (void)showAlterViewWithTitle:(NSString *)title message:(NSString *)message completeBlock:(void(^)(NSInteger index))completeBlock;


/**
 返回完整图片的url

 @param imageStr 图片的url
 */
+ (NSString *)getImageUrlStrWithimageStr:(NSString *)imageStr;


/**
 获取分享类别集合
 
 @return 数组
 */
+ (NSArray *)shareTypeList;


/**
 修改数据的显示风格 带逗号的例如 12344改成 1,2344显示
 @param tempNumber 数据
 @return 返回字符串
 */
+ (NSString *)getNumberShowStatus:(NSInteger)tempNumber;


/**
 设置行间距的计算label的高度和赋值

 @param str 字符串
 @param font 字体
 @param width 宽度
 @param label label
 @return 高度
 */
+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width WithLabel:(UILabel *)label;
@end
