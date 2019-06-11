//
//  ViewController.m
//  LayerDemo
//
//  Created by yuqian on 2019/6/10.
//  Copyright © 2019 yuqian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,weak) IBOutlet UIImageView *maskView; //底层视图
@property (nonatomic,strong) UIImageView *fdjView;  //放大镜图片
@property (nonatomic,strong) CALayer *maskLayer;   //蒙板图层

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.fdjView = [[UIImageView alloc] init];
    [self.fdjView setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.5f - 50.0f, [UIScreen mainScreen].bounds.size.height*0.5f - 50.0f, 80.0f, 80.0f)];
    [self.fdjView setImage:[UIImage imageNamed:@"fangdajing"]];
    [self.view addSubview:self.fdjView];
    
    self.maskLayer = [[CALayer alloc] init];
    [self.maskLayer setFrame:CGRectMake(30, 30, 56, 56)];
    [_maskLayer setBackgroundColor:[UIColor redColor].CGColor];
    [_maskLayer setCornerRadius:28.0f];
    self.maskView.layer.mask = _maskLayer;
    
    [self animationBegin];
}

- (void)animationBegin{
    CAKeyframeAnimation *fdjKeyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [fdjKeyAnimation setValues:@[
                                 [NSValue valueWithCGRect:CGRectMake(self.fdjView.frame.origin.x, self.fdjView.frame.origin.y, self.fdjView.frame.size.width, self.fdjView.frame.size.height)],
                                 [NSValue valueWithCGRect:CGRectMake(self.fdjView.frame.origin.x, self.fdjView.frame.origin.y + 100, self.fdjView.frame.size.width, self.fdjView.frame.size.height)],
                                 [NSValue valueWithCGRect:CGRectMake(self.fdjView.frame.origin.x + 100, self.fdjView.frame.origin.y + 100, self.fdjView.frame.size.width, self.fdjView.frame.size.height)],
                                 [NSValue valueWithCGRect:CGRectMake(self.fdjView.frame.origin.x + 100, self.fdjView.frame.origin.y, self.fdjView.frame.size.width, self.fdjView.frame.size.height)],
                                 [NSValue valueWithCGRect:CGRectMake(self.fdjView.frame.origin.x, self.fdjView.frame.origin.y, self.fdjView.frame.size.width, self.fdjView.frame.size.height)]]];
    [fdjKeyAnimation setKeyTimes:@[@0.0,@0.25,@0.5,@0.75,@1.0]];
    [fdjKeyAnimation setRepeatCount:HUGE_VALF];
    [fdjKeyAnimation setDuration:4.0f];
    [fdjKeyAnimation setAutoreverses:false];
    [fdjKeyAnimation setCalculationMode:kCAAnimationLinear];
    [self.fdjView.layer addAnimation:fdjKeyAnimation forKey:@"fdjPosition"];
    
    CAKeyframeAnimation *keysAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [keysAnimation setValues:@[[NSValue valueWithCGRect:CGRectMake(30, 30, 56, 56)],[NSValue valueWithCGRect:CGRectMake(30, 130, 56, 56)],[NSValue valueWithCGRect:CGRectMake(130, 130, 56, 56)],[NSValue valueWithCGRect:CGRectMake(130, 30, 56, 56)],[NSValue valueWithCGRect:CGRectMake(30, 30, 56, 56)]]];
    [keysAnimation setKeyTimes:@[@0.0,@0.25,@0.5,@0.75,@1.0]];
    [keysAnimation setRepeatCount:HUGE_VALF];
    [keysAnimation setDuration:4.0f];
    [keysAnimation setAutoreverses:false];
    [keysAnimation setCalculationMode:kCAAnimationLinear];
    [self.maskLayer addAnimation:keysAnimation forKey:@"position"];
}

@end
