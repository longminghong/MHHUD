//
//  MHHud.m
//  MHHud
//
//  Created by longminghong on 16/9/30.
//  Copyright © 2016年 longminghong. All rights reserved.
//

#import "MHHUD.h"

#define UISCREEN_BOUNDS [UIScreen mainScreen].bounds

#define UISCREEN_BOUNDS_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)

NSTimeInterval const defaultDelayTimeInterval = 0.1;
NSTimeInterval const defaultAnimationTimeInterval = 0.2;

CGFloat const defaultContentViewHeigh = 40.0f;
CGFloat const defaultButtonsHeigh = 36.0f;

CGFloat const defaultContentViewMarginWithSuperView = 100.0f;
CGFloat const defaultContentViewMarginTop = 10.0f;
CGFloat const defaultContentViewMarginBottom = 10.0f;

CGFloat const MHHUD_TITLELABEL_PADDING_TOP = 5.0f;
CGFloat const MHHUD_TITLELABEL_PADDING_LEFT_AND_RIGHT = 5.0f;

CGFloat const MHHUD_BUTTONS_PADDING_TOP = 5.0f;
CGFloat const MHHUD_BUTTONS_PADDING_BOTTOM = 5.0f;
CGFloat const MHHUD_BUTTONS_PADDING_LEFT_AND_RIGHT = 5.0f;


@interface MHHUD(){
    
    MHHUDAnimationDirection animationDirection_;
    MHHUDAnimationPosition animationPosition_;
    
    MHHUDBackgroundStyle backgroundStyle_;
    
    MHBackgroundView *backgroundView_;
    UIView *containerView_;
    
    UIView *contentView_;
    
    NSTimeInterval delayTimeInterval;
    NSTimeInterval animationTimeInterval;
    
    CGFloat contentViewMarginWithSuperView;
    CGFloat contentViewHeigh;
    
    CGFloat contentViewMarginTop;
    CGFloat contentViewMarginBottom;
    
    UIButton *confirmButton_;
    UIButton *cancelButton_;
    
    UIColor *backgroundColor_;
    
    UIFont *titleFont_;
}

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) MHBackgroundView *backgroundView;
@property (nonatomic,strong) UIView *containerView;

@end

@implementation MHHUD

@synthesize contentView = contentView_;
@synthesize titleLabel = titleLabel_;
@synthesize detailsLabel = detailsLabel_;
@synthesize backgroundView = backgroundView_;
@synthesize containerView = containerView_;

#pragma mark -
#pragma mark properties


- (UIView *)containerView{
    
    if (nil == containerView_) {
        
        containerView_ = [[UIView alloc] initWithFrame:self.bounds];
        
        containerView_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        containerView_.backgroundColor = [UIColor clearColor];
        
        containerView_.alpha = 1.0f;
        
        [self bringSubviewToFront:containerView_];
        
        [self addSubview:containerView_];
    }
    
    return containerView_;
}

- (MHBackgroundView *)backgroundView{
    
    if (nil == backgroundView_) {
        
        backgroundView_ = [[MHBackgroundView alloc] initWithFrame:self.bounds];
        
        backgroundView_.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:backgroundView_];
    }
    
    return backgroundView_;
}

- (UIView *)contentView{
    
    if (nil == contentView_) {
        
        contentView_ = [[UIView alloc]initWithFrame:self.frame];
        
        contentView_.backgroundColor = [UIColor blackColor];
        
        contentView_.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.containerView addSubview:contentView_];
        
        [self bringSubviewToFront:self.containerView];
    }
    return contentView_;
}

- (UILabel *)titleLabel{
    
    if (nil == titleLabel_) {
        
        titleLabel_ = [self UILabelFactory];
        [titleLabel_ setFont:titleFont_];
        
        [self.contentView addSubview:titleLabel_];
    }
    return titleLabel_;
}


