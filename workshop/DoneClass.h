//
//  DoneClass.h
//  workshop
//
//  Created by kariman eltawel on 17/01/2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DoneClass : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *DNTABLE_OUTLET;
@property (weak, nonatomic) IBOutlet UISegmentedControl *seg_don;

@end

NS_ASSUME_NONNULL_END
