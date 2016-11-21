//
//  ViewController.m
//  GithubRepos
//
//  Created by Victor Hong on 21/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import "ViewController.h"
#import "Repo.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *repoList;
@property Repo *repoObject;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/victorhong1988/repos"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            //Handler the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSMutableArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        self.repoObject = [[Repo alloc] initWithRepo:repos];
        
        if (jsonError) {
            
            //Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        //If we reach this point, we have successfully retrieved the JSON from the API
//        for (NSDictionary *repo in repos) {
//            
//            NSString *repoName = repo[@"name"];
//            [self.repoList addObject:repoName];
//            NSLog(@"repo: %@", repoName);
//            
//        }
        self.repoList = [[NSMutableArray alloc] initWithArray:[self.repoObject grabObjectWithKeyValue:@"name"]];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            //This will run on the main queue
            [self.tableView reloadData];
            
        }];

        
    }];
    
    [dataTask resume];
    
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.repoList.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //Configure cell
    cell.textLabel.text = self.repoList[indexPath.row];
    
    return cell;
    
}
@end
