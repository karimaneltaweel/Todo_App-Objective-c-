//
//  DoneEdit.h
//  workshop
//
//  Created by kariman eltawel on 27/01/2023.
//

#import <UIKit/UIKit.h>
#import "TaskClass.h"
NS_ASSUME_NONNULL_BEGIN

@interface DoneEdit : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *title_fi;
@property (weak, nonatomic) IBOutlet UITextView *description_fi;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prio_segment;
@property TaskClass *dedit;
@property int indexdone;
@end

NS_ASSUME_NONNULL_END
