//
//  JadeGCDViewController.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/3/1.
//

#import "JadeGCDViewController.h"
#import "JadeHomeTopTableViewCell.h"
@interface JadeGCDViewController ()

@end

@implementation JadeGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArr = @[@"同步执行 + 并发队列",@"异步执行 + 并发队列",@"同步执行 + 串行队列",@"异步执行 + 串行队列",@"同步执行 + 主队列",@"异步执行 + 主队列",
                      @"异步栅栏方法",@"同步栅栏方法",@"全局并发队列",@"全局串行队列",@"延迟执行代码",@"单利/只执行一次",@"快速迭代",@"队列组 dispatch_group",
    ];
    [self.tableView registerClass:[JadeHomeTopTableViewCell class] forCellReuseIdentifier:@"JadeHomeTopTableViewCell"];
    
}

- (void)learnQueue {
    // 创建队列
    dispatch_queue_t queue = dispatch_queue_create(@"queue", DISPATCH_QUEUE_CONCURRENT);
    // 主队列获取
    dispatch_queue_t queue1 = dispatch_get_main_queue();
    // 获取全局并发队列 队列的优先级
    dispatch_queue_t queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    // 同步执行任务创建方法
    dispatch_sync(queue, ^{
    // 同步执行代码
    });
    // 异步执行任务创建方法
    dispatch_async(queue, ^{
        // 异步执行代码
    });

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JadeHomeTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JadeHomeTopTableViewCell"];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",self.titleArr[indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self initQueue1];
            break;
        case 1:
            [self initQueue2];
            break;
        case 2:
            [self initQueue3];
            break;
        case 3:
            [self initQueue4];
            break;
        case 4:
            [self initQueue5];
            break;
        case 5:
            [self initQueue6];
            break;
        case 6:
            [self initQueue7];
            break;
        case 7:
            [self initQueue8];
            break;
        case 8:
            [self initQueue9];
            break;
        case 9:
            [self initQueue10];
            break;
        case 10:
            [self initQueue11];
            break;
        default:
            break;
    }
}


/// 同步执行 + 并发队列
- (void)initQueue1 {
    
    NSLog(@"当前线程 - %@",[NSThread currentThread]);
    NSLog(@"1");
    
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2 - %@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3 - %@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"4 - %@",[NSThread currentThread]);
    });
    
    NSLog(@"5");
    
}

/// 异步执行 + 并发队列
- (void)initQueue2 {
    
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1 - %@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2 - %@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3 - %@",[NSThread currentThread]);
    });
    
    NSLog(@"4");
    
}

/// 同步执行 + 串行队列
- (void)initQueue3 {
    
    NSLog(@"当前线程 - %@",[NSThread currentThread]);
    NSLog(@"1");
    
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2 - %@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3 - %@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"4 - %@",[NSThread currentThread]);
    });
    
    NSLog(@"5");
    
}

/// 异步执行 + 串行队列
- (void)initQueue4 {
    
    NSLog(@"当前线程 - %@",[NSThread currentThread]);
    NSLog(@"1");
    
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2 - %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3 - %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"4 - %@",[NSThread currentThread]);
    });
    
    NSLog(@"5");
    
}


/// 主线程调用 同步执行 + 主队列
- (void)initQueue5 {
    
    NSLog(@"当前线程 - %@",[NSThread currentThread]);
    [NSThread detachNewThreadSelector:@selector(syncMain) toTarget:self withObject:nil];
    
    [NSThread sleepForTimeInterval:6];
    NSLog(@"1");
    
//    dispatch_queue_t queue = dispatch_get_main_queue();
//
//    dispatch_sync(queue, ^{
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"2 - %@",[NSThread currentThread]);
//    });
}

- (void)syncMain {
    
    NSLog(@"currentThread - %@",[NSThread currentThread]);
    NSLog(@"1");
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2 - %@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3 - %@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"4 - %@",[NSThread currentThread]);
    });
    
    NSLog(@"5");
    
}

/// 异步执行 + 主线程
- (void)initQueue6 {
    
    NSLog(@"currentThread - %@",[NSThread currentThread]);
    NSLog(@"1");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2 - %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3 - %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"4 - %@",[NSThread currentThread]);
    });
    
    NSLog(@"5");
}

/// 异步栅栏方法
- (void)initQueue7 {
    
    NSLog(@"当前线程 - %@",[NSThread currentThread]);
    NSLog(@"1");
    
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2 - %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3 - %@",[NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"barrier - %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"4 - %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"5 - %@",[NSThread currentThread]);
    });
    
    NSLog(@"6");
}

/// 同步栅栏方法
- (void)initQueue8 {
    
    NSLog(@"当前线程 - %@",[NSThread currentThread]);
    NSLog(@"1");
    
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2 - %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3 - %@",[NSThread currentThread]);
    });
    
    dispatch_barrier_sync(queue, ^{
        NSLog(@"barrier - %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"4 - %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"5 - %@",[NSThread currentThread]);
    });
    
    NSLog(@"6");
}

/// 全局并发队列
- (void)initQueue9 {
    
    NSLog(@"当前线程 - %@",[NSThread currentThread]);
    NSLog(@"1");
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_async(queue, ^{
        NSLog(@"2 - %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"3 - %@",[NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"barrier - %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"4 - %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"5 - %@",[NSThread currentThread]);
    });
    
    NSLog(@"6");
    
}

/// 全局串行队列
- (void)initQueue10 {
    
    NSLog(@"当前线程 - %@",[NSThread currentThread]);
    NSLog(@"1");
    
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        NSLog(@"2 - %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"2 - %@",[NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"barrier - %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"4 - %@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"5 - %@",[NSThread currentThread]);
    });
    
    NSLog(@"6");
}

/// 延迟执行
- (void)initQueue11 {
    
    NSLog(@"1");
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"after - %@",[NSThread currentThread]);
    });
    NSLog(@"2");
}

/// 单利/只执行一次代码
- (void)initQueue12 {
    
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"onece");
    });
}


/// 快速迭代
- (void)initQueue13 {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    NSLog(@"1");

    dispatch_apply(10, queue, ^(size_t iteration) {
        NSLog(@"%zd - %@",iteration,[NSThread currentThread]);
    });
    
    NSLog(@"2");
}

/// 队列组
- (void)initQueue14 {
    
}
@end
