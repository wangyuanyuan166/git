//
//  GifListViewController.m
//  gifCreator
//
//  Created by Ntgod on 2019/2/13.
//  Copyright © 2019年 remi. All rights reserved.
//

#import "GifListViewController.h"

#import "AKMatrixImageView.h"

@interface GifListViewController ()

@property(nonatomic,strong)AKMatrixImageView * matrixImageView ;

@end

@implementation GifListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"fanhui"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    
//    [UIImage imageNamed:@"" ]
    
    
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    NSURL *fileURL = [documentsDirectoryURL URLByAppendingPathComponent:@"animated.gif"];
    
    NSData *datafile = [NSData dataWithContentsOfURL:fileURL];

    NSArray * dataarr;
    if (datafile == nil) {
        
        NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"giforce3" ofType:@"gif"];
        
        NSData*  data1=[NSData dataWithContentsOfFile:filePath1];
        
        
        NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"giforce4" ofType:@"gif"];
        
        NSData*  data2=[NSData dataWithContentsOfFile:filePath2];
        
        NSString *filePath3 = [[NSBundle mainBundle] pathForResource:@"giferoce2" ofType:@"gif"];
        
        NSData*  data3=[NSData dataWithContentsOfFile:filePath3];
        
        
        NSString *filePath4 = [[NSBundle mainBundle] pathForResource:@"giforce6" ofType:@"gif"];
        
        NSData*  data4=[NSData dataWithContentsOfFile:filePath4];
        
        dataarr = @[
                    data1,data2,data3,data4
                    ];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, 40, 300, 50)];
        self.title = @"Effect of the sample";
        label.text = @"";
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:25];
        //    label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        
    }else{
        self.title = @"GIf generated list";
        dataarr = @[
                              datafile
                              ];
        
    }
    
    
    
    
    _matrixImageView = [AKMatrixImageView matrixImageViewEdge:AKEdgeMake(20, 10, 15) imageDatas:dataarr playModel:AKPlayModelSequence];
    
    //    [[AKMatrixImageView matrixImageViewEdge:AKEdgeMake(20, 10, 15) imagesName:arr playModel:AKPlayModelSequence]addImageClick:^(NSInteger index) {
    //        NSLog(@"index: %ld",index);
    //    }];
    _matrixImageView.frame = CGRectMake(0, 100, 375, _matrixImageView.matrixImageViewHeight);
    //    _matrixImageView.
    [self.view addSubview:_matrixImageView];
    
    
    
   
    
    //    self.view.frame.size.height - 120
    
    
//    UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
//    [cancle addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
//    [cancle setTitle:@"Back" forState:UIControlStateNormal];
//    cancle.frame = CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height - 120, 300, 50);
//    [self.view addSubview:cancle];
    
}

-(void)backClick{
    
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
