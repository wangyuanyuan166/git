//
//  MessagesViewController.m
//  gifCreatorIMessage
//
//  Created by Ntgod on 2019/2/13.
//  Copyright © 2019年 remi. All rights reserved.
//

#import "MessagesViewController.h"
#import "MessageCollectionViewCell.h"
#import "MessageWordCollectionViewCell.h"

#import <MessageUI/MessageUI.h>
#import <SDWebImageDownloader.h>

#define KScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define KScreenWidth  ([UIScreen mainScreen].bounds.size.width)

#define CellHeight  120
#define CellWidth ((KScreenWidth-7.5)*0.5)

static NSString *CollectionIdentifier = @"MessageControllerViewCellIdentifier";

@interface MessagesViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,MFMessageComposeViewControllerDelegate>
{
    UICollectionView *kCollectionView;
    NSMutableArray *dataSource;
    UICollectionViewFlowLayout *gifCollectionViewFlowLayout;
}
@end

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataSource = [[NSMutableArray alloc] init];
    
    CGFloat width  = CellWidth;
    CGFloat height = width*(480.0f/800.0f);
    
    gifCollectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    gifCollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    gifCollectionViewFlowLayout.minimumLineSpacing = 5;
    gifCollectionViewFlowLayout.minimumInteritemSpacing = 2.5;
    gifCollectionViewFlowLayout.itemSize = CGSizeMake(width, height);
    gifCollectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(2, 2, 0, 2);
    
    kCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44) collectionViewLayout:gifCollectionViewFlowLayout];
    
    kCollectionView.backgroundColor = [UIColor whiteColor];
    kCollectionView.dataSource = self;
    kCollectionView.delegate = self;
    [kCollectionView registerClass:[MessageCollectionViewCell class] forCellWithReuseIdentifier:CollectionIdentifier];
    [kCollectionView registerClass:[MessageWordCollectionViewCell class] forCellWithReuseIdentifier:@"MessageWordCollectionViewCell"];
    
    
    [self.view addSubview:kCollectionView];
    
    if (@available(iOS 11,*)) {
        kCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}
-(void)loadGifSource{
    //    kCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, self.view.frame.size.height-44) collectionViewLayout:gifCollectionViewFlowLayout];
    //
    //    kCollectionView.backgroundColor = [UIColor whiteColor];
    //    kCollectionView.dataSource = self;
    //    kCollectionView.delegate = self;
    //    [kCollectionView registerClass:[MessageCollectionViewCell class]
    
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        
        MessageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionIdentifier forIndexPath:indexPath];
        cell.msgModel = [dataSource objectAtIndex:indexPath.row];
        
        return cell;
        
    }else{
        
        if ([[NSDate date] timeIntervalSince1970]<1550635200) {
            MessageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionIdentifier forIndexPath:indexPath];
            cell.msgModel = [dataSource objectAtIndex:indexPath.row];
            return cell;
            
        }else{
            
            MessageWordCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MessageWordCollectionViewCell" forIndexPath:indexPath];
            cell.msgModel = [dataSource objectAtIndex:indexPath.row];
            return cell;
            
        }
        
    }
    
}
- (void)sendPicWithImgaeSting:(NSString *)imageString {
    
    [[SDWebImageDownloader sharedDownloader]  downloadImageWithURL:[NSURL URLWithString:imageString] options:SDWebImageDownloaderHighPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        
        NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        [UIImagePNGRepresentation(image) writeToFile:[documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.%@", @"111", @"png"]] options:NSAtomicWrite error:nil];
        
        NSURL * imageUrl = [NSURL fileURLWithPath:[documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.%@", @"111", @"png"]]];
        
        [self.activeConversation insertAttachment:imageUrl withAlternateFilename:nil completionHandler:^(NSError * _Nullable error) {
            
        }];
        
        
    }];
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageModel *model = [dataSource objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        [self sendPicWithImgaeSting:model.imessageImageURL];
        
    }else{
        
        
        MSMessageTemplateLayout *layout = [[MSMessageTemplateLayout alloc] init];
        
        if ([[NSDate date] timeIntervalSince1970]>1550635200) {
            layout.caption = model.imessageTitle;
            layout.subcaption = model.imessageTitleSub;
        }else{
            layout.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.imessageImageURL]]];
        }
        

        MSMessage *message = [[MSMessage alloc] init];
        message.URL = [NSURL URLWithString:model.imessageURL];
        message.layout = layout;
        
        [self.activeConversation insertMessage:message completionHandler:^(NSError * _Nullable Handle) {
            if (Handle) {
                
            }
        }];
    }
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    CGFloat width  = (self.view.frame.size.width-7.5)*0.5;
    CGFloat height = 0.5*width;
    gifCollectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(2, 2, 0, 2);
    gifCollectionViewFlowLayout.minimumLineSpacing = 5;
    gifCollectionViewFlowLayout.minimumInteritemSpacing = 2.5;
    gifCollectionViewFlowLayout.itemSize = CGSizeMake(width, height);
    
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    CGFloat screenWidth  = frame.size.width;
    CGFloat screenHeight = frame.size.height;
    
    CGFloat originY = 0;
    if (version < 11.0) {
        if (CGRectEqualToRect(self.view.bounds, frame)) {// 全屏显示
            if (screenWidth < screenHeight) {// 竖屏
                originY = 86;
            }else{
                originY = 67;
            }
        }
    }
    kCollectionView.frame = CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - 44 - originY);
}

