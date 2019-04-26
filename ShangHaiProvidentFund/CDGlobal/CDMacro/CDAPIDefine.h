//
//  CDAPIDefine.h
//  ShangHaiProvidentFund
//
//  Created by dongdong.cheng on 2019/3/22.
//  Copyright © 2019 cheng dong. All rights reserved.
//

#ifndef CDAPIDefine_h
#define CDAPIDefine_h

#define KApiStr(api) [NSString stringWithFormat:@"%@%@", api_server_base_url, api]
#define KWebApiStr(api) [NSString stringWithFormat:@"%@%@", api_web_url, api]

#pragma mark - API
#define KGjjManagerPoint KApiStr(@"/gjjManager/point")

#define KFeedBackServlet KApiStr(@"/gjjManager/feedBackServlet")

#define KChangePwdServlet KApiStr(@"/gjjManager/ChangePwdServlet")

#define KPrivateBasic KApiStr(@"/gjjManager/privateBasic")

#define KSendSmsServlet KApiStr(@"/SendSmsServlet")

#define KRegister KApiStr(@"/gjjManager/register1")

#define KCHDSearchServlet KApiStr(@"/gjjManager/CHDSearchServlet")

#define KMobileNews KApiStr(@"/gjjManager/mobileNews?")

#define KNoticeByIdServlet KApiStr(@"/gjjManager/noticeByIdServlet?id=blgg")

#define KH5JCLL KApiStr(@"/gjjManager/noticeByIdServlet?id=jcll")

#define KH5CJWT KApiStr(@"/gjjManager/noticeByIdServlet?id=cjwt")

#define kH5ToolsPaidApp KWebApiStr(@"/app/wap/tools_paid_app.html")

#define KH5ToolsAmmount KWebApiStr(@"/app/wap/tools_ammount.html")

#define KH5Mindex KWebApiStr(@"/static/2010/mindex.html")

#define KH5AppApply KWebApiStr(@"/static/sms/app_apply.html")

#define KH5ForgetPass KWebApiStr(@"/static/sms/forget-pass.html")

#endif /* CDAPIDefine_h */