- (UILabel *)UILabelFactory{
    
    UILabel *resultValue;
    
    resultValue = [[UILabel alloc]init];
    
    resultValue.adjustsFontSizeToFitWidth = NO;
    
    resultValue.textAlignment = NSTextAlignmentCenter;
    
    resultValue.textColor = [UIColor whiteColor];
    
    resultValue.opaque = NO;
    
    resultValue.lineBreakMode = NSLineBreakByCharWrapping;
    
    resultValue.backgroundColor = [UIColor clearColor];
    
    resultValue.numberOfLines = 0;
    
    [resultValue.layer setMasksToBounds:YES];
    [resultValue.layer setBorderColor:[UIColor whiteColor].CGColor];
    [resultValue.layer setBorderWidth:1.0f];
    
    resultValue.translatesAutoresizingMaskIntoConstraints = NO;
    
    [resultValue setContentCompressionResistancePriority:998.f forAxis:UILayoutConstraintAxisHorizontal];
    
    [resultValue setContentCompressionResistancePriority:998.f forAxis:UILayoutConstraintAxisVertical];
    
    return resultValue;
}

- (UIButton *)UIButtonFactory{
    
    UIButton *resultValue;
    
    resultValue = [[UIButton alloc]initWithFrame:CGRectZero];
    
    resultValue.opaque = NO;
    
    [resultValue setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [resultValue.layer setMasksToBounds:YES];
    [resultValue.layer setBorderColor:[UIColor whiteColor].CGColor];
    [resultValue.layer setBorderWidth:1.0f];
    
    resultValue.translatesAutoresizingMaskIntoConstraints = NO;
    
    [resultValue setContentCompressionResistancePriority:998.f forAxis:UILayoutConstraintAxisHorizontal];
    
    [resultValue setContentCompressionResistancePriority:998.f forAxis:UILayoutConstraintAxisVertical];
    
    return resultValue;
}
#pragma mark -
#pragma mark

+ (instancetype)initMMHUD{

    MHHUD *hud = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    return hud;
}

+ (instancetype)initWithTitle:(NSString *)title{
    
    MHHUD *hud = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    if (title) {
        
        [hud setMHHUDTitle:title];
    }
    
    return hud;
}


- (void)defaultInitial{
    
    backgroundStyle_ = MHHUDBackgroundStyleBlur;
    
    animationDirection_ = MHHUDAnimationDirectionFromLeft;
    
    delayTimeInterval = defaultDelayTimeInterval;
    animationTimeInterval = defaultAnimationTimeInterval;
    
    contentViewMarginWithSuperView = defaultContentViewMarginWithSuperView;
    contentViewHeigh = defaultContentViewHeigh;
    
    animationPosition_ = MHHUDAnimationPositionMiddle;
    
    contentViewMarginTop = defaultContentViewMarginTop;
    contentViewMarginBottom = defaultContentViewMarginBottom;
    
    titleFont_ = [UIFont systemFontOfSize:14];
    
    backgroundColor_ = [UIColor redColor];
    
    [self initSubViews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self defaultInitial];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder])) {
        
        [self defaultInitial];
    }
    return self;
}

- (void)dealloc {
    
}

- (void)initSubViews{
    
    [self.backgroundView setColor:[UIColor clearColor]];
    
    if (title_) {
        
        [self.titleLabel setText:title_];
    }
    
    confirmButton_ = [self UIButtonFactory];
    cancelButton_ = [self UIButtonFactory];
    
    [confirmButton_ setTitle:@"确认" forState:UIControlStateNormal];
    [cancelButton_ setTitle:@"取消" forState:UIControlStateNormal];
    
    [confirmButton_ addTarget:self action:@selector(confirmButtonClick:)
             forControlEvents:UIControlEventTouchUpInside];
    [cancelButton_ addTarget:self action:@selector(cancelButtonClick:)
            forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:confirmButton_];
    [self.contentView addSubview:cancelButton_];
}

#pragma mark -
#pragma mark attribute setting

#pragma mark title attribute setting
- (void)setMHHUDTitle:(NSString *)value{

    title_ = value;
    
    self.titleLabel.text = title_;
    
    [self setNeedsUpdateConstraints];
}

- (void)setMHHUDTitleFont:(UIFont *)value{

    if (value && ![value isEqual:titleFont_]) {
        
        titleFont_ = value;
        
        [self.titleLabel setFont:value];
        
        [self setNeedsUpdateConstraints];
    }
}

#pragma mark animation time interval attribute setting
- (void)setMHHUDDelayTimeInterval:(NSTimeInterval)value{

    delayTimeInterval = value;
}
- (void)setMHHUDAnimationTimeInterval:(NSTimeInterval)value{
    
    animationTimeInterval = value;
}

#pragma mark margin with leading edge
/**
 *  if the the hud animation from left to right, zhe leading edge is the right edge.
 *  so , if the animation from right to left, zhe leading edge is the left edge.
 */
