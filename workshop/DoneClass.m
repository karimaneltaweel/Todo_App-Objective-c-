//
//  DoneClass.m
//  workshop
//
//  Created by kariman eltawel on 17/01/2023.
//

#import "DoneClass.h"
#import "TaskClass.h"
#import "DoneEdit.h"
@interface DoneClass ()

@end

@implementation DoneClass{
    TaskClass *t;
    NSIndexPath *index;
    NSUserDefaults *defdn;
    NSMutableArray *dlow;
    NSMutableArray *dmed;
    NSMutableArray *dhigh;
}
static NSMutableArray *done;

+ (void)initialize{
    done=[NSMutableArray new];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [_DNTABLE_OUTLET reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    defdn=[NSUserDefaults standardUserDefaults];
    NSData *datadn=[[defdn objectForKey:@"done"] mutableCopy];
    done = [NSKeyedUnarchiver unarchiveObjectWithData:datadn];
    [_DNTABLE_OUTLET reloadData];
    }

- (void)viewDidAppear:(BOOL)animated{
    dlow=[NSMutableArray new];
    dmed=[NSMutableArray new];
    dhigh=[NSMutableArray new];
    t = [TaskClass new];
    
    for(int i=0;i<done.count;i++){
        t=[done objectAtIndex:i];
        
        if([t.priorty isEqualToString:@"low"]){
            [dlow addObject:t];
        }
        
        else if ([t.priorty isEqualToString:@"medium"]){
                [dmed addObject:t];
        }
        
        else if ([t.priorty isEqualToString:@"high"]){
                [dhigh addObject:t];
        }
    }
    [_DNTABLE_OUTLET reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger *numofrows;
    if(self.seg_don.selectedSegmentIndex==0){
        switch(section){
            case 0:
                numofrows=dlow.count;
                break;
            case 1:
                numofrows=0;
                break;
            case 2:
                numofrows=0;
                break;
        }}
    else if(self.seg_don.selectedSegmentIndex==1){
        switch(section){
            case 0:
                numofrows=0;
                break;
            case 1:
                numofrows=dmed.count;
                break;
            case 2:
                numofrows=0;
                break;
        }
        
    }
    else if(self.seg_don.selectedSegmentIndex==2){
        switch(section){
            case 0:
                numofrows=0;
                break;
            case 1:
                numofrows=0;
                break;
            case 2:
                numofrows=dhigh.count;
                break;
        }}
    else{
        switch(section){
            case 0:
                numofrows=dlow.count;
                break;
            case 1:
                numofrows=dmed.count;
                break;
            case 2:
                numofrows=dhigh.count;
                break;
        }}
    return numofrows;
}

- (IBAction)SegAction:(id)sender {
    [_DNTABLE_OUTLET reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    switch(indexPath.section){
        case 0:
            cell.textLabel.text=[[dlow objectAtIndex:indexPath.row] title];
            cell.imageView.image=[UIImage imageNamed:[[dlow objectAtIndex:indexPath.row] image]];
            cell.detailTextLabel.text=@"";
            break;
        case 1:
            cell.textLabel.text=[[dmed objectAtIndex:indexPath.row] title];
            cell.imageView.image=[UIImage imageNamed:[[dmed objectAtIndex:indexPath.row] image]];
            cell.detailTextLabel.text=@"";
            break;
        case 2:
            cell.textLabel.text=[[dhigh objectAtIndex:indexPath.row] title];
            cell.imageView.image=[UIImage imageNamed:[[dhigh objectAtIndex:indexPath.row] image]];
            cell.detailTextLabel.text=@"";
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Delete" message:@"Do you want to delete this task ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes=[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    NSMutableArray *redone=[NSMutableArray new];
    
    switch(indexPath.section){
        case 0:
            [dlow removeObjectAtIndex:indexPath.row];
            
            break;
        case 1:
            [dmed removeObjectAtIndex:indexPath.row];
            break;
        case 2:
            [dhigh removeObjectAtIndex:indexPath.row];
            break;
    }
    
    
         done = redone;
         [done arrayByAddingObjectsFromArray:dlow];
         [done arrayByAddingObjectsFromArray:dmed];
         [done arrayByAddingObjectsFromArray:dhigh];
    
    
    
        NSDate *datadone=[NSKeyedArchiver archivedDataWithRootObject:done];
        [defdn setObject:datadone forKey:@"done"];
 
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        [_DNTABLE_OUTLET reloadData];}];
    
    UIAlertAction *no=[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:yes];
    [alert addAction:no];
    [self presentViewController:alert animated:YES completion:Nil];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   NSString *nameofsec;
   switch(section){
       case 0:
           nameofsec=@"low";
           break;;
       case 1:
           nameofsec=@"medium";
           break;
       case 2:
           nameofsec=@"high";
           break;
   }

   return nameofsec;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskClass *task=[TaskClass new];
    DoneEdit *editdon=[self.storyboard instantiateViewControllerWithIdentifier:@"DoneEdit"];
    task.title=[[done objectAtIndex:indexPath.row] title];
    task.tstate=[[done objectAtIndex:indexPath.row] tstate];
    task.descrip=[[done objectAtIndex:indexPath.row] descrip];
    task.image=[[done objectAtIndex:indexPath.row] image];
    task.priorty=[[done objectAtIndex:indexPath.row] priorty];
    editdon.dedit=task;
    editdon.indexdone = indexPath.row;
    [self.navigationController pushViewController:editdon animated:YES];
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
