//
//  AddClass.m
//  workshop
//
//  Created by kariman eltawel on 17/01/2023.
//

#import "AddClass.h"

@interface AddClass ()
@end

@implementation AddClass{
}
static NSMutableArray *to_do;
+ (void)initialize{
    to_do=[NSMutableArray new];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _def=[NSUserDefaults standardUserDefaults];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _fdate.text= [dateFormatter stringFromDate:[NSDate date]];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
}
- (IBAction)clickAdd:(id)sender {
    if ((_f_name.text.length>0) && (_f_descrip.text.length > 0))
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Do you want to add task ?" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *yes=[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //------un----archiver-------
            NSData *data2=[_def objectForKey:@"todo"];
            to_do=[NSKeyedUnarchiver unarchiveObjectWithData:data2];

            TaskClass *to=[TaskClass new];
            to.title=self->_f_name.text;
            to.descrip=self->_f_descrip.text;
            to.priorty=self->_fpriorty;
            to.tstate=self->_fstate;
            to.Datee=self->_fdate.text;
            
            [to_do addObject:to];
            
            switch(self.priortyOutlet.selectedSegmentIndex){
                case 0:
                    to.priorty=@"low";
                    to.image=@"1";
                    break;
                case 1:
                    to.priorty=@"medium";
                    to.image=@"2";
                    break;
                case 2:
                    to.priorty=@"high";
                    to.image=@"3";
                    break;
            }
            NSDate *dataadd=[NSKeyedArchiver archivedDataWithRootObject:to_do];
            [_def setObject:dataadd forKey:@"todo"];
            [self dismissViewControllerAnimated:YES completion:nil];

        }];
        UIAlertAction *no=[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:yes];
        [alert addAction:no];
        [self presentViewController:alert animated:YES completion:Nil];
        
    }
    else
        
    { //////----------empty---------text--------------------
        UIAlertController *alertempty=[UIAlertController alertControllerWithTitle:@"Empty textfields" message:@"Please fill your Task " preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertempty addAction:ok];
        [self presentViewController:alertempty animated:YES completion:Nil];

    }
    }


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
