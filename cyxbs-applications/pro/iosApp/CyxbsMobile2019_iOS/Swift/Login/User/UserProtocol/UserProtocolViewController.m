//
//  UserProtocolViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/7/23.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "UserProtocolViewController.h"
#import <NudeIn.h>

@interface UserProtocolViewController ()

@end

@implementation UserProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#000101" alpha:1]];
    } else {
        self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:252/255.0 alpha:1];
    }
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [backButton setTitle:@"完成" forState:UIControlStateNormal];
    if (@available(iOS 11.0, *)) {
        [backButton setTitleColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFEF" alpha:1]] forState:UIControlStateNormal];
    } else {
        [backButton setTitleColor:[UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1] forState:UIControlStateNormal];
    }
    backButton.titleLabel.font = [UIFont fontWithName:PingFangSCSemibold size:19];
    backButton.frame = CGRectMake(MAIN_SCREEN_W - 20 - 50, 10, 50, 30);
    [backButton addTarget:self action:@selector(backButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 50, MAIN_SCREEN_W, 1)];
    separatorLine.alpha = 0.15;
    separatorLine.backgroundColor = backButton.titleLabel.textColor;
    [self.view addSubview:separatorLine];
    
    CGFloat rowSpace;
    CGFloat titleRowSpace;
    CGFloat titleFontSize;
    CGFloat subTitleFontSize;
    CGFloat textFontSize;
    
    if (IS_IPHONEX) {                       // iPhone X, Xs, XR, 11, 11 Pro, 11 Pro Max等
        titleRowSpace = 22;
        rowSpace = 16;
        titleFontSize = 20;
        subTitleFontSize = 17;
        textFontSize = 16;
    } else if (IS_IPHONESE) {               // 4.0寸iPhone
        titleRowSpace = 10;
        rowSpace = 7;
        titleFontSize = 17;
        subTitleFontSize = 14;
        textFontSize = 13;
    } else if (SCREEN_WIDTH == 375.f) {     // 4.7寸iPhone
        titleRowSpace = 13;
        rowSpace = 8;
        titleFontSize = 18;
        subTitleFontSize = 15;
        textFontSize = 14;
    } else {                                // 5.5寸iPhone
        titleRowSpace = 20;
        rowSpace = 15;
        titleFontSize = 19;
        subTitleFontSize = 16;
        textFontSize = 15;
    }
    
    NudeIn *userProtocolTextView = [NudeIn make:^(NUDTextMaker *make) {
        make.text(@"“掌上重邮”用户服务协议\n")
        .fontName(PingFangSCSemibold, titleFontSize)
        .aligment(NUDAliCenter)
        .paraSpacing(0, titleRowSpace)
        .attach();
        
        make.text(@"1. 导言\n")
        .fontName(PingFangSCSemibold, subTitleFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        
        make.text(@"\t欢迎您使用“掌上重邮”手机 app 相关服务，为了您可以方便、顺利地使用本产品相 关服务，特列出本协议条款，请您在开始使用“掌上重邮”前，认真阅读并充分理解 本协议。若您不同意本协议，意味着我们无法为您提供本产品的相关功能和服务。在 接受本协议条款且符合登录资格后，您方可登录、使用本产品的相关功能和服务。\n")
        .fontName(PingFangSCRegular, textFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"2. 账号登录\n")
        .fontName(PingFangSCSemibold, subTitleFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"\t2.1 \n\t鉴于掌上重邮通过重庆邮电大学学号+密码的登录方式，若您为重庆邮电大学校内学生 且获得了相关的学号信息，方可通过学号+密码(身份证后六位)进行登录，登录成功 后方可使用本产品的相关功能和服务。\n\t2.2 \n\t在用户第一次登录后，默认用户授权本产品使用用户相关学生信息(学号+密码)通过 合法途径对校内相关信息网站进行访问，获取相关信息。\n\t2.3 \n\t本产品部分功能需使用重庆邮电大学所提供的统一认证码进行身份认证登录后才可使 用，具体登录入口于产品内，采用统一认证码认证后可使用更多产品功能，不影响基 础功能的使用。 \n\t2.4 \n\t本产品账号采用和重庆邮电大学教务处所提供的学号一致，本产品不提供和不保障相关账号的密码找回会、密码修改等服务功能。 \n\t2.5 \n\t用户应妥善保管个人账号密码信息，谨交由他人使用或使用他人账户信息，个人设 备，如用户由于个人保管不当造成损失的，本产品不会承担任何责任。\n")
        .fontName(PingFangSCRegular, textFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"3. 账号互通\n")
        .fontName(PingFangSCSemibold, subTitleFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"本产品由红岩网校工作站开发、维护，为了给您给好的产品体验，本产品相关用户信 息与内容将与红岩网校工作站微信公众号“重邮小帮手”互通，在此特作以下几点说 明。 \n\t3.1 \n\t若您在使用本产品前通过微信授权成功绑定“重邮小帮手”微信公众号，您的相关个 人信息:包括但不限于微信昵称、头像等将被我们所获悉，这代表您同意我们使用您 的相关信息。在此会出现以下特殊情况:如果没有对掌上重邮 APP 上的头像进行自主 修改，那么您的头像将默认为是微信头像，自主修改个人头像头，会将其优先设置为 您在掌上重邮 APP 上的个人头像。 \n\t3.2 \n\t若您在使用本产品前未绑定“重邮小帮手”微信公众号，那么您的默认头像将会被设 置为系统内置默认头像，您可以自主修改个人头像，用户修改的头像将会优先设置为 您在掌上重邮 APP 上的个人头像。\n")
        .fontName(PingFangSCRegular,textFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"4. 功能授权\n")
        .fontName(PingFangSCSemibold, subTitleFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"\t4.1 \n\t经您同意后，本软件可以调用您所使用终端设备的相关权限和接口，如 GPS、相册、 相机等以顺利使用本产品的相关功能。\n")
        .fontName(PingFangSCRegular,textFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"5. 邮问社区\n")
        .fontName(PingFangSCSemibold, subTitleFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"\t邮问力争打造一个重邮校园内的问答知识社区，感谢您参与其中为社区的建设做出贡献，在社区的功能使用、内容发布、回答互动等行为中，您需要遵循以下几点准则以 营造一个健康的知识社区。\n\t5.1 \n\t用户通过掌上重邮app所制作，上传，发布，复制，传播的任何内容，形式包括但不限于账号头像、昵称、个性签名、社区发布提问内容、社区回答、社区评论等一切以图片、文字、链接、视频为载体的内容，不得违反国家相关法律制度规定，内容包括 但不限于以下几点原则 \n\t5.1.1  不得危害国家安全，泄露国家秘密，颠覆国家政杈，破坏国家统一 \n\t5.1.2 不得损害国家荣誉和利益 \n\t5.1.3 不得散布谣言，扰乱社会秩序，破环社会稳定 \n\t5.1.4 不得散布淫秽、色情、赌博、暴力、凶杀、恐怖或者教唆犯罪 \n\t5.1.5 不得侮辱或者诽谤他人，侵害他人合法权益 \n\t5.1.6 不得含有法律、行政法规禁止的其他内容 \n\t5.2 \n\t用户不可通过本产品传播、制作、上传、发布等干扰本APP正常运营，以及侵犯其他用户的合法权益的内容，内容包括但不限于以下几点原则: \n\t5.2.1 不得含有任何性暗示内容 \n\t5.2.2 不得含有辱骂、恐吓、威胁内容 \n\t5.2.3 不得含有骚扰、垃圾广告、恶意信息、诱骗信息 \n\t5.2.4 不得涉及他人隐私、个人信息和资料 \n\t5.2.5 不得侵害他人名誉权、肖像权、知识产权等合法权益 \n\t5.2.6 不得含有其他干扰本产品服务正常运营内容 \n\t5.2.7 不得通过本产品泄露他人信息 \n\t5.3 \n\t在表达自己的困惑、需求帮助，在对问题进行解答，与其他用户进行讨论时，我们推崇友好、和谐、互助的理念，用户不可出现破坏社区氛围的行为，内容包括但不限于 以下几点原则: \n\t5.3.1 不得通过社区进行漫骂、争吵 \n\t5.3.2 不得轻视、诋毁他人劳动成功 \n\t5.3.3 不得捏造、传播虚假回答 \n\t5.3.4 不得用夸张、侮辱性的语句对他人进行挑衅和嘲讽以此来激怒他人 \n\t5.3.5 不得对他人的能力进行评价，使对方难堪 \n\t5.3.6 不得故意通过编造提问和回答进行积分的转换  \n\t5.3.7 不得发布具有煽动情绪的提问、回答和评论  \n\t5.3.8 不得通过本平台发布垃圾广告 \n\t5.3.9 不得转载他人的原创回答内容 \n\t5.4 \n\t对违反以上条例中相关原则的用户，掌上重邮有权力采取删除相关内容，对违反规则用户进行警告、暂停甚至中止用户账号使用权限等措施。\n\t5.5 \n\t邮问社区环境依靠每一个参与进来的爱问爱答知识人，掌邮鼓励和请求大家共同参与进来，维护良好社区氛围，坚决打击不良社区行为。本产品拥有快速对提问、回答和评论进行举报的入口，成功有效的举报有害内容的用户可获得掌邮的相关奖励。\n\t5.6 \n\t邮问知识社区保障每个积极参与的用户的知识产权，严禁一切用户在未经创作者允许授权的情况下，引用，复制相关产出内容用于其他途径。\n\t5.7 \n\t 邮问社区匿名板块内的所有提问、回答和评论内容将隐藏用户个人头像、昵称等内容，但掌邮仍可透明监管每个用户的情况，严禁用户通过该板块发布、传播一切违反 上诉相关原则的内容。 \n\t5.8 \n\t掌上重邮不能对邮问社区用户发表的提问和回答的正确性进行保证，用户的提问、回答和评论仅表明其个人立场和观点，掌上重邮不承担任何相关责任。\n")
        .fontName(PingFangSCRegular,textFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"6. 积分与打赏\n")
        .fontName(PingFangSCSemibold, subTitleFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"\t积分是本产品内的产物，具有时效性，用户通过签到、产品内相关活动、邮问优质回 答等途径获取积分，积分是用户在邮问社区友好往来，按时打卡的认证，用户可通过 积分兑换相应的奖励，奖励将不定期限量更新。在此对积分相关使用规则进行说明。 \n\t6.1 \n\t您对您所获得的积分拥有的操作权力包括:邮问提问设置悬赏积分设置，积分商城积分兑换相应奖励等。一旦确认操作:选取优质回答悬赏积分、进行积分兑换后流出的积分将不可撤销。若用户通过不正当的途径赚取、盗刷积分，本产品拥有收回积分的 权力。 \n\t6.2 \n\t悬赏积分:悬赏积分的设置是驱动用户提供优质回答的途径，用户将通过设置一定数额的悬赏积分来发布问题，用户拥有自主选择悬赏积分的权力(最低为1积分)，为了使您的回答得到更快速地解答，用户将主动为提问设置一个任务最晚完成时间，在一定的时间内，用户可以主动的对回答进行筛选，选择您认为最有帮助的解答，通过点击“采纳”按钮将个人悬赏积分赏给用户，若超过任务最晚完成时间后，用户未主动采纳回答，系统将通过判断最多获赞的答案默认将悬赏积分分配给回答者，若出现无 最多获赞的回答，则将退回用户的悬赏积分。 \n\t6.3 \n\t严禁用户通过多个账号进行恶意提问和回答等行为以达到积分转移、制造话题、博取眼球等目的，一经查实，本产品拥有对相关账号实施警告、暂停服务甚至禁用账号的 权力。 \n\t6.4 \n\t通过相关系统bug对积分数量、积分兑换条件等进行篡改以谋取利益的行为，一经查实，本产品将对相关用户账号进行封禁措施。 \n\t6.5 \n\t为了积分制度的健康发展，用户可在产品相关积分兑换活动时校内，通过积分进行兑换相关奖励，原则上，系统会对积分做定期的清零更新，积分系统的更新周期在一年 (两学期)。\n")
        .fontName(PingFangSCRegular,textFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"7. 信息安全\n")
        .fontName(PingFangSCSemibold, subTitleFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"\t本产品所收集到的相关信息都以为用户提供相关服务为目的，特此承诺不会泄露用户 个人信息隐私，部分公开信息特此说明。 \n\t7.1 \n\t掌上重邮会严格保护用户个人信息及个人隐私，我们将通过一些正当的技术手段，以便于用户可以完整的体验本产品所提供的相关服务和功能，与此同时，掌上重邮将会 有专业的运维团队对您的个人信息进行保护，以免遭受未经授权的访问、使用或披 露。 \n\t7.2 \n\t用户所提供给我们的信息可能用于下列用途 \n\t7.2.1 向您提供完整的服务 \n\t7.2.2 用于身份授权，访问相关网站时进行身份验证等 \n\t7.2.3 使我们更好的为您提供个性化服务，设计新的功能，改善现有服务 \n\t7.3 \n\t用户可自主修改、浏览个人提交的信息，包括但不限于个人头像、个人昵称、个性签名、联系方式等，但出于身份识别的考虑，用户无法修改相关注册信息，如登录名(即学号)等。\n")
        .fontName(PingFangSCRegular,textFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"8. 隐私保护\n")
        .fontName(PingFangSCSemibold, subTitleFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"引言\n\t我们极其重视用户的隐私，隐私权是您重要的权利。您在使用我们的服务时，我们可能会收集和使用您的相关信息。我们希望通过本《用户服务协议》向您说明：\n1.我们如何收集您的个人信息。\n2.我们如何使用您的个人信息。\n3.我们如何分享您的信息。\n4.我们如何保存您的个人信息\n5.我们如何管理、保护您的个人信息。\n6.您分享的信息说明。\n7.您分享的个人敏感信息说明。\n8.我们可能会向您发送的信息或邮件说明\n9.本APP中所使用的第三方SDK说明\n10.本“隐私保护”条例适用范围\n11.本隐私条例变更说明\n本《用户服务协议》与您所使用的服务息息相关，希望您仔细阅读，在需要时，按照本《用户服务协议》的指引，作出您认为适当的选择。本《用户服务协议》中涉及的相关技术词汇，我们尽量以简明扼要的表述，并提供进一步说明的链接，以便您的理解。 您使用或继续使用我们的服务，即意味着同意我们按照本《用户服务协议》收集、使用、储存和分享您的相关信息。 如对本《用户服务协议》或相关事宜有任何问题，请与我们联系。\n8.1我们如何收集您的个人信息\n\t我们提供服务时，可能会收集、储存和使用下列与您有关的信息。如果您不提供相关信息，可能无法注册成为我们的用户或无法享受我们提供的某些服务，或者无法达到相关服务拟达到的效果。\n\t8.1.1您提供的信息\n\t您在注册或登录账户或使用我们的服务时，向我们提供的相关个人信息，例如电话号码、身份证号、电子邮件或银行卡号等；\n您通过我们的服务向其他方提供的共享信息，以及您使用我们的服务时所储存的信息。\n\t8.1.2其他方分享的您的信息\n\t其他方使用我们的服务时所提供有关您的共享信息。\n\t8.1.3我们获取的您的信息\t\n您使用服务时我们可能收集如下信息：\n\t日志信息，指您使用我们的服务时，系统可能自动采集的技术信息，包括：设备或软件信息，例如您的移动设备、网页浏览器或用于接入我们服务的其他程序所提供的配置信息、您的IP地址和移动设备所用的版本和设备识别码；\n\t在使用我们服务时搜索或浏览的信息，例如您使用的网页搜索词语、访问的社交媒体页url地址，以及您在使用我们服务时浏览或要求提供的其他信息和内容详情；有关您曾使用的移动应用（APP）和其他软件的信息，以及您曾经使用该等移动应用和软件的信息；\n\t您通过我们的服务进行通讯的信息，例如曾通讯的账号，以及通讯时间、数据和时长；\n\t位置信息、MAC地址信息，指您开启设备定位功能并使用我们基于位置提供的相关服务时，收集的有关您位置的信息，包括：\n\t您通过具有定位功能的移动设备使用我们的服务时，通过GPS或WiFi等方式收集的您的地理位置信息；\n\t您或其他用户提供的包含您所处地理位置的实时信息，例如您提供的账户信息中包含的您所在地区信息，您或其他人上传的显示您当前或曾经所处地理位置的共享信息，您或其他人共享的照片包含的地理标记信息；\n\t您可以通过关闭定位功能，停止对您的地理位置信息的收集。\n8.2我们如何使用您的个人信息\n我们可能将在向您提供服务的过程之中所收集的信息用作下列用途：\n\t向您提供服务；\n\t在我们提供服务时，用于身份验证、客户服务、安全防范、诈骗监测、存档和备份用途，确保我们向您提供的产品和服务的安全性；\n\t帮助我们设计新服务，改善我们现有服务；使我们更加了解您如何接入和使用我们的服务，从而针对性地回应您的个性化需求，例如语言设定、 位置设定、个性化的帮助服务和指示，或对您和其他用户作出其他方面的回应；\n\t向您提供与您更加相关的广告以替代普遍投放的广告；评估我们服务中的广告和其他促销及推广活动的效果，并加以改善；软件认证或管理软件升级；让您参与有关我们产品和服务的调查。\n\t为了让您有更好的体验、改善我们的服务或您同意的其他用途，在符合相关法律法规的前提下，我们可能将通过某一项服务所收集的信息，以汇集信息或者个性化的方式，用于我们的其他服务。例如，在您使用我们的一项服务时所收集的信息，可能在另一服务中用于向您提供特定内容，或向您展示与您相关的、非普遍推送的信息。如果我们在相关服务中提供了相应选项，您也可以授权我们将该服务所提供和储存的信息用于我们的其他服务。\n\t您如何访问和控制自己的个人信息\n\t我们将尽一切可能采取适当的技术手段，保证您可以访问、更新和更正自己的注册信息或使用我们的服务时提供的其他个人信息。在访问、更新、更正和删除前述信息时，我们可能会要求您进行身份验证，以保障账户安全。\n8.3我们如何分享您的信息\n\t除以下情形外，未经您同意，我们以及我们的关联公司不会与任何第三方分享您的个人信息。\n\t我们以及我们的关联公司，可能将您的个人信息与我们的关联公司、合作伙伴及第三方服务供应商、承包商及代理（例如代表我们发出电子邮件或推送通知的通讯服务提供商、为我们提供位置数据的地图服务供应商）分享（他们可能并非位于您所在的法域），用作下列用途：\n\t向您提供我们的服务；\n\t实现“我们可能如何使用信息”部分所述目的；\n\t履行我们在本《用户服务协议》中的义务和行使我们的权利；\n\t理解、维护和改善我们的服务\n\t如我们或我们的关联公司与任何上述第三方分享您的个人信息，我们将努力确保该等第三方在使用您的个人信息时遵守本《用户服务协议》及我们要求其遵守的其他适当的保密和安全措施\n。\t随着我们业务的持续发展，我们以及我们的关联公司有可能进行合并、收购、资产转让或类似的交易，您的个人信息有可能作为此类交易的一部分而被转移。我们将在转移前通知您。\n\t我们或我们的关联公司还可能为以下需要而保留、保存或披露您的个人信息：\n\t遵守适用的法律法规；\n\t遵守法院命令或其他法律程序的规定；\n\t遵守相关政府机关的要求。\n\t为遵守适用的法律法规、维护社会公共利益，或保护我们的客户、我们或我们的集团公司、其他用户或雇员的人身和财产安全或合法权益所合理必需的用途。\n8.4我们如何保存您的个人信息\n\t8.4.1信息存储地点\n\t我们会按照法律法规规定，将境内收集的个人信息存储于中国境内。\n\t8.4.2信息存储的期限\n\t我们收集的个人信息的保留期限是实现本隐私条例所述收集目的最短需要时间，除非法律要求更长的保留期限，超过上次保留期限，我们将删除或匿名话您的个人信息。当我们产品发生停止运营的情形时，我们将以推送、公告等形式通知您，并在合理的期限内删除您的个人信息或进行匿名话处理\n8.5我们如何管理、保护您的个人信息\n\t1.我们已经使用符合业界标准的安全防护措施来保护您提供的个人信息，防止您的个人信息遭到未经授权的访问、使用、修改、损坏或公开披露\n\t2.我们使用各种安全技术和程序，以防信息的丢失、不当使用、未经授权阅览或披露。例如，在某些服务中，我们将利用加密技术（例如SSL）来保护您提供的个人信息。但请您理解，由于技术的限制以及可能存在的各种恶意手段，在互联网行业，即便竭尽所能加强安全措施，也不可能始终保证信息百分之百的安全。您需要了解，您接入我们的服务所用的系统和通讯网络，有可能因我们可控范围外的因素而出现问题。\n\t3.当发生个人信息泄漏等安全事件时，我们将按照法律法规、规范性文件以及国家标准等要求及时向您告知：安全事件的基本情况和可能造成的影响、我们已采取的处置措施、对您的补救措施等。我们将及时以推送、公告等形式通知您，难以逐一告知个人信息主题时，我们会采取合理、有效的方式发布公告。同时我们也会按照相关部门的要求，主动上报个人信息安全事件的处置情况。\n8.6您分享的信息说明\n\t我们的多项服务，可让您不仅与自己的社交网络，也与使用该服务的所有用户公开分享您的相关信息，例如，您在我们的服务中所上传或发布的信息（包括您公开的个人信息、您建立的名单）、您对其他人上传或发布的信息作出的回应，以及包括与这些信息有关的位置数据和日志信息。使用我们服务的其他用户也有可能分享与您有关的信息（包括位置数据和日志信息）。特别是，我们的社交媒体服务，是专为使您与世界各地的用户共享信息而设计，您可以使共享信息实时、广泛地传递。只要您不删除共享信息，有关信息会一直留存在公共领域；即使您删除共享信息，有关信息仍可能由其他用户或不受我们控制的非关联第三方独立地缓存、复制或储存，或由其他用户或该等第三方在公共领域保存。\n\t因此，请您谨慎考虑通过我们的服务上传、发布和交流的信息内容。在一些情况下，您可通过我们某些服务的隐私设定来控制有权浏览您共享信息的用户范围。如要求从我们的服务中删除您的相关信息，请通过该等特别服务条款提供的方式操作。\n8.7您分享的敏感个人信息说明\n\t某些个人信息因其特殊性可能被认为是敏感个人信息，例如您的身份证号、种族、宗教、个人健康和医疗信息等。相比其他个人信息，敏感个人信息受到更加严格的保护。\n\t请注意，您在使用我们的服务时所提供、上传或发布的内容和信息（例如有关您社交活动的照片等信息），可能会泄露您的敏感个人信息。您需要谨慎地考虑，是否在使用我们的服务时披露相关敏感个人信息。\n\t您同意按本《用户服务协议》所述的目的和方式来处理您的敏感个人信息。\n8.8我们可能向您发送的信息或邮件说明\n\t8.8.1邮件和信息推送\n\t您在使用我们的服务时，我们可能使用您的信息向您的设备发送电子邮件、新闻或推送通知。如您不希望收到这些信息，可以按照我们的相关提示，在设备上选择取消订阅。\n\t8.8.2与服务有关的公告\n\t我们可能在必要时（例如因系统维护而暂停某一项服务时）向您发出与服务有关的公告。您可能无法取消这些与服务有关、性质不属于推广的公告。\n8.9本APP中使用的第三方SDK说明\n\t本App内集成了：友盟Umeng、腾讯Bugly、高德地图和阿里云HTTPDNS等第三方SDK，以便于更好的为您服务。\n\t其功能分别为：\n\t友盟Umeng：负责App内的消息推送和版本分布、收集当日活跃用户等App信息以便于优化服务。\n\t腾讯Bugly：负责App内的报错信息收集，方便锁定线上问题，及时修复产品。\n\t高德地图：负责App内的地图应用。\n\t阿里云HTTPDNS：负责提供域名解析服务，以提高网络访问的稳定性和速度。\n\t超范围收集个人信息\n\tAPP内集成的第三方SDK（腾讯Bugly）可能存在超范围收集用户信息的情况（用户MAC地址、身份证号等）。\n8.10本“隐私保护”条例的适用范围\n\t除某些特定服务外，我们所有的服务均适用本《用户服务协议》。这些特定服务将适用特定的隐私政策。针对某些特定服务的特定隐私政策，将更具体地说明我们在该等服务中如何使用您的信息。该特定服务的隐私政策构成本《用户服务协议》的一部分。如相关特定服务的隐私政策与本《用户服务协议》有不一致之处，适用该特定服务的隐私政策。\n\t请您注意，本《用户服务协议》不适用于以下情况：\n\t通过我们的服务而接入的第三方服务（包括任何第三方网站）收集的信息；\n\t通过在我们服务中进行广告服务的其他公司或机构所收集的信息。\n8.11《用户服务协议》变更说明\n\t我们可能适时修订本《用户服务协议》的条款，该等修订构成本《用户服务协议》的一部分。如该等修订造成您在本《用户服务协议》下权利的实质减少，我们将在修订生效前通过在主页上显著位置提示或向您发送电子邮件或以其他方式通知您。在该种情况下，若您继续使用我们的服务，即表示同意受经修订的本《用户服务协议》的约束。\n")
        .fontName(PingFangSCRegular,textFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"9. 知识产权声明\n")
        .fontName(PingFangSCSemibold, subTitleFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"\t红岩网校工作站拥有本产品的著作权，本平台内的所有功能、技术和产品设计其知识 产权均归掌上重邮所有，用户需遵守以下几条原则: \n\t9.1 \n\t未经红岩网校工作站团委书面同意，用户不得为任何商业或非商业目的自行或许 可任何第三方实施、利用、转让上述知识产权。 \n\t9.2 \n\t严禁抄袭、复制本产品的相关设计语言、编程代码于任何用途。\n")
        .fontName(PingFangSCRegular,textFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
        make.text(@"10. 第三方SDK使用说明\n")
            .fontName(PingFangSCSemibold, subTitleFontSize)
            .paraSpacing(0, rowSpace)
            .attach();
        
        make.text(@"\t本App内集成了：友盟Umeng、腾讯Bugly、QQ开放平台、高德地图共四个第三方SDK，以便于更好的为您服务\n友盟Umeng：负责App内的消息推送和版本分布、收集当日活跃用户等App信息以便于优化服务。\n腾讯Bugly：负责App内的报错信息收集，方便锁定线上问题，及时修复产品。\nQQ开放平台：负责App内的内容分享至站外平台，从“邮圈”分享至QQ好友与QQ空间。\n高德地图：主要用于校车服务的地图集成。")
        .fontName(PingFangSCRegular,textFontSize)
        .paraSpacing(0, rowSpace)
        .attach();
        
    }];
    userProtocolTextView.frame = CGRectMake(20, 51, MAIN_SCREEN_W - 40, self.view.frame.size.height - 100);
    if (@available(iOS 11.0, *)) {
        userProtocolTextView.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFEF" alpha:1]];
        userProtocolTextView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#000101" alpha:1]];
    } else {
        userProtocolTextView.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
        userProtocolTextView.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:252/255.0 alpha:1];
    }
    userProtocolTextView.textContainerInset = UIEdgeInsetsMake(20, 0, 0, 0);
    userProtocolTextView.scrollEnabled = YES;
    [self.view addSubview:userProtocolTextView];

}

- (void)backButtonTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
