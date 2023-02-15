//
//  ViewController.h
//  workshop
//
//  Created by kariman eltawel on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "TaskClass.h"
#import "AddClass.h"
@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableOutlet;
@property TaskClass *ts;
@end

