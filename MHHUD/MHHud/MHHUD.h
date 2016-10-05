//
//  MHHud.h
//  MHHud
//
//  Created by longminghong on 16/9/30.
//  Copyright © 2016年 longminghong. All rights reserved.
//

#import <UIKit/UIKit.h>


#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);


typedef NS_ENUM(NSInteger, MHHUDBackgroundStyle) {
    
    MHHUDBackgroundStyleTransparent,
    
    MHHUDBackgroundStyleSolidColor,
    
    MHHUDBackgroundStyleBlur,
};

typedef NS_ENUM(NSInteger, MHHUDAnimationDirection) {
    
    MHHUDAnimationDirectionFromLeft,
    
    MHHUDAnimationDirectionFromRight,
};

typedef NS_ENUM(NSInteger, MHHUDAnimationPosition) {
    
    MHHUDAnimationPositionTop,
    
    MHHUDAnimationPositionMiddle,
    
    MHHUDAnimationPositionBottom,
};


typedef void (^MHHUDConfirmButtonClick)(void);
typedef void (^MHHUDCancelButtonClick)();

typedef void (^MHHUDBeforeAnimationBlock)();
typedef void (^MHHUDBeginAnimationBlock)();
typedef void (^MHHUDEndAnimationBlock)();




NS_ASSUME_NONNULL_BEGIN

@interface MHHUD : UIView{

    @public
    
    NSString *title_;
    NSString *message_;
    
    @private
    UILabel *titleLabel_;
    UILabel *detailsLabel_;
}

@property (strong, nonatomic, readonly) UILabel *titleLabel;
@property (strong, nonatomic, readonly) UILabel *detailsLabel;

@property (copy, nullable) MHHUDConfirmButtonClick confirmButtonClickBlock;
@property (copy, nullable) MHHUDCancelButtonClick cancelButtonClickBlock;

@property (copy, nullable) MHHUDBeforeAnimationBlock beforeAnimationBlock;
@property (copy, nullable) MHHUDBeginAnimationBlock beginAnimationBlock;
@property (copy, nullable) MHHUDEndAnimationBlock endAnimationBlock;

+ (instancetype)initMMHUD;

+ (instancetype)initWithTitle:(NSString *)title;

- (void)display;

- (void)dismiss;

/**
 *  title text and font setting.
 */
- (void)setMHHUDTitle:(NSString *)value;
- (void)setMHHUDTitleFont:(UIFont *)value;

/**
 *  animation time interval setting
 */
- (void)setMHHUDDelayTimeInterval:(NSTimeInterval)value;
- (void)setMHHUDAnimationTimeInterval:(NSTimeInterval)value;

/**
 *  if the the hud animation from left to right, zhe leading edge is the right edge.
 *  so , if the animation from right to left, zhe leading edge is the left edge.
 */
- (void)setMHHUDContentViewMarginWithSuperView:(CGFloat)value;
/**
 *  content view contain the title and the buttons
 *  by default, the content view is 40.0f.
 *  but, the content view can layout by it self.
 */
- (void)setMHHUDContentViewHeigh:(CGFloat)value;

/**
 *  direction and the position you can change it.
 */
- (void)setMHHUDAnimationDirection:(MHHUDAnimationDirection)direction;
- (void)setMHHUDAnimationPosition:(MHHUDAnimationPosition)position;

/**
 *  3 background style can be set.
 *  clear color.
 *  sold color.
 *  blur.
 */
- (void)setMHHUDBackgroundStyle:(MHHUDBackgroundStyle)style;

- (void)setMHHUDBackgroundBlur:(UIBlurEffectStyle)effect alpah:(CGFloat)alpha;

- (void)setMHHUDBackgroundColor:(UIColor *)color;
/**
 *  在MHHUDAnimationPositionTop模式下,设置与windows顶部的距离
 *
 *  @param value margin Space,default is 10.0f.
 */
- (void)setMHHUDMarginTopSpace:(CGFloat)value;

/**
 *  在MHHUDAnimationPositionBottom模式下,设置与windows底部的距离
 *
 *  @param value margin Space,default is 10.0f.
 */
- (void)setMHHUDMarginBottomSpace:(CGFloat)value;
@end

@interface MHBackgroundView : UIView

@property (nonatomic) MHHUDBackgroundStyle style;

@property (nonatomic) UIBlurEffectStyle blurEffectLevel;

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, assign) CGFloat blurAlpha;

@end

NS_ASSUME_NONNULL_END