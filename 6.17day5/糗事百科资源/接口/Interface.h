//
//  Interface.h
//
//
//

#ifndef ________Interface_h
#define ________Interface_h


/*
 -- 首页 接口--
 page:当前页数
 */
#define kMain @"http://m2.qiushibaike.com/article/list/text?page=%d&count=30"


/*
 -- 评论 接口 --
 第一个参数：id（首页中每条数据的id）
 page:当前页数
 */
#define kComment @"http://m2.qiushibaike.com/article/%@/comments?page=%d&count=20"

/**
 *  第二个界面新闻的接口:
 */

#define kNews @"http://api.iclient.ifeng.com/ClientNews?id=SYLB10,SYDT10,SYRECOMMEND&gv=4.6.5&av=0&proid=ifengnews&os=ios_9.1&vt=5&screen=1125x2001&publishid=4002&uid=abaf88f1cc5c47048e2e94f0a7124501"

#endif








