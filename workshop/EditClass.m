//
//  EditClass.m
//  workshop
//
//  Created by kariman eltawel on 17/01/2023.
//

#import "EditClass.h"
#import "ViewController.h"
@interface EditClass ()

@end

@implementation EditClass{
    NSUserDefaults *def;
}
//--------arrays--of---objects
static NSMutableArray *todo;
static NSMutableArray *in_pro;
static NSMutableArray *doo;

+ (void)initialize
{
    todo=[NSMutableArray new];
    in_pro=[NSMutableArray new];
    doo=[NSMutableArray new];
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    //----unarchived--user--defaults
    
    def = [NSUserDefaults standardUserDefaults];
    NSData *data2=[def objectForKey:@"todo"];
    todo=[NSKeyedUnarchiver unarchiveObjectWithData:data2];

    
    //----pass----data---
    _ename.text=_edtask.title;
    _edescripe.text=_edtask.descrip;
    _estate.selected=0;
    
    //check--------priorty--------and equal it to object priority----------------
    if([_edtask.priorty isEqualToString:@"low"]){
        _epriority.selectedSegmentIndex=0;
    }
    
    else if ([_edtask.priorty isEqualToString:@"medium"]){
        _epriority.selectedSegmentIndex=1;
    }
    
    else if ([_edtask.priorty isEqualToString:@"high"])
    {
        _epriority.selectedSegmentIndex=2;
    }
}

//---------edit------button----
- (IBAction)editAction:(id)sender {
    if ((_ename.text.length>0) && (_edescripe.text.length > 0))
    {
        TaskClass *edit_task=[TaskClass new];
        edit_task.title=_ename.text;
        edit_task.descrip=_edescripe.text;
        
        //--------priority----state----
        
        switch(self.epriority.selectedSegmentIndex){
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

        switch(self.estate.selectedSegmentIndex){
            case 0:
                edit_task.tstate=@"ToDo";
                break;
            case 1:
                edit_task.tstate=@"InProgress";
                break;
            case 2:
                edit_task.tstate=@"Done";
                break;
        }
        
        //--------condition----state----
        /////-----------to----do----------------------------------------------------------------------------------------------------------------------------------------
        if([edit_task.tstate isEqual:@"ToDo"]){
           // get old array from def in didload
           //update
            [todo replaceObjectAtIndex:_index withObject:edit_task];
           //add new arr to def
            NSData *d = [NSKeyedArchiver archivedDataWithRootObject:todo];
            [def setObject:d forKey:@"todo"];
        }
        //-----in-----progress---------------------------------------------------------------------
        
        else if ([edit_task.tstate isEqual:@"InProgress"]){
            ///-------------remove--------from-----todo------------
            [todo removeObjectAtIndex:_index];
            NSData *d = [NSKeyedArchiver archivedDataWithRootObject:todo];
            [def setObject:d forKey:@"todo"];
            
            //---------add------to---inprogress---------
            NSUserDefaults *defpro =[NSUserDefaults standardUserDefaults];
            if([defpro objectForKey:@"inpro"]==nil){
                [in_pro addObject:edit_task];
                
                NSDate *datapro=[NSKeyedArchiver archivedDataWithRootObject:in_pro];
                [defpro setObject:datapro forKey:@"inpro"];
            }
            else if ([defpro objectForKey:@"inpro"]!=nil){
                NSData *data2=[def objectForKey:@"inpro"];
                in_pro=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
                
                [in_pro addObject:edit_task];
                
                NSDate *datapro=[NSKeyedArchiver archivedDataWithRootObject:in_pro];
                [defpro setObject:datapro forKey:@"inpro"];
            }
            
        }
        
        //------done----state---------------------------------------------------------------------
        else if ([edit_task.tstate isEqual:@"Done"]){
            ///-------------remove--------from-----todo------------
            [todo removeObjectAtIndex:_index];
            NSData *d = [NSKeyedArchiver archivedDataWithRootObject:todo];
            [def setObject:d forKey:@"todo"];
            
            //---------add------to---done------------
            NSUserDefaults *defdn  =[NSUserDefaults standardUserDefaults];
            
            if([defdn objectForKey:@"done"]==nil){
                [doo addObject:edit_task];
                
                NSDate *datadn=[NSKeyedArchiver archivedDataWithRootObject:doo];
                [defdn setObject:datadn forKey:@"done"];
            }
            
            else if ([defdn objectForKey:@"done"]!=nil){
                NSData *db=[def objectForKey:@"done"];
                doo=[[NSKeyedUnarchiver unarchiveObjectWithData:db] mutableCopy];
                
                [doo addObject:edit_task];
                
                NSDate *datadn=[NSKeyedArchiver archivedDataWithRootObject:doo];
                [defdn setObject:datadn forKey:@"done"];
            }
        
        }
        [self.navigationController popViewControllerAnimated:YES];    }
    else
    {
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
