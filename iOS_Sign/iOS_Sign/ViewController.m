//
//  ViewController.m
//  iOS_Sign
//
//  Created by Ryan on 2019/2/28.
//  Copyright © 2019 Ryan. All rights reserved.
//

#import "ViewController.h"
#import "SignView.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@property (strong, nonatomic) UIImageView *signImageView;
@property (strong, nonatomic) SignView *signView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _signImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 200)/2, 100, 200, 100)];
    _signImageView.layer.borderColor = [UIColor blueColor].CGColor;
    _signImageView.layer.borderWidth = 3.f;
    [self.view addSubview:_signImageView];
    _signImageView.hidden = YES;
    
    _signView = [[SignView alloc] initWithFrame:CGRectMake(10, 300, kScreenWidth - 20, (kScreenWidth - 20)/2)];
//    _signView.textColor = [UIColor blueColor];
//    _signView.lineWidth = 3.f;
    _signView.layer.borderColor = [UIColor blueColor].CGColor;
    _signView.layer.borderWidth = 3.f;
    [self.view addSubview:_signView];
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 100, 500, 50, 30)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    UIButton *commitButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2 + 50, 500, 50, 30)];
    [commitButton setTitle:@"确定" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitButton];
}

- (void)cancelAction {
    [self.signView clear];
}

- (void)commitAction {
    _signImageView.hidden = NO;
    UIImage *signImage = [self.signView getSignImage];
    self.signImageView.image = signImage;
}


@end
