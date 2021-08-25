//
//  ViewController.m
//  JHBaseDemo
//
//  Created by lifei on 2021/8/25.
//

#import "ViewController.h"
#import <JHBaseDemo-Swift.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.view.backgroundColor =  [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    MainModel *mmm = [[MainModel alloc] init];
    [mmm test];
}


@end
