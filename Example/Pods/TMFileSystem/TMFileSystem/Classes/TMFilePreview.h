//
//  TMFilePreview.h
//  TMFileSystem_Example
//
//  Created by TomyChen on 2019/5/16.
//  Copyright © 2019 1158433594@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMFilePreview : NSObject<QLPreviewControllerDelegate,QLPreviewControllerDataSource>
@property (nonatomic, strong, readonly) NSArray<NSURL *> *items;
@property (nonatomic, strong, readonly) QLPreviewController *previewController;

- (void)previewItems:(NSArray<NSURL *> *)items inViewController:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
