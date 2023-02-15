//
//  EditClass.h
//  workshop
//
//  Created by kariman eltawel on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "TaskClass.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditClass : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *ename;
@property (weak, nonatomic) IBOutlet UITextView *edescripe;
@property (weak, nonatomic) IBOutlet UISegmentedControl *epriority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *estate;
@property TaskClass *edtask;
@property int index;
//@property int indexPro;
//@property int indexDone;
@end

NS_ASSUME_NONNULL_END
