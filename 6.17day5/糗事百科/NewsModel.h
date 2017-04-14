//
//  NewsModel.h
//  
//
//  Created by lgh on 16/4/6.
//
//

#import "JSONModel.h"

@interface NewsModel : JSONModel

@property (nonatomic, copy) NSString *thumbnail; //!< 图片;
@property (nonatomic, copy) NSString *title; //!< 标题;
@property (nonatomic, strong) NSArray *images; //!< 三张图片数组;
@property (nonatomic, copy) NSString *type; //!< cell的类型;

@end
