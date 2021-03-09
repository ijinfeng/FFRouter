//
//  ViewController.m
//  FFRouter
//
//  Created by jinfeng on 2021/3/4.
//

#import "ViewController.h"
#import "FFRouter-Swift.h"
#import "FFRouterManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *bundlePath = [NSBundle mainBundle].bundlePath;
    NSLog(@"bundle:\n\t%@",bundlePath);
    
    NSArray *fileArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSString stringWithFormat:@"%@/FFRouter",bundlePath] error:nil];
    NSLog(@"fileArr: %@",fileArr);
}

- (IBAction)actionForButton:(id)sender {
    [FFRouterManager openWithUrl:@"/home/live/startPage?a=10&b=1" params:@{@"b":@"jinfeng",@"c":@1111} object:nil];
}

+ (void)openHome:(id)context {
    
}

@end
