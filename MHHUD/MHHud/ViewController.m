
//
//  ViewController.m
//  MHHud
//
//  Created by longminghong on 16/9/30.
//  Copyright © 2016年 longminghong. All rights reserved.
//

#import "ViewController.h"

#import "MHHUD.h"

typedef NS_ENUM(NSInteger, MHHUDSection){
    MHHUDSectionDirection,
    MHHUDSectionPosition,
    MHHUDSectionBackgroundStyle,
};

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{

    CGFloat headerViewHeigh;
    
    MHHUDAnimationDirection direction;
    
    MHHUDAnimationPosition position;
    
    MHHUDBackgroundStyle backgroundStyle;
    
    MHHUD *hud;
    

}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    headerViewHeigh = 40;
    
    direction = MHHUDAnimationDirectionFromLeft;
    position = MHHUDAnimationPositionMiddle;
    
    backgroundStyle = MHHUDBackgroundStyleTransparent;

}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClick:(UIButton *)sender {
    
    hud = [MHHUD initMMHUD];
    
    [hud setMHHUDAnimationDirection:direction];
    
    [hud setMHHUDAnimationPosition:position];
    
    [hud setMHHUDTitleFont:[UIFont systemFontOfSize:14.0f]];
    
    [hud setMHHUDTitle:@"Alert\nThis is a alert"];
    
    if (MHHUDBackgroundStyleBlur == backgroundStyle) {
        
        [hud setMHHUDBackgroundBlur:UIBlurEffectStyleExtraLight alpah:0.2f];
        
    }else{
        
        [hud setMHHUDBackgroundStyle:backgroundStyle];
    }
    
    hud.confirmButtonClickBlock = ^(void){
        
        DLog();
    };
    
    hud.cancelButtonClickBlock = ^(void){
        
        DLog();
    };
    
    hud.beforeAnimationBlock = ^(void){
        
        DLog();
    };
    
    hud.beginAnimationBlock = ^(void){
        
        DLog();
    };
    
    hud.endAnimationBlock = ^(void){
        
        DLog();
    };
    
    [hud display];
}

#pragma mark -
#pragma mark UITableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSInteger numberOfRowsInSection;
    
    switch (section) {
        case MHHUDSectionDirection:
            numberOfRowsInSection = 2;
            break;
        case MHHUDSectionPosition:
            numberOfRowsInSection = 3;
            break;
            case MHHUDSectionBackgroundStyle:
            numberOfRowsInSection = 3;
            break;
        default:
            break;
    }
    
    return numberOfRowsInSection;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 36;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return headerViewHeigh;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * headerView;
    
    headerView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), headerViewHeigh)];
    
    [headerView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    
    headerView.backgroundColor = [UIColor grayColor];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    
    if (0 == indexPath.section) {
        
        if (indexPath.row == MHHUDAnimationDirectionFromLeft) {
            
            [cell.textLabel setText:@"动画从左到右"];
            
            if(MHHUDAnimationDirectionFromLeft == direction)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [cell setAccessoryType:UITableViewCellAccessoryNone];
            
        }else if (indexPath.row == MHHUDAnimationDirectionFromRight){
        
            [cell.textLabel setText:@"动画从右到左"];
            
            if(MHHUDAnimationDirectionFromRight == direction)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [cell setAccessoryType:UITableViewCellAccessoryNone];
            
        }
        
    }else if (1 == indexPath.section){
    
        
        if (indexPath.row == MHHUDAnimationPositionTop) {
            
            [cell.textLabel setText:@"从顶部显示"];
            
            if(MHHUDAnimationPositionTop == position)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [cell setAccessoryType:UITableViewCellAccessoryNone];
            
        }else if (indexPath.row == MHHUDAnimationPositionMiddle){
            
            [cell.textLabel setText:@"从中间显示"];
            
            if(MHHUDAnimationPositionMiddle == position)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [cell setAccessoryType:UITableViewCellAccessoryNone];
            
        }else if (indexPath.row == MHHUDAnimationPositionBottom){
            
            [cell.textLabel setText:@"从底部显示"];
            
            if(MHHUDAnimationPositionBottom == position)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [cell setAccessoryType:UITableViewCellAccessoryNone];
            
        }
    }else if (2 == indexPath.section){
        
        
        if (indexPath.row == MHHUDBackgroundStyleTransparent) {
            
            [cell.textLabel setText:@"透明"];
            
            if(MHHUDBackgroundStyleTransparent == backgroundStyle)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [cell setAccessoryType:UITableViewCellAccessoryNone];
            
        }else if (indexPath.row == MHHUDBackgroundStyleSolidColor){
            
            [cell.textLabel setText:@"颜色"];
            
            if(MHHUDBackgroundStyleSolidColor == backgroundStyle)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [cell setAccessoryType:UITableViewCellAccessoryNone];
            
        }else if (indexPath.row == MHHUDBackgroundStyleBlur){
            
            [cell.textLabel setText:@"模糊"];
            
            if(MHHUDBackgroundStyleBlur == backgroundStyle)
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            else
                [cell setAccessoryType:UITableViewCellAccessoryNone];
            
        }
    }
    
    return cell;
}
#pragma mark -
#pragma mark UITableView datasource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (0 == indexPath.section) {
        
        if (indexPath.row == MHHUDAnimationDirectionFromLeft) {
            
            direction = MHHUDAnimationDirectionFromLeft;
            
        }else if (indexPath.row == MHHUDAnimationDirectionFromRight){
            
            direction = MHHUDAnimationDirectionFromRight;
            
        }
        
    }else if (1 == indexPath.section){
        
        if (indexPath.row == MHHUDAnimationPositionTop) {
            
            position = MHHUDAnimationPositionTop;
            
        }else if (indexPath.row == MHHUDAnimationPositionMiddle){
            
            position = MHHUDAnimationPositionMiddle;
            
        }else if (indexPath.row == MHHUDAnimationPositionBottom){
            
            position = MHHUDAnimationPositionBottom;
        }
    }else if (2 == indexPath.section){
        
        
        if (indexPath.row == MHHUDBackgroundStyleTransparent) {
            
            backgroundStyle = MHHUDBackgroundStyleTransparent;
            
        }else if (indexPath.row == MHHUDBackgroundStyleSolidColor){
            
            backgroundStyle = MHHUDBackgroundStyleSolidColor;
            
        }else if (indexPath.row == MHHUDBackgroundStyleBlur){
            
            backgroundStyle = MHHUDBackgroundStyleBlur;
            
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.tableView reloadData];
}

@end
