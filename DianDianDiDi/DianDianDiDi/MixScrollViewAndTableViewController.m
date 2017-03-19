//
//  MixScrollViewAndTableViewController.m
//  DianDianDiDi
//
//  Created by rachel on 3/18/17.
//  Copyright © 2017 rwu. All rights reserved.
//

#import "MixScrollViewAndTableViewController.h"
#import "HeaderView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define defaultColor [UIColor colorWithWhite:0.998 alpha:1]

@interface MixScrollViewAndTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *middleTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *avatar;

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

    //TODO: add segment control

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 194)];
    headerView.backgroundColor = defaultColor;
    [headerView addSubview:header];
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
