//
//  ListTableViewController.m
//  DianDianDiDi
//
//  Created by rachel on 3/8/17.
//  Copyright © 2017 rwu. All rights reserved.
//

#import "ListTableViewController.h"
#import "CustomizeCollectionViewController.h"

@interface ListTableViewController ()

@property (nonatomic, strong) NSArray<NSString *> *demoLists;
@property (nonatomic, strong) NSDictionary<NSString *, UIViewController *> *demoDics;


@end

@implementation ListTableViewController

static NSString *cellIdentifier = @"demoListCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    //hide nav bar
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated {

    //show nav bar
    self.navigationController.navigationBar.hidden = NO;
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma data source of Table View
-(NSArray<NSString *> *)demoLists {
    return @[@"Customize Collection View"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.demoLists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell = [cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];

    cell.textLabel.text = [self.demoLists objectAtIndex:indexPath.row];
    NSString *listDatesPath = [[NSBundle mainBundle] pathForResource:@"listDates" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:listDatesPath];
    if ([data isKindOfClass:[NSData class]]) {
        NSError *error = nil;
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSString *cellName = [self.demoLists objectAtIndex:indexPath.row];
            if ([cellName isKindOfClass:[NSString class]]) {
                NSString *dateString = [obj objectForKey:cellName];
                if ([dateString isKindOfClass:[NSString class]]) {
                    cell.detailTextLabel.text = dateString;
                }
            }
        }
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSUInteger row = indexPath.row;
    if (row == 0) {

        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CustomizeCollectionViewController *collectionVC = [[CustomizeCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
        [self.navigationController pushViewController:collectionVC animated:YES];
    }
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
