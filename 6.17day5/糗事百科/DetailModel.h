//
//  DetailModel.h
//  
//
//  Created by lgh on 16/4/5.
//
//

#import "JSONModel.h"
/**
 *  详情界面的模型:
 */
@interface DetailModel : JSONModel

@property (nonatomic, copy) NSString *content; //!< 评价内容
@property (nonatomic, copy) NSString *login; //!< 评价用户名;
@property (nonatomic, copy) NSString *floor; //!< 第几楼层

@end























