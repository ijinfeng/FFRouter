//
//  SecondViewController.h
//  FFRouter
//
//  Created by jinfeng on 2021/3/4.
//

#import <UIKit/UIKit.h>
#import "FFRouter-Swift.h"
#import "RegisterHandle.h"

NS_ASSUME_NONNULL_BEGIN

//@register_router(@"ff://home/live/list", @"SecondViewController", @"open")



@interface SecondViewController : UIViewController

  Register_router(open    , @"ff://home/second")

Register_router(  login, "ff://home/login")
@end

NS_ASSUME_NONNULL_END
