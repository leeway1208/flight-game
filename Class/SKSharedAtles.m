//
//  SKSharedAtles.m
//  SpriteKit
//
//  Created by Ray on 14-1-20.
//  Copyright (c) 2014年 CpSoft. All rights reserved.
//

#import "SKSharedAtles.h"

static SKSharedAtles *_shared = nil;
NSString *isDoubleBullet = @"1";


@implementation SKSharedAtles

+ (instancetype)shared{
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(doubleBulletAction:) name:@"doubleBullet" object:nil];

    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = (SKSharedAtles *)[SKSharedAtles atlasNamed:@"StockMarketAndLargeAircraft.atlasc"];
    });
   //NSLog(@"_shared-->%@" ,_shared);
    return _shared;
}


+(void)setDoubleBullet:(NSString*)type{

    if([type isEqualToString:@"2"]){
        isDoubleBullet = @"2";
    }else{
        isDoubleBullet = @"1";
    }
    

}


//-(void)doubleBulletAction:(NSNotification *)notification{
//    
//    
//    isDoubleBullet = (NSString *)[notification object];
//    
//}

+ (SKTexture *)textureWithType:(SKTextureType)type{
    

    
    switch (type) {
        case SKTextureTypeBackground:
            return [[[self class] shared] textureNamed:@"background.png"];
            break;
        case SKTextureTypeBullet:
            if ([isDoubleBullet isEqualToString:@"2"]) {
                
                return [[[self class] shared]
                        textureNamed:@"bullet2.png"];
                
            }else{
                return [[[self class] shared]
                        textureNamed:@"bullet.png"];
            }
          
            break;
        case SKTextureTypePlayerPlane:
            return [[[self class] shared] textureNamed:@"hero_fly_1.png"];
            break;
        case SKTextureTypeSmallFoePlane:
            return [[[self class] shared] textureNamed:@"enemy1_fly_1.png"];
            break;
        case SKTextureTypeMediumFoePlane:
            return [[[self class] shared] textureNamed:@"enemy2_fly_1.png"];
            break;
        case SKTextureTypeBigFoePlane:
            return [[[self class] shared] textureNamed:@"enemy3_fly_1.png"];
            break;
        case SKTextureTypeBomb:
            return [[[self class] shared] textureNamed:@"bomb_1.png"];
            break;
        case SKTextureTypeDoubleBullet:
            return [[[self class] shared] textureNamed:@"lvup.png"];
            break;
        default:
            break;
    }
    return nil;
}

#pragma mark -

+ (SKTexture *)bigPlaneTextureWithIndex:(int)index{
    return [[[self class] shared] textureNamed:[NSString stringWithFormat:@"enemy3_fly_%d.png",index]];
}

+ (SKTexture *)playerPlaneTextureWithIndex:(int)index{
    return [[[self class] shared] textureNamed:[NSString stringWithFormat:@"hero_fly_%d.png",index]];
}

+ (SKTexture *)playerPlaneBlowupTextureWithIndex:(int)index{
    return [[[self class] shared] textureNamed:[NSString stringWithFormat:@"hero_blowup_%d.png",index]];
}

#pragma mark -

+ (SKTexture *)hitTextureWithPlaneType:(int)type animatonIndex:(int)animatonIndex{
    
    return [[[self class] shared] textureNamed:[NSString stringWithFormat:@"enemy%d_hit_%d.png",type,animatonIndex]];
}

+ (SKTexture *)blowupTextureWithPlaneType:(int)type animatonIndex:(int)animatonIndex{
    
    return [[[self class] shared] textureNamed:[NSString stringWithFormat:@"enemy%d_blowup_%i.png",type,animatonIndex]];
}


#pragma mark -


