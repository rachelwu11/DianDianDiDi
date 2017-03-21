//
//  MixScrollViewAndTableViewController.m
//  DianDianDiDi
//
//  Created by rachel on 3/18/17.
//  Copyright © 2017 rwu. All rights reserved.
//

#import "MixScrollViewAndTableViewController.h"
#import "HeaderView.h"
#import "CustomizedSegmentedControl.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define defaultColor [UIColor colorWithWhite:0.998 alpha:1]

#define MAXValue(a, b, c) a > b ? (a > c ? a : c) : (b > c ? b : c)

@interface MixScrollViewAndTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *middleTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) CustomizedSegmentedControl *segmentControl;

@end

@implementation MixScrollViewAndTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self addScrollViewAndTableView];

}

-(void)addScrollViewAndTableView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = defaultColor;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(ScreenWidth * 3, 0);
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;

    //HeaderView
    HeaderView *header = [HeaderView headerView:CGRectMake(0, 0, ScreenWidth, 150)];

    __weak MixScrollViewAndTableViewController *weakSelf = self;
    CustomizedSegmentedControl *segmentedControl = [[CustomizedSegmentedControl alloc] initWithTitles:@[@"Moments", @"Articles", @"More"] frame:CGRectMake(0, CGRectGetMaxY(header.frame), ScreenWidth, 44) titleClicked:^(NSInteger index) {
        weakSelf.scrollView.contentOffset = CGPointMake(ScreenWidth * index, 0);
        [weakSelf reloadMaxOffsetY];
    }];
    self.segmentControl = segmentedControl;

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 194)];
    headerView.backgroundColor = defaultColor;
    [headerView addSubview:header];
    [headerView addSubview:segmentedControl];
    self.headerView = headerView;
    [self.view addSubview:self.headerView];

    self.leftTableView = [self tableViewWithX:0];
    self.middleTableView = [self tableViewWithX:ScreenWidth];
    self.rightTableView = [self tableViewWithX:ScreenWidth * 2];

    //avatar
    UIView *avatarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    avatarView.backgroundColor = [UIColor clearColor];

    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 18, 35, 35)];
    avatar.image = [UIImage imageNamed:@"alalei"];
    avatar.layer.cornerRadius = 35 / 2;
    avatar.clipsToBounds = YES;
    [avatarView addSubview:avatar];
    self.navigationItem.titleView = avatarView;
    avatar.transform = CGAffineTransformMakeScale(2, 2);
    self.avatar = avatar;

}

-(UITableView *)tableViewWithX:(CGFloat)x {

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    [self.scrollView addSubview:tableView];
    tableView.backgroundColor = defaultColor;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;

    //fake tableView Header
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 194)];
    tableView.tableHeaderView = headerView;
    return tableView;
}

#pragma UITableView delegate & datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 44;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.backgroundColor = defaultColor;
    if (tableView == self.leftTableView) {
        cell.textLabel.text = @"Left tableView";
    } else if (tableView == self.middleTableView) {
        cell.textLabel.text = @"Middle tableView";
    } else if (tableView == self.rightTableView) {
        cell.textLabel.text = @"Right tableView";
    }
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UITableView class]]) {
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        if (contentOffsetY < 150) {
            self.leftTableView.contentOffset = self.middleTableView.contentOffset = self.rightTableView.contentOffset = scrollView.contentOffset;

            CGRect frame = self.headerView.frame;
            CGFloat y = -self.rightTableView.contentOffset.y;
            frame.origin.y = y;
            self.headerView.frame = frame;
        } else {
            CGRect frame = self.headerView.frame;
            frame.origin.y = -150;
            self.headerView.frame = frame;
        }
    }

    //segment control
    if (self.scrollView == scrollView) {
        [self.segmentControl setContentOffset:CGPointMake(self.scrollView.contentOffset.x / 3, 0)];
    }

    //avatar
    CGFloat scale = scrollView.contentOffset.y / 80;
    if (scrollView.contentOffset.y > 80) {
        scale = 1;
    } else if (scrollView.contentOffset.y <= 0) {
        scale = 0;
    }

    self.avatar.transform = CGAffineTransformMakeScale(2 - scale, 2 - scale);

    CGRect frame = self.avatar.frame;
    frame.origin.y = (1 - scale) * 8;
    self.avatar.frame = frame;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        [self reloadMaxOffsetY];
    }
}

-(void)reloadMaxOffsetY {
    CGFloat maxOffsetY = MAXValue(self.leftTableView.contentOffset.y, self.middleTableView.contentOffset.y, self.rightTableView.contentOffset.y);
    if (maxOffsetY > 150) {
        if (self.leftTableView.contentOffset.y < 150) {
            self.leftTableView.contentOffset = CGPointMake(0, 150);
        }
        if (self.middleTableView.contentOffset.y < 150) {
            self.middleTableView.contentOffset = CGPointMake(0, 150);
        }
        if (self.rightTableView.contentOffset.y < 150) {
            self.rightTableView.contentOffset = CGPointMake(0, 150);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
