#import <QuartzCore/QuartzCore.h>
#import "PullRefreshTableView.h"

#define REFRESH_HEADER_HEIGHT 52.0f

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

@implementation PullRefreshTableView

@synthesize textPull, textRelease, textLoading, refreshHeaderView, refreshTipsLabel, refreshDateLabel, refreshArrow, refreshSpinner;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupStrings];
    }
    return self;
}

//- (id)initWithStyle:(UITableViewStyle)style {
//  self = [super initWithStyle:style];
//  if (self != nil) {
//    [self setupStrings];
//  }
//  return self;
//}

- (NSString *)timestamp
{
    time_t now;
    time(&now);
    
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [dateFormatter setDateFormat:@"M月d日 H:mm"];
    }    
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:now];        

    return [NSString stringWithFormat:@"最后更新: %@",[dateFormatter stringFromDate:date]];

}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self != nil) {
    [self setupStrings];
  }
  return self;
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//  if (self != nil) {
//    [self setupStrings];
//  }
//  return self;
//}

//- (void)viewDidLoad {
//  [super viewDidLoad];
//  [self addPullToRefreshHeader];
//}

- (void)setupStrings{
  textPull = @"下拉可以刷新";
  textRelease = @"松开即可刷新";
  textLoading = @"正在读取⋯⋯";
}

- (void)addPullToRefreshHeader {
    refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0-REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
    refreshHeaderView.backgroundColor = [UIColor clearColor];

    refreshTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, REFRESH_HEADER_HEIGHT*2/3)];
    refreshTipsLabel.backgroundColor = [UIColor clearColor];
    refreshTipsLabel.font = [UIFont boldSystemFontOfSize:15.0];
    refreshTipsLabel.textAlignment = UITextAlignmentCenter;
    refreshTipsLabel.textColor = [UIColor grayColor];

    refreshDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, REFRESH_HEADER_HEIGHT*2/5, SCREENWIDTH, REFRESH_HEADER_HEIGHT*3/5)];
    refreshDateLabel.backgroundColor = [UIColor clearColor];
    refreshDateLabel.font = [UIFont boldSystemFontOfSize:12.0];
    refreshDateLabel.textAlignment = UITextAlignmentCenter;
    refreshDateLabel.textColor = [UIColor lightGrayColor];
    refreshDateLabel.text = [self timestamp];
    
    
    refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    refreshArrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT - 27) / 2),
                                    (floorf(REFRESH_HEADER_HEIGHT - 44) / 2),
                                    27, 44);

    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    refreshSpinner.hidesWhenStopped = YES;

    [refreshHeaderView addSubview:refreshTipsLabel];
    [refreshHeaderView addSubview:refreshDateLabel];
    [refreshHeaderView addSubview:refreshArrow];
    [refreshHeaderView addSubview:refreshSpinner];
    [self addSubview:refreshHeaderView];
    [self bringSubviewToFront:refreshHeaderView];
    //NSLog(@"refreshHeaderView x:%f y:%f",refreshHeaderView.frame.origin.x,refreshHeaderView.frame.origin.y);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoading) {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            self.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            self.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (isDragging && scrollView.contentOffset.y < 0) {
        // Update the arrow direction and label
        [UIView beginAnimations:nil context:NULL];
        if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
            // User is scrolling above the header
            refreshTipsLabel.text = self.textRelease;
            [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        } else { // User is scrolling somewhere within the header
            refreshTipsLabel.text = self.textPull;
            [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
        }
        [UIView commitAnimations];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading) return;
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
        // Released above the header
        [self startLoading];
    }
}

- (void)startLoading {
    isLoading = YES;

    // Show the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
    refreshTipsLabel.text = self.textLoading;
    refreshArrow.hidden = YES;
    [refreshSpinner startAnimating];
    [UIView commitAnimations];

    // Refresh action!
    [self onPullRefresh];
}

- (void)stopLoading {
    isLoading = NO;

    // Hide the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDidStopSelector:@selector(stopLoadingComplete:finished:context:)];
    self.contentInset = UIEdgeInsetsZero;
    [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    [UIView commitAnimations];
}

- (void)stopLoadingComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    // Reset the header
    refreshTipsLabel.text = self.textPull;
    refreshArrow.hidden = NO;
    refreshDateLabel.text = [self timestamp];
    [refreshSpinner stopAnimating];
}

- (void)onPullRefresh {
    // This is just a demo. Override this method with your custom reload action.
    // Don't forget to call stopLoading at the end.
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
}

//- (void)dealloc {
//    [refreshHeaderView release];
//    [refreshTipsLabel release];
//    [refreshArrow release];
//    [refreshSpinner release];
//    [textPull release];
//    [textRelease release];
//    [textLoading release];
//    [super dealloc];
//}

@end
