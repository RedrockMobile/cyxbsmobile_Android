//
//  LearnMoreViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/12/18.
//  Copyright © 2020 Redrock. All rights reserved.
//关于我们页面 - 服务协议/隐私条款

#import "LearnMoreViewController.h"
//是否开启CCLog
#define CCLogEnable 0

@interface LearnMoreViewController () <UITextViewDelegate>
@property(nonatomic,strong)UILabel *subTitleLabel;
@property(nonatomic,strong)UITextView *mainBodyTextView;
@end

@implementation LearnMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithType:(LMVCType)type{
    self = [super init];
    if (self) {
        
        //父类是TopBarBasicViewController，调用父类的vcTitleStr的set方法，自动完成顶部的bar的设置
        if(type==LMVCTypePrivacyClause){
            self.VCTitleStr = @"隐私政策";
        }else{
            self.VCTitleStr = @"掌上重邮软件许可及服务协议";
        }
        [self addSubTitleLabel];
    }
    
    return self;
}

- (void)addSubTitleLabel {
    UILabel *label = [[UILabel alloc] init];
    self.subTitleLabel = label;
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0.0427*SCREEN_WIDTH);
        make.top.equalTo(self.topBarView.mas_bottom).offset(0.0667*SCREEN_WIDTH);
    }];
    
    label.text = @"【首部及导言】";
    
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    
    label.font = [UIFont fontWithName:PingFangSCSemibold size:15*fontSizeScaleRate_SE];
    
    [self addMainBodyTextView];
}

