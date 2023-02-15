//
//  TaskClass.h
//  workshop
//
//  Created by kariman eltawel on 17/01/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskClass : NSObject <NSCoding>
@property NSString *title;
@property NSString *descrip;
@property NSString *priorty;
@property NSString *Datee;
@property NSString *image;
@property NSString *tstate;
@end

NS_ASSUME_NONNULL_END
