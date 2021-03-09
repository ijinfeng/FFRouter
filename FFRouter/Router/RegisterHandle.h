//
//  RegisterHandle.h
//  FFRouter
//
//  Created by jinfeng on 2021/3/5.
//

#import "FFUrlContext.h"

#ifndef RegisterHandle_h
#define RegisterHandle_h

#define Register_router(method, url) \
+ (void)method:(FFUrlContext *)context;


#endif /* RegisterHandle_h */
