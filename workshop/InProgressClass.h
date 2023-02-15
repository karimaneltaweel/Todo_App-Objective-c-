//
//  InProgressClass.h
//  workshop
//
//  Created by kariman eltawel on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "TaskClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface InProgressClass : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segOutlet;
@property (weak, nonatomic) IBOutlet UITableView *protable_outlet;
@end

NS_ASSUME_NONNULL_END
