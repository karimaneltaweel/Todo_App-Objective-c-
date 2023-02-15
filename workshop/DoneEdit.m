//
//  DoneEdit.m
//  workshop
//
//  Created by kariman eltawel on 27/01/2023.
//

#import "DoneEdit.h"

@interface DoneEdit ()

@end

@implementation DoneEdit
{
    NSUserDefaults *defdn;
}
static NSMutableArray *doneedit;

+ (void)initialize{
    doneedit=[NSMutableArray new];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    defdn=[NSUserDefaults standardUserDefaults];
    NSData *datadn=[defdn objectForKey:@"done"];
    doneedit=[NSKeyedUnarchiver unarchiveObjectWithData:datadn];
    
    //----pass----data---
    _title_fi.text=_dedit.title;
    _description_fi.text=_dedit.descrip;

    if([_dedit.priorty isEqualToString:@"low"]){
        _prio_segment.selectedSegmentIndex=0;
    }
    else if ([_dedit.priorty isEqualToString:@"medium"]){
        _prio_segment.selectedSegmentIndex=1;
    }
    else if ([_dedit.priorty isEqualToString:@"high"])
    {
        _prio_segment.selectedSegmentIndex=2;
    }

}
- (IBAction)esitAction:(id)sender {
    if((_title_fi.text.length>0) &&(_description_fi.text.length>0)){
        TaskClass *edit_task=[TaskClass new];
        edit_task.title=_title_fi.text;
        edit_task.descrip=_description_fi.text;
        
        //--------priority----state----
        switch(self.prio_segment.selectedSegmentIndex){
            case 0:
                edit_task.priorty=@"low";
                edit_task.image=@"1";
                break;
            case 1:
                edit_task.priorty=@"medium";
                edit_task.image=@"2";
                break;
            case 2:
                edit_task.priorty=@"high";
                edit_task.image=@"3";
                break;
        }
        
        
        NSUserDefaults *def  =[NSUserDefaults standardUserDefaults];
        [doneedit replaceObjectAtIndex:_indexdone withObject:edit_task];
        NSDate *datadn=[NSKeyedArchiver archivedDataWithRootObject:doneedit];
        [def setObject:datadn forKey:@"done"];
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else{
        //////----------empty---------text--------------------
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
