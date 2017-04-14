//
//  HomeModel.h
//  
//
//  Created by lgh on 16/4/5.
//
//

#import "JSONModel.h"
/**
 *  主页模型
 */
@interface HomeModel : JSONModel

@property (nonatomic, copy) NSString *login; //!< 用户名
@property (nonatomic, copy) NSString *content; //!< 内容
@property (nonatomic, copy) NSString *comments_count; //!< 评论个数
@property (nonatomic, copy) NSString *up; //!< 点赞个数;
@property (nonatomic, copy) NSString *myId; //!< id号


@end





















