//
//  MyCustomCell.m
//  CustomCellExample
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize view;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
}

- (void)setView:(UIView *)aView {
	
	if (view)
		[view removeFromSuperview];
	view = aView;
	//[self.view retain];
	[self.contentView addSubview:aView];
	
	[self layoutSubviews];
}

- (void)layoutSubviews {
	
	[super layoutSubviews];
    CGRect contentRect = [self.contentView bounds];
    view.frame = contentRect;
}

- (void)dealloc {
    view=nil;
	[view release];
    [super dealloc];
}

@end

