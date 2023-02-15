//
//  ProgressEdit.m
//  workshop
//
//  Created by kariman eltawel on 21/01/2023.
//

#import "ProgressEdit.h"

@interface ProgressEdit ()

@end

@implementation ProgressEdit{
    NSUserDefaults *def;
}
static NSMutableArray *progressedit;
static NSMutableArray *doneedit;

+(void)initialize{
    progressedit=[NSMutableArray new];
    doneedit=[NSMutableArray new];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    //------unarchiev-----
    def = [NSUserDefaults standardUserDefaults];
    NSData *datapro=[def objectForKey:@"inpro"];
    progressedit=[NSKeyedUnarchiver unarchiveObjectWithData:datapro];
    //----pass----data---
    _titilelabel.text=_pedit.title;
    _descriptionlabel.text=_pedit.descrip;

    if([_pedit.priorty isEqualToString:@"low"]){
        _priortyseg.selectedSegmentIndex=0;
    }
    else if ([_pedit.priorty isEqualToString:@"medium"]){
        _priortyseg.selectedSegmentIndex=1;
    }
    else if ([_pedit.priorty isEqualToString:@"high"])
    {
        _priortyseg.selectedSegmentIndex=2;
    }
    
    if([_pedit.tstate isEqualToString:@"InProgress"]){
        _stateseg.selectedSegmentIndex=0;
    }
    else if ([_pedit.tstate isEqualToString:@"Done"]){
        _stateseg.selectedSegmentIndex=1;
    }

}
- (IBAction)buttonAction:(id)sender {
    if((_titilelabel.text.length>0) &&( _descriptionlabel.text.length>0)){
        TaskClass *edit_task=[TaskClass new];
        edit_task.title=_titilelabel.text;
        edit_task.descrip=_descriptionlabel.text;
        
        //--------priority----state----
        switch(self.priortyseg.selectedSegmentIndex){
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
        //--------segment----state----
        
        switch(self.stateseg.selectedSegmentIndex){
            case 0:
                edit_task.tstate=@"InProgress";
                break;
            case 1:
                edit_task.tstate=@"Done";
                break;
        }
        
        //--------condition----state----
        
        //-----progress---state----
        
        if ([edit_task.tstate isEqual:@"InProgress"]){
            [progressedit replaceObjectAtIndex:_indexpro withObject:edit_task];
            NSDate *datapro=[NSKeyedArchiver archivedDataWithRootObject:progressedit];
            [def setObject:datapro forKey:@"inpro"];
        }
        
        //------done----state------
        else if ([edit_task.tstate isEqual:@"Done"]){
            [progressedit removeObjectAtIndex:_indexpro];
            NSDate *datapro=[NSKeyedArchiver archivedDataWithRootObject:progressedit];
            [def setObject:datapro forKey:@"inpro"];
            
            
            NSUserDefaults *defdn  =[NSUserDefaults standardUserDefaults];
            if([defdn objectForKey:@"done"]==nil){
                [doneedit addObject:edit_task];
                NSDate *datadn=[NSKeyedArchiver archivedDataWithRootObject:doneedit];
                [defdn setObject:datadn forKey:@"done"];
            }
            
            else if ([defdn objectForKey:@"done"]!=nil){
                NSData *db=[def objectForKey:@"done"];
                doneedit=[[NSKeyedUnarchiver unarchiveObjectWithData:db] mutableCopy];
                [doneedit addObject:edit_task];
                NSDate *datadn=[NSKeyedArchiver archivedDataWithRootObject:doneedit];
                [defdn setObject:datadn forKey:@"done"];
            };
        }
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
