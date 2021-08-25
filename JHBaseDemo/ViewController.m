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
    self.view.backgroundColor =  [UIColor randomColor];
    MainModel *mmm = [[MainModel alloc] init];
    [mmm test];
}


@end
