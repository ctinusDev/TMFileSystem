//
//  TMFileSystemViewController.m
//  TMFileSystem_Example
//
//  Created by TomyChen on 2019/5/15.
//  Copyright © 2019 1158433594@qq.com. All rights reserved.
//

#import "TMFileSystemViewController.h"
#import "TMFilePreview.h"

@interface TMFileSystemViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TMFilePreview *filePreview;
@end

@implementation TMFileSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.editing = YES;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.fileSystem refresh];
    [self.tableView reloadData];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if (!editing) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fileSystem fileInfo].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
 
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    
    NSDictionary *file = [self.fileSystem fileInfo][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@""];
    cell.textLabel.text = file[NSURLNameKey];
    
    if ([file[NSURLIsDirectoryKey] boolValue]) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@个子项目",file[@"subCount"]];
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"size: %.1fKB",[file[NSURLTotalFileSizeKey] floatValue] / 1024];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *file = [self.fileSystem fileInfo][indexPath.row];
    NSString *filePath = file[NSURLPathKey];
    
    if ([file[NSURLIsDirectoryKey] boolValue]) {
        TMFileSystem *fileSystem = [[TMFileSystem alloc] initWithFilePath:filePath];
        TMFileSystemViewController *subFileSystemController = [[TMFileSystemViewController alloc] init];
        subFileSystemController.fileSystem = fileSystem;
        subFileSystemController.title = [fileSystem.filePath lastPathComponent];
        [self.navigationController pushViewController:subFileSystemController animated:YES];
    } else {
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        
        [self.filePreview previewItems:@[fileUrl] inViewController:self];
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.fileSystem removeItemAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark - Getter
-(TMFilePreview *)filePreview
{
    if (!_filePreview) {
        _filePreview = [[TMFilePreview alloc] init];
    }
    return _filePreview;
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
