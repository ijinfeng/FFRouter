//
//  RouterManager.h
//  FFRouter
//
//  Created by jinfeng on 2021/3/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFRouterManager : NSObject

+ (void)openWithUrl:(NSString *)url;

+ (void)openWithUrl:(NSString *)url params:(NSDictionary *_Nullable)params object:(id _Nullable)object;

@end

NS_ASSUME_NONNULL_END
