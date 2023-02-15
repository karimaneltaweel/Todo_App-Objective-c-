//
//  TaskClass.m
//  workshop
//
//  Created by kariman eltawel on 17/01/2023.
//

#import "TaskClass.h"

@implementation TaskClass

- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:_title forKey:@"title"];
    [coder encodeObject:_descrip forKey:@"descrip"];
    [coder encodeObject:_image forKey:@"image"];
    [coder encodeObject:_Datee forKey:@"date"];
    [coder encodeObject:_priorty forKey:@"priorty"];
    [coder encodeObject:_tstate forKey:@"state"];
    
}

- (instancetype)initWithCoder:(NSCoder *)coder{
   _title= [coder decodeObjectForKey:@"title"];
  _descrip= [coder decodeObjectForKey:@"descrip"];
   _image= [coder decodeObjectForKey:@"image"];
    _Datee= [coder decodeObjectForKey:@"date"];
    _priorty=[coder decodeObjectForKey:@"priorty"];
    _tstate=[coder decodeObjectForKey:@"state"];
    return self;
}
@end
