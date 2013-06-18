//
//  CoolTableViewController.m
//  CoolTable
//
//  Created by Edward on 13-6-16.
//  Copyright (c) 2013年 Lihang. All rights reserved.
//

#import "CoolTableViewController.h"
#import "CustomCellBackground.h"

@interface CoolTableViewController ()
@property (copy) NSArray *array;
@property (copy) NSMutableArray *thingsToLearn;
@property (copy) NSMutableArray *thingsLearned;

@end

@implementation CoolTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Core Graphics";
    self.thingsToLearn = [@[@"Drawing Rects",@"Drawing Gradients",@"Drawing Arcs"]mutableCopy];
    self.thingsLearned = [@[@"Table Views",@"UIKit",@"Objective-C"]mutableCopy];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *)escape:(NSString *)text {
    
    //__bridge_transfer:把所有关系给ARC
    //__bridge_retained:收回ARC的所有关系，举例如下：
    //假设你有一个NSString并且你需要把它给Core Foundation API让他们取得这个字符串对象的所有权。你不希望ARC再去释放这个对象，因为它会被释放过度导致程序crash。另外使用__bridge_retained将这个对象给了Core Foundation，这样ARC就不再负责释放它了：
    //Code 例子：
    NSString *string = [[NSString alloc] initWithFormat:@"My name is Edward Lee"];
    CFStringRef strRef = (__bridge_retained CFStringRef)string;
    //do something with strRef
    CFRelease(strRef);

    
    //如果不把它当作NSString返回的话，代码可能看起来是这样
    /*
     CFStringRef result = CFURLCreateStringByAddingPercentEscapes( ...  );
     
     //用result干其它事情
     
     CFRelease(result);
     */
    
    /*
     我们想要做的是在 escape 方法中将 CFStringRef 对象转换为 NSString 对象， 然后 ARC 会在我们不需要它的时候自动释放掉它。 但是 ARC 需要我们告诉它要这样做。 因此， 我们使用 __bridge_transfer 修饰符告诉它，“嘿 ARC， 这个 CFStringRef 对象现在是 NSString对象了， 并且我想要你来释放它， 这样我们就不需要调用 CFRelease() 了”。
     */
    
    //return  (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)text,NULL,CFSTR("!*'();:@&=+$,/?%#[]"),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)text,NULL,CFSTR("!*'();:@&=+$,/?%#[]"),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    CFStringRef ref1 = CFURLCreateStringByAddingPercentEscapes(NULL,"lihang",NULL,"!*'();:@&=+$,/?%#[]",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    NSString *s1 = (__bridge NSString *)ref1;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.thingsToLearn.count;
    } else {
        return self.thingsLearned.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *entry;
    
    
    //START NEW
    if (![cell.backgroundView isKindOfClass:[CustomCellBackground class]]) {
        cell.backgroundView = [[CustomCellBackground alloc] init];
    }
    if (![cell.selectedBackgroundView isKindOfClass:[CustomCellBackground class]]) {
        cell.selectedBackgroundView = [[CustomCellBackground alloc] init];
    }
    //END VIEW
    
    
    if (indexPath.section == 0) {
        entry = self.thingsToLearn[indexPath.row];
    } else {
        entry = self.thingsLearned[indexPath.row];
    }
    
    cell.textLabel.text = entry;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Things We'll Learn";
    } else {
        return @"Things Already Covered";
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
