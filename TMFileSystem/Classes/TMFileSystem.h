//
//  TMFileSystem.h
//  TMFileSystem_Example
//
//  Created by TomyChen on 2019/5/15.
//  Copyright © 2019 1158433594@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMFileSystem : NSObject
@property (nonatomic, strong, readonly) NSString *filePath;

@property (nonatomic, strong, readonly) NSArray *fileInfo;

- (instancetype)initWithFilePath:(NSString *)filePath;

- (void) refresh;
@end

NS_ASSUME_NONNULL_END
