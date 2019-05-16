//
//  TMViewController.m
//  TMFileSystem
//
//  Created by 1158433594@qq.com on 05/15/2019.
//  Copyright (c) 2019 1158433594@qq.com. All rights reserved.
//

#import "TMViewController.h"
#import <TMFileSystem/TMFileSystemViewController.h>
#import <TMFileSystem/TMFileSystem.h>

@interface TMViewController ()
{
    UIButton *button;
}
@end

@implementation TMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [button setTitle:@"CLick" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void) buttonClicked:(UIButton *)button
{
    TMFileSystem *fileSystem = [[TMFileSystem alloc] initWithFilePath:NSHomeDirectory()];
    
    TMFileSystemViewController *fileSystemViewController = [[TMFileSystemViewController alloc] init];
    fileSystemViewController.fileSystem = fileSystem;

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:fileSystemViewController];
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
