//
//  FontFamily.swift
//  SideVCApp
//
//  Created by 陈岩 on 2018/1/1.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class FontFamily: NSObject {

    //所有字体
    func printFonts() {
        let familyNames = UIFont.familyNames
        var index = 0
        for familyName in familyNames {
            print(familyName)
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            for fontName in fontNames {
                index += 1
                print("字体\(index):" + fontName)
            }
        }
    }
    
    func isHaveFontFamily(string: String) -> Bool {
        let familyNames = UIFont.familyNames
        for familyName in familyNames {
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            for fontName in fontNames {
                if string == fontName {
                    return true
                }
            }
        }
        return false
    }
    
}

/*
 字体1:Copperplate-Light
 字体2:Copperplate
 字体3:Copperplate-Bold
 字体4:AppleSDGothicNeo-Thin
 字体5:AppleSDGothicNeo-Light
 字体6:AppleSDGothicNeo-Regular
 字体7:AppleSDGothicNeo-Bold
 字体8:AppleSDGothicNeo-SemiBold
 字体9:AppleSDGothicNeo-UltraLight
 字体10:AppleSDGothicNeo-Medium
 字体11:Thonburi
 字体12:Thonburi-Light
 字体13:Thonburi-Bold
 字体14:GillSans-Italic
 字体15:GillSans-SemiBold
 字体16:GillSans-UltraBold
 字体17:GillSans-Light
 字体18:GillSans-Bold
 字体19:GillSans
 字体20:GillSans-SemiBoldItalic
 字体21:GillSans-BoldItalic
 字体22:GillSans-LightItalic
 字体23:MarkerFelt-Thin
 字体24:MarkerFelt-Wide
 字体25:HiraMaruProN-W4
 字体26:CourierNewPS-ItalicMT
 字体27:CourierNewPSMT
 字体28:CourierNewPS-BoldItalicMT
 字体29:CourierNewPS-BoldMT
 字体30:KohinoorTelugu-Regular
 字体31:KohinoorTelugu-Medium
 字体32:KohinoorTelugu-Light
 字体33:AvenirNextCondensed-Heavy
 字体34:AvenirNextCondensed-MediumItalic
 字体35:AvenirNextCondensed-Regular
 字体36:AvenirNextCondensed-UltraLightItalic
 字体37:AvenirNextCondensed-Medium
 字体38:AvenirNextCondensed-HeavyItalic
 字体39:AvenirNextCondensed-DemiBoldItalic
 字体40:AvenirNextCondensed-Bold
 字体41:AvenirNextCondensed-DemiBold
 字体42:AvenirNextCondensed-BoldItalic
 字体43:AvenirNextCondensed-Italic
 字体44:AvenirNextCondensed-UltraLight
 字体45:TamilSangamMN
 字体46:TamilSangamMN-Bold
 字体47:HelveticaNeue-UltraLightItalic
 字体48:HelveticaNeue-Medium
 字体49:HelveticaNeue-MediumItalic
 字体50:HelveticaNeue-UltraLight
 字体51:HelveticaNeue-Italic
 字体52:HelveticaNeue-Light
 字体53:HelveticaNeue-ThinItalic
 字体54:HelveticaNeue-LightItalic
 字体55:HelveticaNeue-Bold
 字体56:HelveticaNeue-Thin
 字体57:HelveticaNeue-CondensedBlack
 字体58:HelveticaNeue
 字体59:HelveticaNeue-CondensedBold
 字体60:HelveticaNeue-BoldItalic
 字体61:GurmukhiMN-Bold
 字体62:GurmukhiMN
 字体63:Georgia-BoldItalic
 字体64:Georgia-Italic
 字体65:Georgia
 字体66:Georgia-Bold
 字体67:TimesNewRomanPS-ItalicMT
 字体68:TimesNewRomanPS-BoldItalicMT
 字体69:TimesNewRomanPS-BoldMT
 字体70:TimesNewRomanPSMT
 字体71:SinhalaSangamMN-Bold
 字体72:SinhalaSangamMN
 字体73:ArialRoundedMTBold
 字体74:Kailasa-Bold
 字体75:Kailasa
 字体76:KohinoorDevanagari-Regular
 字体77:KohinoorDevanagari-Light
 字体78:KohinoorDevanagari-Semibold
 字体79:KohinoorBangla-Regular
 字体80:KohinoorBangla-Semibold
 字体81:KohinoorBangla-Light
 字体82:ChalkboardSE-Bold
 字体83:ChalkboardSE-Light
 字体84:ChalkboardSE-Regular
 字体85:AppleColorEmoji
 字体86:PingFangTC-Regular
 字体87:PingFangTC-Thin
 字体88:PingFangTC-Medium
 字体89:PingFangTC-Semibold
 字体90:PingFangTC-Light
 字体91:PingFangTC-Ultralight
 字体92:GujaratiSangamMN
 字体93:GujaratiSangamMN-Bold
 字体94:GeezaPro-Bold
 字体95:GeezaPro
 字体96:DamascusBold
 字体97:DamascusLight
 字体98:Damascus
 字体99:DamascusMedium
 字体100:DamascusSemiBold
 字体101:Noteworthy-Bold
 字体102:Noteworthy-Light
 字体103:Avenir-Oblique
 字体104:Avenir-HeavyOblique
 字体105:Avenir-Heavy
 字体106:Avenir-BlackOblique
 字体107:Avenir-BookOblique
 字体108:Avenir-Roman
 字体109:Avenir-Medium
 字体110:Avenir-Black
 字体111:Avenir-Light
 字体112:Avenir-MediumOblique
 字体113:Avenir-Book
 字体114:Avenir-LightOblique
 字体115:DiwanMishafi
 字体116:AcademyEngravedLetPlain
 字体117:Futura-CondensedExtraBold
 字体118:Futura-Medium
 字体119:Futura-Bold
 字体120:Futura-CondensedMedium
 字体121:Futura-MediumItalic
 字体122:PartyLetPlain
 字体123:KannadaSangamMN-Bold
 字体124:KannadaSangamMN
 字体125:ArialHebrew-Bold
 字体126:ArialHebrew-Light
 字体127:ArialHebrew
 字体128:Farah
 字体129:Arial-BoldMT
 字体130:Arial-BoldItalicMT
 字体131:Arial-ItalicMT
 字体132:ArialMT
 字体133:Chalkduster
 字体134:Kefa-Regular
 字体135:HoeflerText-Italic
 字体136:HoeflerText-Black
 字体137:HoeflerText-Regular
 字体138:HoeflerText-BlackItalic
 字体139:Optima-ExtraBlack
 字体140:Optima-BoldItalic
 字体141:Optima-Italic
 字体142:Optima-Regular
 字体143:Optima-Bold
 字体144:Palatino-Italic
 字体145:Palatino-Roman
 字体146:Palatino-BoldItalic
 字体147:Palatino-Bold
 字体148:MalayalamSangamMN-Bold
 字体149:MalayalamSangamMN
 字体150:AlNile
 字体151:AlNile-Bold
 字体152:LaoSangamMN
 字体153:BradleyHandITCTT-Bold
 字体154:HiraMinProN-W3
 字体155:HiraMinProN-W6
 字体156:PingFangHK-Medium
 字体157:PingFangHK-Thin
 字体158:PingFangHK-Regular
 字体159:PingFangHK-Ultralight
 字体160:PingFangHK-Semibold
 字体161:PingFangHK-Light
 字体162:Helvetica-Oblique
 字体163:Helvetica-BoldOblique
 字体164:Helvetica
 字体165:Helvetica-Light
 字体166:Helvetica-Bold
 字体167:Helvetica-LightOblique
 字体168:Courier-BoldOblique
 字体169:Courier-Oblique
 字体170:Courier
 字体171:Courier-Bold
 字体172:Cochin-Italic
 字体173:Cochin-Bold
 字体174:Cochin
 字体175:Cochin-BoldItalic
 字体176:TrebuchetMS-Bold
 字体177:TrebuchetMS-Italic
 字体178:Trebuchet-BoldItalic
 字体179:TrebuchetMS
 字体180:DevanagariSangamMN
 字体181:DevanagariSangamMN-Bold
 字体182:OriyaSangamMN
 字体183:OriyaSangamMN-Bold
 字体184:SnellRoundhand
 字体185:SnellRoundhand-Bold
 字体186:SnellRoundhand-Black
 字体187:ZapfDingbatsITC
 字体188:BodoniSvtyTwoITCTT-Bold
 字体189:BodoniSvtyTwoITCTT-BookIta
 字体190:BodoniSvtyTwoITCTT-Book
 字体191:Verdana-Italic
 字体192:Verdana
 字体193:Verdana-Bold
 字体194:Verdana-BoldItalic
 字体195:AmericanTypewriter-CondensedBold
 字体196:AmericanTypewriter-Condensed
 字体197:AmericanTypewriter-CondensedLight
 字体198:AmericanTypewriter
 字体199:AmericanTypewriter-Bold
 字体200:AmericanTypewriter-Semibold
 字体201:AmericanTypewriter-Light
 字体202:AvenirNext-Medium
 字体203:AvenirNext-DemiBoldItalic
 字体204:AvenirNext-DemiBold
 字体205:AvenirNext-HeavyItalic
 字体206:AvenirNext-Regular
 字体207:AvenirNext-Italic
 字体208:AvenirNext-MediumItalic
 字体209:AvenirNext-UltraLightItalic
 字体210:AvenirNext-BoldItalic
 字体211:AvenirNext-Heavy
 字体212:AvenirNext-Bold
 字体213:AvenirNext-UltraLight
 字体214:Baskerville-SemiBoldItalic
 字体215:Baskerville-SemiBold
 字体216:Baskerville-BoldItalic
 字体217:Baskerville
 字体218:Baskerville-Bold
 字体219:Baskerville-Italic
 字体220:KhmerSangamMN
 字体221:Didot-Bold
 字体222:Didot
 字体223:Didot-Italic
 字体224:SavoyeLetPlain
 字体225:BodoniOrnamentsITCTT
 字体226:Symbol
 字体227:Menlo-BoldItalic
 字体228:Menlo-Bold
 字体229:Menlo-Italic
 字体230:Menlo-Regular
 字体231:NotoNastaliqUrdu
 字体232:BodoniSvtyTwoSCITCTT-Book
 字体233:Papyrus-Condensed
 字体234:Papyrus
 字体235:HiraginoSans-W3
 字体236:HiraginoSans-W6
 字体237:PingFangSC-Medium
 字体238:PingFangSC-Semibold
 字体239:PingFangSC-Light
 字体240:PingFangSC-Ultralight
 字体241:PingFangSC-Regular
 字体242:PingFangSC-Thin
 字体243:MyanmarSangamMN
 字体244:MyanmarSangamMN-Bold
 字体245:Zapfino
 字体246:BodoniSvtyTwoOSITCTT-BookIt
 字体247:BodoniSvtyTwoOSITCTT-Book
 字体248:BodoniSvtyTwoOSITCTT-Bold
 字体249:EuphemiaUCAS
 字体250:EuphemiaUCAS-Italic
 字体251:EuphemiaUCAS-Bold
 */