- (void)addMainBodyTextView {
    UITextView *view = [[UITextView alloc] init];
    [self.view addSubview: view];
    self.mainBodyTextView = view;
    
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.subTitleLabel.mas_bottom).offset(10);
    }];
    
    
    view.text =
    @"1.导言\n\t欢迎您使用“掌上重邮”手机app相关服务，为了您可以方便、顺利地使用本产品相关服务，特列出本协议条款，请您在开始使用“掌上重邮”前，认真阅读并充分理解本协议。若您不同意本协议，意味着我们无法为您提供本产品的相关功能和服务。在接受本协议条款且符合登录资格后，您方可登录、使用本产品的相关功能和服务。\n2.账号登录\n\t2.1\n\t鉴于掌上重邮通过重庆邮电大学学号+密码的登录方式，若您为重庆邮电大学校内学生且获得了相关的学号信息，方可通过学号+密码(身份证后六位)进行登录，登录成功后方可使用本产品的相关功能和服务。\n\t2.2\n\t在用户第一次登录后，默认用户授权本产品使用用户相关学生信息(学号+密码)通过合法途径对校内相关信息网站进行访问，获取相关信息。\n\t2.3\n\t本产品部分功能需使用重庆邮电大学所提供的统一认证码进行身份认证登录后才可使用，具体登录入口于产品内，采用统一认证码认证后可使用更多产品功能，不影响基础功能的使用。\n\t2.4\n\t本产品账号采用和重庆邮电大学教务处所提供的学号一致，本产品不提供和不保障相关账号的密码找回会、密码修改等服务功能。\n\t2.5\n\t用户应妥善保管个人账号密码信息，谨交由他人使用或使用他人账户信息，个人设备，如用户由于个人保管不当造成损失的，本产品不会承担任何责任。\n3.账号互通\t\n本产品由红岩网校工作站开发、维护，为了给您给好的产品体验，本产品相关用户信息与内容将与红岩网校工作站微信公众号“重邮小帮手”互通，在此特作以下几点说明。\n\t3.1\n\t若您在使用本产品前通过微信授权成功绑定“重邮小帮手”微信公众号，您的相关个人信息:包括但不限于微信昵称、头像等将被我们所获悉，这代表您同意我们使用您的相关信息。在此会出现以下特殊情况:如果没有对掌上重邮APP上的头像进行自主修改，那么您的头像将默认为是微信头像，自主修改个人头像头，会将其优先设置为您在掌上重邮APP上的个人头像。\n\t3.2\n\t若您在使用本产品前未绑定“重邮小帮手”微信公众号，那么您的默认头像将会被设置为系统内置默认头像，您可以自主修改个人头像，用户修改的头像将会优先设置为您在掌上重邮APP上的个人头像。\n4.功能授权\n\t4.1\n\t经您同意后，本软件可以调用您所使用终端设备的相关权限和接口，如GPS、相册、相机等以顺利使用本产品的相关功能。\n5.邮问社区\n\t邮问力争打造一个重邮校园内的问答知识社区，感谢您参与其中为社区的建设做出贡献，在社区的功能使用、内容发布、回答互动等行为中，您需要遵循以下几点准则以营造一个健康的知识社区。\n\t5.1\n\t用户通过掌上重邮app所制作，上传，发布，复制，传播的任何内容，形式包括但不限于账号头像、昵称、个性签名、社区发布提问内容、社区回答、社区评论等一切以图片、文字、链接、视频为载体的内容，不得违反国家相关法律制度规定，内容包括但不限于以下几点原则\n\t5.1.1不得危害国家安全，泄露国家秘密，颠覆国家政杈，破坏国家统一\n\t5.1.2不得损害国家荣誉和利益\n\t5.1.3不得散布谣言，扰乱社会秩序，破环社会稳定\n\t5.1.4不得散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪\n\t5.1.5不得侮辱或者诽谤他人，侵害他人合法权益\n\t5.1.6不得含有法律、行政法规禁止的其他内容\n\t5.2\n\t用户不可通过本产品传播、制作、上传、发布等干扰本APP正常运营，以及侵犯其他用户的合法权益的内容，内容包括但不限于以下几点原则:\n\t5.2.1不得含有任何性暗示内容\n\t5.2.2不得含有辱骂、恐吓、威胁内容\n\t5.2.3不得含有骚扰、垃圾广告、恶意信息、诱骗信息\n\t5.2.4不得涉及他人隐私、个人信息和资料\n\t5.2.5不得侵害他人名誉权、肖像权、知识产权等合法权益\n\t5.2.6不得含有其他干扰本产品服务正常运营内容\n\t5.2.7不得通过本产品泄露他人信息\n\t5.3\n\t在表达自己的困惑、需求帮助，在对问题进行解答，与其他用户进行讨论时，我们推崇友好、和谐、互助的理念，用户不可出现破坏社区氛围的行为，内容包括但不限于以下几点原则:\n\t5.3.1不得通过社区进行漫骂、争吵\n\t5.3.2不得轻视、诋毁他人劳动成功\n\t5.3.3不得捏造、传播虚假回答\n\t5.3.4不得用夸张、侮辱性的语句对他人进行挑衅和嘲讽以此来激怒他人\n\t5.3.5不得对他人的能力进行评价，使对方难堪\n\t5.3.6不得故意通过编造提问和回答进行积分的转换\n\t5.3.7不得发布具有煽动情绪的提问、回答和评论\n\t5.3.8不得通过本平台发布垃圾广告\n\t5.3.9不得转载他人的原创回答内容\n\t5.4\n\t对违反以上条例中相关原则的用户，掌上重邮有权力采取删除相关内容，对违反规则用户进行警告、暂停甚至中止用户账号使用权限等措施。\n\t5.5\n\t邮问社区环境依靠每一个参与进来的爱问爱答知识人，掌邮鼓励和请求大家共同参与进来，维护良好社区氛围，坚决打击不良社区行为。本产品拥有快速对提问、回答和评论进行举报的入口，成功有效的举报有害内容的用户可获得掌邮的相关奖励。\n\t5.6\n\t邮问知识社区保障每个积极参与的用户的知识产权，严禁一切用户在未经创作者允许授权的情况下，引用，复制相关产出内容用于其他途径。\n\t5.7\n\t邮问社区匿名板块内的所有提问、回答和评论内容将隐藏用户个人头像、昵称等内容，但掌邮仍可透明监管每个用户的情况，严禁用户通过该板块发布、传播一切违反上诉相关原则的内容。\n\t5.8\n\t掌上重邮不能对邮问社区用户发表的提问和回答的正确性进行保证，用户的提问、回答和评论仅表明其个人立场和观点，掌上重邮不承担任何相关责任。\n6.积分与打赏\t积分是本产品内的产物，具有时效性，用户通过签到、产品内相关活动、邮问优质回答等途径获取积分，积分是用户在邮问社区友好往来，按时打卡的认证，用户可通过积分兑换相应的奖励，奖励将不定期限量更新。在此对积分相关使用规则进行说明。\n\t6.1\n\t您对您所获得的积分拥有的操作权力包括:邮问提问设置悬赏积分设置，积分商城积分兑换相应奖励等。一旦确认操作:选取优质回答悬赏积分、进行积分兑换后流出的积分将不可撤销。若用户通过不正当的途径赚取、盗刷积分，本产品拥有收回积分的权力。\n\t6.2\n\t悬赏积分:悬赏积分的设置是驱动用户提供优质回答的途径，用户将通过设置一定数额的悬赏积分来发布问题，用户拥有自主选择悬赏积分的权力(最低为1积分)，为了使您的回答得到更快速地解答，用户将主动为提问设置一个任务最晚完成时间，在一定的时间内，用户可以主动的对回答进行筛选，选择您认为最有帮助的解答，通过点击“采纳”按钮将个人悬赏积分赏给用户，若超过任务最晚完成时间后，用户未主动采纳回答，系统将通过判断最多获赞的答案默认将悬赏积分分配给回答者，若出现无最多获赞的回答，则将退回用户的悬赏积分。\n\t6.3\n\t严禁用户通过多个账号进行恶意提问和回答等行为以达到积分转移、制造话题、博取眼球等目的，一经查实，本产品拥有对相关账号实施警告、暂停服务甚至禁用账号的权力。\n\t6.4\n\t通过相关系统bug对积分数量、积分兑换条件等进行篡改以谋取利益的行为，一经查实，本产品将对相关用户账号进行封禁措施。\n\t6.5\n\t为了积分制度的健康发展，用户可在产品相关积分兑换活动时校内，通过积分进行兑换相关奖励，原则上，系统会对积分做定期的清零更新，积分系统的更新周期在一年(两学期)。\n7.信息安全\n\t本产品所收集到的相关信息都以为用户提供相关服务为目的，特此承诺不会泄露用户个人信息隐私，部分公开信息特此说明。\n\t7.1\n\t掌上重邮会严格保护用户个人信息及个人隐私，我们将通过一些正当的技术手段，以便于用户可以完整的体验本产品所提供的相关服务和功能，与此同时，掌上重邮将会有专业的运维团队对您的个人信息进行保护，以免遭受未经授权的访问、使用或披露。\n\t7.2\n\t用户所提供给我们的信息可能用于下列用途\n\t7.2.1向您提供完整的服务\n\t7.2.2用于身份授权，访问相关网站时进行身份验证等\n\t7.2.3使我们更好的为您提供个性化服务，设计新的功能，改善现有服务\n\t7.3\n\t用户可自主修改、浏览个人提交的信息，包括但不限于个人头像、个人昵称、个性签名、联系方式等，但出于身份识别的考虑，用户无法修改相关注册信息，如:登录密码、登录名(即学号)等。\n8.隐私保护\n\t8.1\n\t掌上重邮将对用户使用过程涉及到的所有信息认证的身份信息进行保密，包括但不限于:登录账号和密码，校内统一认证码和密码，中国志愿网志愿者账号和密码。\n\t8.2\n\t掌上重邮将合理调取使用用户的相关个人信息，包括但不限于:个人定位信息，个人联系方式，个人积分财产，使用设备情况等。例如:校车轨迹服务需要调用用户GPS定位设备进行校车和用户位置定位。\n\t8.3\n\t掌上重邮的开发团队红岩网校工作站拥有专业的运维安全团队，将竭力为您的服务和账号安全保驾护航。\n\t8.4\n\t用户可在相关界面看到对应的详细的条款规则和介绍，力争消除用户使用本产品的隐私焦虑，降低用户的使用成本。\n9.知识产权声明\n\t红岩网校工作站拥有本产品的著作权，本平台内的所有功能、技术和产品设计其知识产权均归掌上重邮所有，用户需遵守以下几条原则:\n\t9.1\n\t未经红岩网校工作站团委书面同意，用户不得为任何商业或非商业目的自行或许可任何第三方实施、利用、转让上述知识产权。\n\t9.2\n\t严禁抄袭、复制本产品的相关设计语言、编程代码于任何用途。";

    
    CCLog(@"%@",view.text);
    
    if (@available(iOS 11.0, *)) {
        view.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        view.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    view.backgroundColor = self.view.backgroundColor;
    
    [view setFont:[UIFont fontWithName:PingFangSCLight size:13*fontSizeScaleRate_SE]];
    
    view.delegate = self;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}

- (void)ff{
    [HttpTool.shareTool
     request:Mine_POST_getAboutUsMsg_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerJSON
     bodyParameters:@{@"name":@"zscy-main-userAgreement"}
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        CCLog(@"yyy=%@",object[@"data"]);
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CCLog(@"yyy=%@",error);
    }];
    
//    [[HttpClient defaultClient] requestWithJson:Mine_POST_getAboutUsMsg_API method:HttpRequestPost parameters:@{@"name":@"zscy-main-userAgreement"} prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        CCLog(@"yyy=%@",responseObject[@"data"]);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        CCLog(@"yyy=%@",error);
//    }];
}
@end

