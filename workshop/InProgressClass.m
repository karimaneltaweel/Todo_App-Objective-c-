//
//  InProgressClass.m
//  workshop
//
//  Created by kariman eltawel on 17/01/2023.
//

#import "InProgressClass.h"
#import "ProgressEdit.h"

@interface InProgressClass ()

@end

@implementation InProgressClass{
    TaskClass *t;
    NSIndexPath *index;
    NSUserDefaults *defpro;
    NSMutableArray *plow;
    NSMutableArray *pmed;
    NSMutableArray *phigh;
}
static NSMutableArray *progress;

+ (void)initialize{
    progress=[NSMutableArray new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   [_protable_outlet reloadData];
  
}
- (void)viewWillAppear:(BOOL)animated{
    defpro=[NSUserDefaults standardUserDefaults];
    NSData *datapro=[[defpro objectForKey:@"inpro"] mutableCopy];
    progress = [NSKeyedUnarchiver unarchiveObjectWithData:datapro];
    
    [_protable_outlet reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    plow=[NSMutableArray new];
    pmed=[NSMutableArray new];
    phigh=[NSMutableArray new];
    t = [TaskClass new];
    
    for(int i=0;i<progress.count;i++){
        t=[progress objectAtIndex:i];
        
        if([t.priorty isEqualToString:@"low"]){
            [plow addObject:t];
        }
        
        else if ([t.priorty isEqualToString:@"medium"]){
                [pmed addObject:t];
        }
        
        else if ([t.priorty isEqualToString:@"high"]){
                [phigh addObject:t];
        }
    }
    [_protable_outlet reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger *numofrows;
    if(self.segOutlet.selectedSegmentIndex==0){
        switch(section){
            case 0:
                numofrows=plow.count;
                break;
            case 1:
                numofrows=0;
                break;
            case 2:
                numofrows=0;
                break;
        }}
    else if(self.segOutlet.selectedSegmentIndex==1){
        switch(section){
            case 0:
                numofrows=0;
                break;
            case 1:
                numofrows=pmed.count;
                break;
            case 2:
                numofrows=0;
                break;
        }
        
    }
    else if(self.segOutlet.selectedSegmentIndex==2){
        switch(section){
            case 0:
                numofrows=0;
                break;
            case 1:
                numofrows=0;
                break;
            case 2:
                numofrows=phigh.count;
                break;
        }}
    else{
        switch(section){
            case 0:
                numofrows=plow.count;
                break;
            case 1:
                numofrows=pmed.count;
                break;
            case 2:
                numofrows=phigh.count;
                break;
        }}
    return numofrows;
    
}

- (IBAction)segAction:(id)sender {
    [_protable_outlet reloadData];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    switch(indexPath.section){
        case 0:
            cell.textLabel.text=[[plow objectAtIndex:indexPath.row] title];
            cell.imageView.image=[UIImage imageNamed:[[plow objectAtIndex:indexPath.row] image]];
            cell.detailTextLabel.text=@"";
            break;
        case 1:
            cell.textLabel.text=[[pmed objectAtIndex:indexPath.row] title];
            cell.imageView.image=[UIImage imageNamed:[[pmed objectAtIndex:indexPath.row] image]];
            cell.detailTextLabel.text=@"";
            break;
        case 2:
            cell.textLabel.text=[[phigh objectAtIndex:indexPath.row] title];
            cell.imageView.image=[UIImage imageNamed:[[phigh objectAtIndex:indexPath.row] image]];
            cell.detailTextLabel.text=@"";
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Delete" message:@"Do you want to delete this task ?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes=[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

        NSMutableArray *repro=[NSMutableArray new];
        
        switch(indexPath.section){
            case 0:
                [plow removeObjectAtIndex:indexPath.row];
                
                break;
            case 1:
                [pmed removeObjectAtIndex:indexPath.row];
                break;
            case 2:
                [phigh removeObjectAtIndex:indexPath.row];
                break;
        }
        
        
        progress = repro;
        [progress arrayByAddingObjectsFromArray:plow];
        [progress arrayByAddingObjectsFromArray:pmed];
        [progress arrayByAddingObjectsFromArray:phigh];
        
        
        
        NSDate *datadone=[NSKeyedArchiver archivedDataWithRootObject:progress];
        [defpro setObject:datadone forKey:@"inpro"];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade]; }];
        
    UIAlertAction *no=[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:yes];
    [alert addAction:no];
    [self presentViewController:alert animated:YES completion:Nil];

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskClass *task=[TaskClass new];
    ProgressEdit *edit=[self.storyboard instantiateViewControllerWithIdentifier:@"ProgressEdit"];
    task.title=[[progress objectAtIndex:indexPath.row] title];
    task.tstate=[[progress objectAtIndex:indexPath.row] tstate];
    task.descrip=[[progress objectAtIndex:indexPath.row] descrip];
    task.image=[[progress objectAtIndex:indexPath.row] image];
    task.priorty=[[progress objectAtIndex:indexPath.row] priorty];
    edit.pedit=task;
    edit.indexpro = indexPath.row;
    [self.navigationController pushViewController:edit animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
