//
//  FourViewController.h
//  FFRouter
//
//  Created by jinfeng on 2021/3/9.
//

#import <Foundation/Foundation.h>
#import "RegisterHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface FourViewController : NSObject

Register_router(my_open, "ff://hello/world")

@end

NS_ASSUME_NONNULL_END
