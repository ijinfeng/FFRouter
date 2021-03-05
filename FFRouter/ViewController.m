//
//  ViewController.m
//  FFRouter
//
//  Created by jinfeng on 2021/3/4.
//

#import "ViewController.h"
#import "FFRouter-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)actionForButton:(id)sender {
    [Router openWithUrl:@"/home/live/startPage?a=10&b=1" params:@{@"b":@"jinfeng",@"c":@1111} object:nil];
}

@end
