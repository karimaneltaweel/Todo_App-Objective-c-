//
//  AddClass.h
//  workshop
//
//  Created by kariman eltawel on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "AddClass.h"
#import "ViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddClass : UIViewController
@property NSUserDefaults *def;
@property (weak, nonatomic) IBOutlet UITextField *f_name;
@property (weak, nonatomic) IBOutlet UITextView *f_descrip;
@property NSString *fimage;
@property (weak, nonatomic) IBOutlet UILabel *fdate;
@property NSString *fstate;
@property NSString *fpriorty;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priortyOutlet;
@end

NS_ASSUME_NONNULL_END
