//
//  Repo.m
//  GithubRepos
//
//  Created by Victor Hong on 21/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import "Repo.h"

@implementation Repo

-(instancetype)initWithRepo:(NSMutableArray *)repo {
    
    if (self = [super init]) {
        
        _repoObject = [[NSMutableArray alloc] initWithArray:repo];
        
    }
    
    return self;
    
}

-(id)grabObjectWithKeyValue:(NSString *)keyValue {
    
    NSMutableArray *repoList = [[NSMutableArray alloc] init];
    
    for (NSDictionary *repo in self.repoObject) {
        
        NSString *repoName = repo[keyValue];
        [repoList addObject:repoName];
        
    }
    
    return repoList;
    
}

@end
