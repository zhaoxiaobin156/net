//
//  StudentInfo.h
//  
//
//  Created by mac on 16/6/21.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface StudentInfo : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;

@end
