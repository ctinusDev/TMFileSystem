//
//  TMFilePreview.m
//  TMFileSystem_Example
//
//  Created by TomyChen on 2019/5/16.
//  Copyright © 2019 1158433594@qq.com. All rights reserved.
//

#import "TMFilePreview.h"

@implementation TMFilePreview

- (instancetype)init {
    if (self = [super init]) {
        _previewController = [[QLPreviewController alloc] init];
        _previewController.delegate = self;
        _previewController.dataSource = self;
    }
    return self;
}

- (void)previewItems:(NSArray<NSURL *> *)items inViewController:(UIViewController *)viewController {
    _items = items;
    
    [viewController presentViewController:_previewController animated:YES completion:nil];
    [_previewController reloadData];
}

/*!
 * @abstract Returns the number of items that the    preview controller should preview.
 * @param controller The Preview Controller.
 * @result The number of items.
 */
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return self.items.count;
}

/*!
 * @abstract Returns the item that the preview controller should preview.
 * @param controller The Preview Controller.
 * @param index The index of the item to preview.
 * @result An item conforming to the QLPreviewItem protocol.
 */
- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    NSURL *fileURL = self.items[index];
    return fileURL;
}
@end
