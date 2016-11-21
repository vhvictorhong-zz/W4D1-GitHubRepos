//
//  Repo.h
//  GithubRepos
//
//  Created by Victor Hong on 21/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repo : NSObject

@property NSMutableArray *repoObject;

-(instancetype)initWithRepo:(NSMutableArray *)repo;
-(id)grabObjectWithKeyValue:(NSString *)keyValue;

@end