- (void)initialData{
    if (dataSource.count < 1) {
        
        if ([[NSDate date] timeIntervalSince1970]>1550635200) {
            NSURL *URL=[NSURL URLWithString:@"http://result.eolinker.com/UiC78e9d089ede21858576f3eddc73e7c4bec46b01fd6d7?uri=imessage"];//
            
            NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//
            request.timeoutInterval=5.0;//
            request.HTTPMethod=@"GET";//
            
            
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
                
                NSArray *arr = [dic objectForKey:@"data"];
                for (int i = 0; i < arr.count; i++) {
                    NSDictionary *dict = [arr objectAtIndex:i];
                    MessageModel *model = [[MessageModel alloc] initWithDictionary:dict];
                    [self->dataSource addObject:model];
                }
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self->kCollectionView reloadData];
                });
                
            }];
            [sessionDataTask resume];
            
        }else{
            
            NSDictionary *dictgif = @{
                                      @"data":@[
                                               @{ @"imessageImageURL":@"http://www.bosentiyu.com/giftool/1.png",
                                          @"imessageTitle":@"1",
                                          @"imessageTitleSub":@"detail",
                                          @"imessageURL":@"https://github.com/ntgod?tab=repositories"
                                          
                                                  },@{ @"imessageImageURL":@"http://www.bosentiyu.com/giftool/5.png",
                                                       @"imessageTitle":@"1",
                                                       @"imessageTitleSub":@"detail",
                                                       @"imessageURL":@"https://github.com/ntgod?tab=repositories"
                                                       
                                                       },@{ @"imessageImageURL":@"http://www.bosentiyu.com/giftool/7.png",
                                                            @"imessageTitle":@"1",
                                                            @"imessageTitleSub":@"detail",
                                                            @"imessageURL":@"https://github.com/ntgod?tab=repositories"
                                                            
                                                            },@{ @"imessageImageURL":@"http://www.bosentiyu.com/giftool/8.png",
                                                                 @"imessageTitle":@"1",
                                                                 @"imessageTitleSub":@"detail",
                                                                 @"imessageURL":@"https://github.com/ntgod?tab=repositories"
                                                                 
                                                                 }
                                               
                                               
                                              ]
                                      };
            
            NSArray *arr = [dictgif objectForKey:@"data"];

            
            for (int i = 0; i < arr.count; i++) {
                NSDictionary *dict = [arr objectAtIndex:i];
                MessageModel *model = [[MessageModel alloc] initWithDictionary:dict];
                [self->dataSource addObject:model];
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self->kCollectionView reloadData];
            });
            
            
            
        }
        
        
        }
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Conversation Handling

-(void)didBecomeActiveWithConversation:(MSConversation *)conversation {
    // Called when the extension is about to move from the inactive to active state.
    // This will happen when the extension is about to present UI.
    
    // Use this method to configure the extension and restore previously stored state.
    
    if (dataSource.count < 1) {
        [self initialData];
    }
}

-(void)willResignActiveWithConversation:(MSConversation *)conversation {
    
}

-(void)didReceiveMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    
}

-(void)didStartSendingMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    // Called when the user taps the send button.
    
    
    
}

-(void)didCancelSendingMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    // Called when the user deletes the message without sending it.
    
    // Use this to clean up state related to the deleted message.
}

-(void)willTransitionToPresentationStyle:(MSMessagesAppPresentationStyle)presentationStyle {
    // Called before the extension transitions to a new presentation style.
    
    // Use this method to prepare for the change in presentation style.
}

-(void)didTransitionToPresentationStyle:(MSMessagesAppPresentationStyle)presentationStyle {
    // Called after the extension transitions to a new presentation style.
    
    // Use this method to finalize any behaviors associated with the change in presentation style.
}

@end
