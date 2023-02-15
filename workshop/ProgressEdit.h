//
//  ProgressEdit.h
//  workshop
//
//  Created by kariman eltawel on 21/01/2023.
//

#import <UIKit/UIKit.h>
#import "TaskClass.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProgressEdit : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *titilelabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionlabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priortyseg;
@property (weak, nonatomic) IBOutlet UISegmentedControl *stateseg;
@property TaskClass *pedit;
@property int indexpro;
@end

NS_ASSUME_NONNULL_END
