#import "DDYTestNavigationVC.h"
#import "DDYCategoryHeader.h"

@interface DDYTestNavigationVC ()

@end

@implementation DDYTestNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ddy_navigationBackgroundColor:[UIColor redColor]];
    self.tableView.rowHeight = 60;
}

- (void)viewWillDisappear:(BOOL)animated {
//    [self ddy_navigationBackgroundColor:[UIColor whiteColor]];
//    [self updateProgress:0];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if (offsetY > 0) {
//        if (offsetY >= 44) {
//            [self updateProgress:1];
//        } else {
//            [self updateProgress:(offsetY / 44)];
//        }
//    } else {
//        [self updateProgress:0];
//    }
}

- (void)updateProgress:(CGFloat)progress {
//    [self ddy_NavigationBarTranslationY:(-64 * progress)];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLID"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld--%ld", (long)indexPath.section, (long)indexPath.row];
    return cell;
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    [self.navigationController setNavigationBarHidden:velocity.y>0 animated:YES];
}

@end
