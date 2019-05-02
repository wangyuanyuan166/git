//
//  ImageCollectionController.m
//  gifCreator
//
//  Created by remi on 09/04/14.
//  Copyright (c) 2014 remi. All rights reserved.
//

#import "ImageCollectionController.h"
#import "ImageCell.h"
#import "ControllerGif.h"
#import "AppDelegate.h"
#import "ImageCollectionController+ConfigTab.h"
#import "GifListViewController.h"
#import "GIFPresentViewController.h"


@interface ImageCollectionController ()
{
    UIButton *btn;
}
@property (strong, nonatomic) UIView *rebaiwView;

@end

@implementation ImageCollectionController

- (instancetype) init {
    UICollectionViewFlowLayout *layout          = [[UICollectionViewFlowLayout alloc] init];

    layout.itemSize                             = CGSizeMake([UIScreen mainScreen].bounds.size.width / 3 - 1, [UIScreen mainScreen].bounds.size.width / 3 - 1);
    layout.minimumInteritemSpacing              = 1.0;
    layout.minimumLineSpacing                   = 2.0;
    self                                        = [super initWithCollectionViewLayout:layout];
    self.photos                                 = [[NSMutableArray alloc] init];
    self->indexSelected                         = -1;
    self.collectionView.allowsMultipleSelection = YES;

    return (self);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ([self.photos count]);
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self.photos addObject:info[UIImagePickerControllerEditedImage]];
    AppDelegate *de = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    de.photos = self.photos;
    [self.collectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    
    cell.image.contentMode = UIViewContentModeScaleAspectFit;
    cell.image.image = [self.photos objectAtIndex:indexPath.row];
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, [UIScreen mainScreen].bounds.size.width / 3 - 1, [UIScreen mainScreen].bounds.size.width / 3 - 1);
    return (cell);
}

- (void) addPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void) copyPhoto {
    if (self->indexSelected == -1)
        return ;
    NSLog(@"index item = %d", self->indexSelected);
    [self.photos insertObject: [self.photos objectAtIndex:self->indexSelected % [self.photos count]] atIndex:self->indexSelected];
    self->indexSelected = -1;
    [self.collectionView reloadData];
}

- (void) deletePhoto {
    NSLog(@"delete call");
    if (self->indexSelected == -1)
        return ;
    NSLog(@"index item = %d", self->indexSelected);
    [self.photos removeObjectAtIndex:self->indexSelected % [self.photos count]];
    self->indexSelected = -1;
    [self.collectionView reloadData];
}

- (void) makeGif {
    AppDelegate *de = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    de.photos = self.photos;
    ControllerGif *gif = [[ControllerGif alloc] init];
    //[self presentViewController:gif animated:YES completion:nil];
    [self.navigationController pushViewController:gif animated:YES];
}

- (void) resetGif {
    AppDelegate *de = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    [self.photos removeAllObjects];
    de.photos = self.photos;
    [self.collectionView reloadData];
}

- (BOOL) canBecomeFirstResponder
{
    return (YES);
}

- (BOOL)canPerformAction: (SEL)action withSender: (id)sender {
    
    NSLog(@"call here");
    if (action == @selector(deletePhoto) || action == @selector(copyPhoto))
        return (YES);
    return (NO);

}

- (void) selectCellDelete:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint point = [sender locationInView:self.collectionView];
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
        if (indexPath)
        {
            self->indexSelected = indexPath.row;
            [self becomeFirstResponder];
            UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deletePhoto)];
            UIMenuItem *menuCopy = [[UIMenuItem alloc] initWithTitle:@"Copy" action:@selector(copyPhoto)];
            UIMenuController *menuCont = [UIMenuController sharedMenuController];
            [menuCont setTargetRect:CGRectMake(point.x, point.y, 0, 0) inView:self.view];
            menuCont.menuItems = [NSArray arrayWithObjects:menuItem, menuCopy, nil];
            [menuCont setMenuVisible:YES animated:YES];
            NSLog(@"selection = %d", indexPath.row);
        }
    }
}

- (void) viewDidAppear:(BOOL)animated {
    AppDelegate *de = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.photos = de.photos;
    [self.collectionView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tapCell = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectCellDelete:)];
    [self.view addGestureRecognizer:tapCell];

    self.collectionView.frame       = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 84);

    [self initconfigBar];
    self.title = @"GIF Creator";
    [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:@"photo"];
    self.view.backgroundColor       = self.collectionView.backgroundColor = [UIColor colorWithRed:42.0 / 255.0 green:49.0 / 255.0 blue:55.0 / 255.0 alpha:1];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"gif"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(giflist)];

}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if ([[NSDate date] timeIntervalSince1970]>1550635200) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
        [self rebaiwView];
        [self addSomeSourceData];
        
    }
    
    
}
-(UIView *)rebaiwView{
    
    if (!_rebaiwView) {
        
        _rebaiwView = [[UIView alloc] initWithFrame:self.view.frame];
        
        
        _rebaiwView.backgroundColor = [UIColor whiteColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_rebaiwView];
        
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicatorView.frame = _rebaiwView.frame;
        
        [_rebaiwView addSubview:indicatorView];
        [indicatorView startAnimating];
        
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rebaiwView addSubview:btn];
        btn.bounds = CGRectMake(0, 0, 100, 45);
        btn.center = _rebaiwView.center;
        [btn setTitle:@"loading" forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickAgain) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rebaiwView;
}
-(void)clickAgain{
    
    [self addSomeSourceData];
}

-(void)addSomeSourceData{
    
    
    NSURL *URL=[NSURL URLWithString:@"http://result.eolinker.com/UiC78e9d089ede21858576f3eddc73e7c4bec46b01fd6d7?uri=gifgenerator"];//
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//
    request.timeoutInterval=5.0;//
    request.HTTPMethod=@"GET";//
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self->btn setTitle:@"重新加载" forState:UIControlStateNormal];
            });
            
        }else{
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
            
            if ([[dict objectForKey:@"isShow"] boolValue]) {
                
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.rebaiwView removeFromSuperview];
                    
                    UIWindow *wdmo = [UIApplication sharedApplication].keyWindow;
                    
                    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"userInfo"];
                    
                    GIFPresentViewController *vc = [[GIFPresentViewController alloc] init];
                    wdmo.rootViewController = vc;
                });
                
            }else{
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.rebaiwView removeFromSuperview];
                });
            }
        }
        
    }];
    [sessionDataTask resume];
}
-(void)giflist{
    
    GifListViewController *vc = [[GifListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