- (void)setMHHUDContentViewMarginWithSuperView:(CGFloat)value{
    
    contentViewMarginWithSuperView = value;
    
    [self setNeedsUpdateConstraints];
}

- (void)setMHHUDContentViewHeigh:(CGFloat)value{
    
    contentViewHeigh = value;
    
    [self setNeedsUpdateConstraints];
}

#pragma mark direction and position setting
- (void)setMHHUDAnimationDirection:(MHHUDAnimationDirection)direction{
    
    animationDirection_ = direction;
    
    [self setNeedsUpdateConstraints];
}

- (void)setMHHUDAnimationPosition:(MHHUDAnimationPosition)position{

    animationPosition_ = position;
    
    [self setNeedsUpdateConstraints];
}

#pragma mark direction and position setting

- (void)setMHHUDBackgroundStyle:(MHHUDBackgroundStyle)style{

    backgroundStyle_ = style;
    
    [self.backgroundView setStyle:backgroundStyle_];
}

- (void)setMHHUDBackgroundBlur:(UIBlurEffectStyle)effect alpah:(CGFloat)alpha{

    [self setMHHUDBackgroundStyle:MHHUDBackgroundStyleBlur];
    self.backgroundView.blurEffectLevel = effect;
    self.backgroundView.blurAlpha = alpha;
}

- (void)setMHHUDBackgroundColor:(UIColor *)color{

    backgroundColor_ = color;
    
    [self.backgroundView setColor:backgroundColor_];
}

- (void)setMHHUDMarginTopSpace:(CGFloat)value{

    contentViewMarginTop = value;
    
    [self setNeedsUpdateConstraints];
}

- (void)setMHHUDMarginBottomSpace:(CGFloat)value{

    contentViewMarginBottom = value;
    
    [self setNeedsUpdateConstraints];
}


- (void)confirmButtonClick:(UIButton *)sender{
    
    [self dismiss];
}

- (void)cancelButtonClick:(UIButton *)sender{
    
    [self dismiss];
}

- (CGPoint)initialContentViewCenter{
    
    CGPoint point;
    
    CGFloat contentviewWidth = [self getContentViewWidth];
    
    if (MHHUDAnimationDirectionFromLeft == animationDirection_) {
        
        point = CGPointMake(contentviewWidth/2, contentView_.center.y);
        
    }else{
        
        point = CGPointMake(contentViewMarginWithSuperView+contentviewWidth, contentView_.center.y);
    }
    
    return point;
}

- (CGPoint)dismissContentViewCenter{
    
    CGPoint point;
    
    CGFloat contentviewWidth = [self getContentViewWidth];
    
    if (MHHUDAnimationDirectionFromLeft == animationDirection_) {
        
        point = CGPointMake(-contentviewWidth/2, contentView_.center.y);
    }else{
        
        point = CGPointMake(UISCREEN_BOUNDS_WIDTH+contentviewWidth, contentView_.center.y);
    }
    
    return point;
}

- (CGFloat)getContentViewWidth{

    return UISCREEN_BOUNDS_WIDTH - contentViewMarginWithSuperView;
}



#pragma mark -
#pragma mark show and dismiss

- (void)display{
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    
    CGPoint point = [self dismissContentViewCenter];
    
    contentView_.center = point;
    
    [UIView animateWithDuration:animationTimeInterval delay:delayTimeInterval options:UIViewAnimationOptionOverrideInheritedOptions animations:^{
        
        contentView_.center = [self initialContentViewCenter];
        
    } completion:^(BOOL finished) {
        
        
    }];
}

