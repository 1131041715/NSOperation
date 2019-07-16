//
//  ViewController.m
//  NSOperation
//
//  Created by 大碗豆 on 17/5/15.
//  Copyright © 2017年 大碗豆. All rights reserved.
//

#import "ViewController.h"
#import "myOperation.h"

@interface ViewController ()

@property (nonatomic,strong)NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(100, 20, 100, 30);
    [btn setTitle:@"点我" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}


- (void)btnAction:(id)btn{
    NSLog(@"~~~~~~按钮被点了");
    
    
}



- (void)myOperation{
    myOperation *op = [[myOperation alloc] init];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:op];
    
    self.queue = queue;
}

//最大并发数量
- (void)concurrentCount{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    self.queue = queue;
    
    //默认-1 不限制开启线程数量 ，1 开启一个线程 相当于串行队列，2 先执行 1、2 在执行3、4 每次开启两个线程
    queue.maxConcurrentOperationCount = 2;
    
    [queue addOperationWithBlock:^{
        for (NSInteger i = 0; i < 5000 ; i ++) {
            NSLog(@"------1----%@",[NSThread currentThread]);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (NSInteger i = 0; i < 5000 ; i ++) {
            NSLog(@"------2----%@",[NSThread currentThread]);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (NSInteger i = 0; i < 5000 ; i ++) {
            NSLog(@"------3----%@",[NSThread currentThread]);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (NSInteger i = 0; i < 5000 ; i ++) {
            NSLog(@"------4----%@",[NSThread currentThread]);
        }
    }];
    
}


//挂起与取消
- (void)suspendAndCancel{
    
    //挂起和取消任务，只会影响后面的任务，不影响正在执行的任务
    
    if (self.queue.suspended) {
        self.queue.suspended = NO;
    }else{
        self.queue.suspended = YES;
    }
    
    //取消任务 ，不可恢复
    [self.queue cancelAllOperations];
    
}

- (void)dependOperation{
    
    //默认创建并行队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"------1----%@",[NSThread currentThread]);
    }];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"------2----%@",[NSThread currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"------3----%@",[NSThread currentThread]);
    }];
    //任务依赖  A依赖B，等B执行完之后，再去执行A ，任务之间不能相互依赖
    //前者依赖后者 后者执行完，再去执行前者
    [op1 addDependency:op];
    
    [queue addOperation:op];
    [queue addOperation:op1];
    [queue addOperation:op2];
    
}


- (void)operation1{
    //默认创建并行队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(action) object:nil];
    
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(action1) object:nil];
    
    [queue addOperation:op];
    [queue addOperation:op1];
    
    [queue addOperationWithBlock:^{
        NSLog(@"------3----%@",[NSThread currentThread]);
    }];
    
    
    //线程间的通信是从子线程回到主线程，进行UI的更新
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSLog(@"------4----%@",[NSThread currentThread]);
    }];
}



- (void)action{
    
    NSLog(@"------1----%@",[NSThread currentThread]);
    
}

- (void)action1{
    
    NSLog(@"------2----%@",[NSThread currentThread]);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
