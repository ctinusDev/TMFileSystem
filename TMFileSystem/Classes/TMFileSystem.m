//
//  TMFileSystem.m
//  TMFileSystem_Example
//
//  Created by TomyChen on 2019/5/15.
//  Copyright © 2019 1158433594@qq.com. All rights reserved.
//

#import "TMFileSystem.h"

@interface TMFileSystem ()
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSArray *fileInfo;
@end

@implementation TMFileSystem
- (instancetype)initWithFilePath:(NSString *)filePath
{
    if (self = [super init]) {
        self.filePath = filePath;
    }
    return self;
}

- (NSArray *)fileInfo
{
    if (_fileInfo) {
        return _fileInfo;
    }
    
    NSMutableArray *fileInfo = [NSMutableArray array];
    
    NSURL *directoryURL = [NSURL fileURLWithPath:self.filePath];
    NSArray *sourceKeys = @[NSURLNameKey,
                            NSURLIsDirectoryKey,
                            NSURLTotalFileSizeKey,
                            NSURLFileResourceTypeKey,
                            ];

    NSDirectoryEnumerator *directoryEnumerator =
    [[NSFileManager defaultManager] enumeratorAtURL:directoryURL
                         includingPropertiesForKeys:sourceKeys
                                            options:NSDirectoryEnumerationSkipsSubdirectoryDescendants | NSDirectoryEnumerationSkipsHiddenFiles
                                       errorHandler:nil];
    
    for (NSURL *fileURL in directoryEnumerator) {
        
        NSMutableDictionary *file = [NSMutableDictionary dictionary];
        
        NSNumber *isDirectory = nil;
        NSString *name = nil;
        NSNumber *fileSize = nil;
        NSString *fileType = nil;
        NSNumber *subPathCount = nil;
        
        [fileURL getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil];
        [fileURL getResourceValue:&name forKey:NSURLNameKey error:nil];
        if ([isDirectory boolValue]) {
            if ([name isEqualToString:@"_extras"]) {
                [directoryEnumerator skipDescendants];
            } else {
                NSDirectoryEnumerator *directoryEnumerator =
                [[NSFileManager defaultManager] enumeratorAtURL:fileURL
                                     includingPropertiesForKeys:sourceKeys
                                                        options:NSDirectoryEnumerationSkipsSubdirectoryDescendants | NSDirectoryEnumerationSkipsHiddenFiles
                                                   errorHandler:nil];
                
                subPathCount = @(directoryEnumerator.allObjects.count);
            }
        } else {
            [fileURL getResourceValue:&fileSize forKey:NSURLTotalFileSizeKey error:nil];
            [fileURL getResourceValue:&fileType forKey:NSURLFileResourceTypeKey error:nil];
        }
        
        file[NSURLNameKey] = name;
        file[NSURLIsDirectoryKey] = isDirectory;
        file[NSURLTotalFileSizeKey] = fileSize;
        file[NSURLFileResourceTypeKey] = fileType;
        file[NSURLPathKey] = fileURL.path;
        file[@"subCount"] = subPathCount;
        
        [fileInfo addObject:file];
    }
    
    _fileInfo = fileInfo;
    
    NSLog(@"Files: %@", fileInfo);

    return fileInfo;
}

-(void)removeItemAtIndex:(NSInteger)index
{
    if (self.fileInfo.count <= index) {
        return;
    }

    NSDictionary *file = self.fileInfo[index];
    NSString *filePath = file[NSURLPathKey];
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    
    NSMutableArray *fileInfo = [_fileInfo mutableCopy];
    [fileInfo removeObject:file];
    _fileInfo = [fileInfo copy];
}

- (void) refresh
{
    _fileInfo = nil;
}

@end