- (void)dismiss{
    
    [UIView animateWithDuration:animationTimeInterval delay:delayTimeInterval options:UIViewAnimationOptionOverrideInheritedOptions animations:^{
        
        contentView_.center = [self dismissContentViewCenter];
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

#pragma mark -
#pragma mark - constraints

- (void)updateConstraints {
  
#pragma content view constraints
    
    /**
     *  content view width
     */
    CGFloat contentViewWidth = [self getContentViewWidth];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:contentView_
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1
                                                      constant:contentViewWidth]];
    
    /**
     *  content view heigh
     */
    [self addConstraint:[NSLayoutConstraint constraintWithItem:contentView_
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1
                                                      constant:contentViewHeigh]];
    
    NSString *constraintsValue;
    NSArray *constraints;
    NSDictionary *metrics;
    
    if (MHHUDAnimationPositionTop == animationPosition_) {
        
        metrics = @{@"margin_top":[NSNumber numberWithFloat:contentViewMarginTop]};
        
        constraintsValue = [NSString stringWithFormat:@"V:|-margin_top-[contentView_]"];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:constraintsValue
                                                                          options:0
                                                                          metrics:metrics
                                                                            views:NSDictionaryOfVariableBindings(contentView_)];
        
        [self addConstraints:constraints];
        
    }else if (MHHUDAnimationPositionMiddle == animationPosition_){
        
        /**
         *  content view location to centerY
         */
        [self addConstraint:[NSLayoutConstraint constraintWithItem:contentView_
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0]];
    }else if (MHHUDAnimationPositionBottom == animationPosition_){
        
        metrics = @{@"margin_bottom":[NSNumber numberWithFloat:contentViewMarginBottom]};
        
        constraintsValue = [NSString stringWithFormat:@"V:[contentView_]-(margin_bottom)-|"];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:constraintsValue
                                                                          options:0
                                                                          metrics:metrics
                                                                            views:NSDictionaryOfVariableBindings(contentView_)];
        
        [self addConstraints:constraints];
    }
    /**
     *  layout leading edge of content view
     */
    if (MHHUDAnimationDirectionFromLeft == animationDirection_) {
        constraintsValue = [NSString stringWithFormat:@"H:|-0-[contentView_]-|"];
    }else{
        constraintsValue = [NSString stringWithFormat:@"H:|-[contentView_]-0-|"];
    }
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:constraintsValue
                                                          options:0
                                                          metrics:nil
                                                            views:NSDictionaryOfVariableBindings(contentView_)];
    
    [self addConstraints:constraints];
    /**
     *  subviews in content view.
     */
    
    NSDictionary *subviews;
    
    if (titleLabel_) {
        
        subviews = NSDictionaryOfVariableBindings(titleLabel_,confirmButton_,cancelButton_,contentView_);
        
    }else{
        subviews = NSDictionaryOfVariableBindings(confirmButton_,cancelButton_,contentView_);
    }
    
    NSString *subviewConstraints;
    
    if (MHHUDAnimationDirectionFromLeft == animationDirection_) {
        
    }else if (MHHUDAnimationDirectionFromRight == animationDirection_){
        
        
    }
    
    /**
     *  title label constraints
     */
    if (titleLabel_) {
        /**
         *  title label horizontal
         */
        metrics = @{@"paddingLeftAndRight":[NSNumber numberWithFloat:MHHUD_TITLELABEL_PADDING_LEFT_AND_RIGHT]};
        subviewConstraints = [NSString stringWithFormat:@"H:|-paddingLeftAndRight-[titleLabel_]-paddingLeftAndRight-|"];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:subviewConstraints options:0 metrics:metrics views:subviews];
        [contentView_ addConstraints:constraints];
        
        /**
         *  title label top
         */
        metrics = @{@"paddingTop":[NSNumber numberWithFloat:MHHUD_TITLELABEL_PADDING_TOP]};
        subviewConstraints = [NSString stringWithFormat:@"V:|-paddingTop-[titleLabel_]"];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:subviewConstraints options:0 metrics:metrics views:subviews];
        [contentView_ addConstraints:constraints];
        
        
        subviewConstraints = [NSString stringWithFormat:@"V:[titleLabel_(>=21)]"];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:subviewConstraints options:0 metrics:nil views:subviews];
        [contentView_ addConstraints:constraints];
        
    }
    
    /**
     *  buttons constraints
     */
    
    metrics = @{@"buttonLeading":[NSNumber numberWithFloat:MHHUD_BUTTONS_PADDING_LEFT_AND_RIGHT],
                @"buttonTrailing":[NSNumber numberWithFloat:MHHUD_BUTTONS_PADDING_LEFT_AND_RIGHT],
                @"buttonTop":[NSNumber numberWithFloat:MHHUD_BUTTONS_PADDING_TOP],
                @"buttonBottom":[NSNumber numberWithFloat:MHHUD_BUTTONS_PADDING_BOTTOM]
                };
    
    if (titleLabel_) {
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel_]-buttonTop-[confirmButton_]" options:0 metrics:metrics views:subviews];
        [contentView_ addConstraints:constraints];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel_]-buttonTop-[cancelButton_]" options:0 metrics:metrics views:subviews];
        [contentView_ addConstraints:constraints];
        
    }else{
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-buttonTop-[confirmButton_]" options:0 metrics:metrics views:subviews];
        [contentView_ addConstraints:constraints];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-buttonTop-[cancelButton_]" options:0 metrics:metrics views:subviews];
        [contentView_ addConstraints:constraints];
    }
    
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-buttonLeading-[confirmButton_][cancelButton_(confirmButton_)]-buttonTrailing-|" options:0 metrics:metrics views:subviews];
    [contentView_ addConstraints:constraints];
    
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[confirmButton_]-buttonBottom-|" options:NSLayoutFormatAlignAllLastBaseline metrics:metrics views:subviews];
    [contentView_ addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[cancelButton_]-buttonBottom-|" options:NSLayoutFormatAlignAllLastBaseline metrics:metrics views:subviews];
    [contentView_ addConstraints:constraints];
    
    [super updateConstraints];
}


