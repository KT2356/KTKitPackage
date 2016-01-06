//
//  KTVideoPlayer.h
//  KTMediaPackageDemo
//
//  Created by KT on 16/1/4.
//  Copyright © 2016年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KTVideoPlayerDelegate <NSObject>
@required
- (void)KTVideoPlayerDidRotateToLandscape:(BOOL)isLandscape;
@end

@interface KTVideoPlayer : UIView
@property (nonatomic, weak) id <KTVideoPlayerDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame
                    urlString:(NSString *)urlString
                 loadingImage:(UIImage *)loadingImage;

@end