+ (SKAction *)hitActionWithFoePlaneType:(SKFoePlaneType)type{
    
    switch (type) {
        case 1:
        {
            NSMutableArray *textures = [[NSMutableArray alloc]init];
            
            SKTexture *texture1 = [[self class] hitTextureWithPlaneType:2 animatonIndex:1];
            SKAction *action1 = [SKAction setTexture:texture1];
            
            SKTexture *texture2 = [[self class] textureWithType:SKTextureTypeBigFoePlane];
            SKAction *action2 = [SKAction setTexture:texture2];
            
            [textures addObject:action1];
            [textures addObject:action2];
            
            return [SKAction sequence:textures];
        }
            break;
        case 2:
        {
            NSMutableArray *textures = [[NSMutableArray alloc]init];
            for (int i = 1; i<=2; i++) {
                SKTexture *texture = [[self class] hitTextureWithPlaneType:2 animatonIndex:i];
                SKAction *action = [SKAction setTexture:texture];
                [textures addObject:action];
            }
            
            return [SKAction sequence:textures];
        }
            break;
        case 3:
        {
            NSMutableArray *textures = [[NSMutableArray alloc]init];
            for (int i = 1; i<=2; i++) {
                SKTexture *texture = [[self class] hitTextureWithPlaneType:3 animatonIndex:i];
                SKAction *action = [SKAction setTexture:texture];
                [textures addObject:action];
            }
            
            return [SKAction sequence:textures];

        }
            break;
            
        case 4:
        {
            
        }
        default:
            break;
    }
    return nil;
}

+ (SKAction *)blowupActionWithFoePlaneType:(SKFoePlaneType)type{
    switch (type) {
        case 1:
        {
            NSMutableArray *textures = [[NSMutableArray alloc]init];
            for (int i = 1; i <= 6; i++) {
                
                SKTexture *texture = [[self class] blowupTextureWithPlaneType:3 animatonIndex:i];
                [textures addObject:texture];
            }
            SKAction *dieAction = [SKAction animateWithTextures:textures timePerFrame:0.1];
            
            return [SKAction sequence:@[dieAction,[SKAction removeFromParent]]];
        }
            break;
        case 2:
        {
            NSMutableArray *textures = [[NSMutableArray alloc]init];
            for (int i = 1; i <= 4; i++) {
                
                SKTexture *texture = [[self class] blowupTextureWithPlaneType:2 animatonIndex:i];
                [textures addObject:texture];
            }
            SKAction *dieAction = [SKAction animateWithTextures:textures timePerFrame:0.1];
            
            return [SKAction sequence:@[dieAction,[SKAction removeFromParent]]];
        }
            break;
        case 3:
        {
            NSMutableArray *textures = [[NSMutableArray alloc]init];
            for (int i = 1; i <= 3; i++) {
                
                SKTexture *texture = [[self class] blowupTextureWithPlaneType:1 animatonIndex:i];
                [textures addObject:texture];
            }
            SKAction *dieAction = [SKAction animateWithTextures:textures timePerFrame:0.1];
            
            return [SKAction sequence:@[dieAction,[SKAction removeFromParent]]];
        }
            break;
            

        default:
            break;
    }
    return nil;
}

#pragma mark -

+ (SKAction *)bigPlaneAction{
    NSMutableArray *textures = [[NSMutableArray alloc]init];
    
    for (int i= 1; i<=1; i++) {
        SKTexture *texture = [[self class] bigPlaneTextureWithIndex:i];
        
        [textures addObject:texture];
    }
    return [SKAction repeatActionForever:[SKAction animateWithTextures:textures timePerFrame:0.1]];
}

+ (SKAction *)playerPlaneAction{
    NSMutableArray *textures = [[NSMutableArray alloc]init];
    
    for (int i= 1; i<=2; i++) {
        SKTexture *texture = [[self class] playerPlaneTextureWithIndex:i];
        
        [textures addObject:texture];
    }
   return [SKAction repeatActionForever:[SKAction animateWithTextures:textures timePerFrame:0.1]];
}

+ (SKAction *)playerPlaneBlowupAction{
    
    NSMutableArray *textures = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 4; i++) {
        
        SKTexture *texture = [[self class] playerPlaneBlowupTextureWithIndex:i];
        [textures addObject:texture];
    }
    SKAction *dieAction = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    return [SKAction sequence:@[dieAction,[SKAction removeFromParent]]];
}





@end