- (void)layoutSubviews {
    // There is no need to update constraints if they are going to
    // be recreated in [super layoutSubviews] due to needsUpdateConstraints being set.
    // This also avoids an issue on iOS 8, where updatePaddingConstraints
    // would trigger a zombie object access.
    if (!self.needsUpdateConstraints) {
        
    }
    [super layoutSubviews];
}


- (void)applyPriority:(UILayoutPriority)priority toConstraints:(NSArray *)constraints {
    for (NSLayoutConstraint *constraint in constraints) {
        constraint.priority = priority;
    }
}

@end



@interface MHBackgroundView()

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
@property UIVisualEffectView *effectView;
#endif

@end

@implementation MHBackgroundView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
    
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_7_0) {
            
            _style = MHHUDBackgroundStyleBlur;
            
            if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
                
                _color = [UIColor colorWithWhite:0.9f alpha:0.6f];
            } else {
                _color = [UIColor colorWithWhite:0.95f alpha:0.6f];
            }
        } else {
            _color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        }
        _blurAlpha = 1.0f;
        self.blurEffectLevel = UIBlurEffectStyleExtraLight;
        
        self.clipsToBounds = YES;
        
        [self updateBackgroundForStyleChange];
    }
    return self;
}

#pragma mark - Layout

- (CGSize)intrinsicContentSize {
    // Smallest size possible. Content pushes against this.
    return CGSizeZero;
}


- (void)setStyle:(MHHUDBackgroundStyle)style {
    
    if (style == MHHUDBackgroundStyleBlur && kCFCoreFoundationVersionNumber < kCFCoreFoundationVersionNumber_iOS_7_0) {
        style = MHHUDBackgroundStyleSolidColor;
    }
    if (_style != style) {
        _style = style;
        [self updateBackgroundForStyleChange];
    }
}

- (void)setColor:(UIColor *)color {
    NSAssert(color, @"The color should not be nil.");
    if (color != _color && ![color isEqual:_color]) {
        _color = color;
        [self updateViewsForColor:color];
    }
}

- (void)setBlurAlpha:(CGFloat)blurAlpha{
    
    if (_blurAlpha != blurAlpha) {
     
        _blurAlpha = blurAlpha;
        
        [self updateBackgroundForStyleChange];
    }
}

- (void)updateBackgroundForStyleChange {
    
    MHHUDBackgroundStyle style = self.style;
    if (style == MHHUDBackgroundStyleBlur) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
            
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:self.blurEffectLevel];
            
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            
            [self addSubview:effectView];
            
            effectView.frame = self.bounds;
            
            effectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            
            self.backgroundColor = self.color;
            
            self.alpha = self.blurAlpha;
            
            self.layer.allowsGroupOpacity = NO;
            
            self.effectView = effectView;
        }
#endif
            
    } else {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
            [self.effectView removeFromSuperview];
            self.effectView = nil;
        }
#endif
        if (MHHUDBackgroundStyleTransparent == self.style) {
            
            self.backgroundColor = [UIColor clearColor];
        }else{
            
            self.backgroundColor = self.color;
        }
    }
}

- (void)updateViewsForColor:(UIColor *)color {
    
    if (self.style == MHHUDBackgroundStyleBlur) {
    
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
        
            self.backgroundColor = self.color;
        }
    } else {
    
        self.backgroundColor = self.color;
    }
    
    [self updateBackgroundForStyleChange];
}


@end