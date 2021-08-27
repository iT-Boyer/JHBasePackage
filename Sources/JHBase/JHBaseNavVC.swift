//
//  JHBaseNavVC.swift
//  JHBase
//
//  Created by lifei on 2021/8/26.
//

import UIKit

class JHBaseNavVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class JHBaseNavBar: UIView {
//    //标题
//    @property (nonatomic,strong) NSString * navTitle;
//    @property (nonatomic,strong) UIButton * backBtn;
//    //标题label
//    @property (nonatomic,strong) UILabel * titleLabel;
    //分割线label
//    @property (nonatomic,strong) UILabel * lineLabel;
//
//    //若使用本view，说明需要显示返回按钮，必须传target和SEL。
//    -(instancetype)initWithTitle:(NSString *)title andBackbtnAction:(SEL)action andBackBtnTarget:(id)target;
    
    lazy var titleLabel: UILabel = {
        let tmpLabelY = 20 + kStatusBarHeight
        let tmpLabelW = kScreenWidth - 120
        let tmpLabel = UILabel.init(frame: .init(x: 60, y: tmpLabelY, width: tmpLabelW, height: kNaviBarHeight))
        tmpLabel.font = .boldSystemFont(ofSize: 18)
        tmpLabel.textAlignment = .center
        return tmpLabel
    }()
    
    lazy var backBtn: UIButton = {
        let tmpBtn = UIButton.init(type: .custom)
        let tmpBtnY = 20 + kStatusBarHeight
        tmpBtn.frame = CGRect.init(x: 0, y: tmpBtnY, width: 60, height: 44)
        tmpBtn.contentEdgeInsets = .init(top: 11, left: 11, bottom: 11, right: 27)
        if let imgPath = Bundle.module.path(forResource: "arrow_left_dark", ofType: "png") {
            let btnImg = UIImage.init(named: imgPath)
            tmpBtn.setImage(btnImg, for: .normal)
        }
        return tmpBtn
    }()

}

//#pragma mark  ----  生命周期函数
//-(instancetype)initWithTitle:(NSString *)title andBackbtnAction:(SEL)action andBackBtnTarget:(id)target{
//    self = [super initWithFrame:CGRectMake(0, 0, MAINWIDTH, 64 + [JHLiveAdaptUI heightOfLiuHai])];
//    if (self) {
//
//        self.backgroundColor = [UIColor colorWithRed:252.0/255.0 green:252.0/255.0 blue:252.0/255.0 alpha:1];
//        [self addSubview:self.titleLabel];
//        [self addSubview:self.lineLabel];
//        self.navTitle = title;
//
//        if (target) {
//            [self.backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//            [self addSubview:self.backBtn];
//        }
//    }
//    return self;
//}
//
//
//#pragma mark  ----  SET
//-(void)setNavTitle:(NSString *)navTitle{
//
//    _navTitle = navTitle;
//    if (navTitle && navTitle.length > 0) {
//
//        self.titleLabel.text = navTitle;
//    }
//}
//
//#pragma mark  ----  懒加载
//
//-(UILabel *)titleLabel{
//    if (!_titleLabel) {
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20 + [JHLiveAdaptUI heightOfLiuHai], MAINWIDTH - 120, 44)];
//        _titleLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
//        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.text = @"";
//    }
//    return _titleLabel;
//}
//
//
//-(UIButton *)backBtn{
//    if (!_backBtn) {
//        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_backBtn setFrame:CGRectMake(0, 20 + [JHLiveAdaptUI heightOfLiuHai], 60, 44)];
//        _backBtn.contentEdgeInsets = UIEdgeInsetsMake(11, 11, 11, 27);
//        [_backBtn setImage:[UIImage imageNamed:@"JHUniversalResource.bundle/arrow_left_dark"] forState:UIControlStateNormal];
//    }
//    return _backBtn;
//}
//
//-(UILabel *)lineLabel{
//
//    if (!_lineLabel) {
//
//        _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 1)];
//        _lineLabel.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
//    }
//    return _lineLabel;
//}
