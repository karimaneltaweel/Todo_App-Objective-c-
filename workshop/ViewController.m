//
//  ViewController.m
//  workshop
//
//  Created by kariman eltawel on 17/01/2023.
//

#import "ViewController.h"
#import "AddClass.h"
#import "EditClass.h"
@interface ViewController ()

@end

@implementation ViewController{
    UITableViewCell *cell ;
}
//array---of--objects
static NSMutableArray *tasks;
static NSMutableArray *TODO;
static NSUserDefaults *def;

+ (void)initialize
{
    //-----------------initialization-----------of--------array--------
    tasks=[NSMutableArray new];
    TODO=[NSMutableArray new];
    def = [NSUserDefaults standardUserDefaults];
    
    //-------------------when opening app find data------------------
    if([def objectForKey:@"todo"]==nil){
        NSDate *data=[NSKeyedArchiver archivedDataWithRootObject:TODO];
        [def setObject:data forKey:@"todo"];
    }}

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)viewWillAppear:(BOOL)animated{
    //--------table-----image-------background------------
    self.tableOutlet.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bk"]];
    
     //------------unarchive for todo array(archive add task )-----------------
    NSData *data2=[def objectForKey:@"todo"];
    tasks=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
    [self.tableOutlet reloadData];
}

//---------------add----button-------------------------------------
- (IBAction)addAction:(id)sender {
    //----pop------view-----fullscreen-----------
    AddClass *add=[self.storyboard instantiateViewControllerWithIdentifier:@"AddClass"];
    [self presentViewController:add animated:YES completion:Nil];
}

//-------------numeber----of------------section---------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//-------------numeber----of------------rows-----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tasks count];
}

//----------cell-----content-------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text=[[tasks objectAtIndex:indexPath.row] title];
        cell.imageView.image=[UIImage imageNamed:[[tasks objectAtIndex:indexPath.row] image]];
    
    return cell;
}

//----------------delete----------object----from table-------------------
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //---------------alert-----when delete  an object--------------------------------
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Delete" message:@"Do you want to delete this task ?" preferredStyle:UIAlertControllerStyleAlert];
    
    //--------yes button---------then delete object from array with animation--then arachive array--------
    UIAlertAction *yes=[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        if(editingStyle==UITableViewCellEditingStyleDelete){
            [tasks removeObjectAtIndex:indexPath.row];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSDate *data2=[NSKeyedArchiver archivedDataWithRootObject:tasks];
            [def setObject:data2 forKey:@"todo"];
        }
        
        [_tableOutlet reloadData];}
];
        //-----------no--------button------------------------
        UIAlertAction *no=[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
    
                [alert addAction:yes];
                [alert addAction:no];
                [self presentViewController:alert animated:YES completion:Nil];
    }
    
//-----------when select row -------navigate to edit page ------and can edit task-----------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //---------transfer--data to edit page---------------------------
    TaskClass *task=[TaskClass new];
    EditClass *edit=[self.storyboard instantiateViewControllerWithIdentifier:@"EditClass"];
    task.title=[[tasks objectAtIndex:indexPath.row] title];
    task.tstate=[[tasks objectAtIndex:indexPath.row] tstate];
    task.descrip=[[tasks objectAtIndex:indexPath.row] descrip];
    task.image=[[tasks objectAtIndex:indexPath.row] image];
    task.priorty=[[tasks objectAtIndex:indexPath.row] priorty];
    edit.edtask=task;
    edit.index = indexPath.row;
    edit.estate=@"ToDo";
    [self.navigationController pushViewController:edit animated:YES];
}

//- (void)viewWillLayoutSubviews{
//   cell.contentView.frame.size =  CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
//}

@end
