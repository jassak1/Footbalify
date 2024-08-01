//
//  Font.swift
//  Footbalify
//
//  Created by Adam Jassak on 09/07/2024.
//

import SwiftUI

extension SwiftUI.Font {
    // MARK: Regular Standard Font in different sizes
    static var regular10: SwiftUI.Font {
        .custom("Montserrat-Regular", size: 10)
    }
    static var regular20: SwiftUI.Font {
        .custom("Montserrat-Regular", size: 20)
    }
    static var regular30: SwiftUI.Font {
        .custom("Montserrat-Regular", size: 30)
    }
    static var regular40: SwiftUI.Font {
        .custom("Montserrat-Regular", size: 40)
    }
    static func regularCustom(_ size: CGFloat) -> SwiftUI.Font {
        .custom("Montserrat-Regular", size: size)
    }

    // MARK: Regular Italic Font in different sizes
    static var regItalic10: SwiftUI.Font {
        .custom("Montserrat-Italic", size: 10)
    }
    static var regItalic20: SwiftUI.Font {
        .custom("Montserrat-Italic", size: 20)
    }
    static var regItalic30: SwiftUI.Font {
        .custom("Montserrat-Italic", size: 30)
    }
    static var regItalic40: SwiftUI.Font {
        .custom("Montserrat-Italic", size: 40)
    }
    static func regItalic(_ size: CGFloat) -> SwiftUI.Font {
        .custom("Montserrat-Italic", size: size)
    }

    // MARK: SemiBold Standard Font in different sizes
    static var semi10: SwiftUI.Font {
        .custom("Montserrat-SemiBold", size: 10)
    }
    static var semi20: SwiftUI.Font {
        .custom("Montserrat-SemiBold", size: 20)
    }
    static var semi30: SwiftUI.Font {
        .custom("Montserrat-SemiBold", size: 30)
    }
    static var semi40: SwiftUI.Font {
        .custom("Montserrat-SemiBold", size: 40)
    }
    static func semiCustom(_ size: CGFloat) -> SwiftUI.Font {
        .custom("Montserrat-SemiBold", size: size)
    }

    // MARK: SemiBold Italic Font in different sizes
    static var semiItalic10: SwiftUI.Font {
        .custom("Montserrat-SemiBoldItalic", size: 10)
    }
    static var semiItalic20: SwiftUI.Font {
        .custom("Montserrat-SemiBoldItalic", size: 20)
    }
    static var semiItalic30: SwiftUI.Font {
        .custom("Montserrat-SemiBoldItalic", size: 30)
    }
    static var semiItalic40: SwiftUI.Font {
        .custom("Montserrat-SemiBoldItalic", size: 40)
    }
    static func semiItalic(_ size: CGFloat) -> SwiftUI.Font {
        .custom("Montserrat-SemiBoldItalic", size: size)
    }

    // MARK: ExtraBold Standard Font in different sizes
    static var extra10: SwiftUI.Font {
        .custom("Montserrat-ExtraBold", size: 10)
    }
    static var extra20: SwiftUI.Font {
        .custom("Montserrat-ExtraBold", size: 20)
    }
    static var extra30: SwiftUI.Font {
        .custom("Montserrat-ExtraBold", size: 30)
    }
    static var extra40: SwiftUI.Font {
        .custom("Montserrat-ExtraBold", size: 40)
    }
    static func extraCustom(_ size: CGFloat) -> SwiftUI.Font {
        .custom("Montserrat-ExtraBold", size: size)
    }

    // MARK: ExtraBold Italic Font in different sizes
    static var extraItalic10: SwiftUI.Font {
        .custom("Montserrat-ExtraBoldItalic", size: 10)
    }
    static var extraItalic20: SwiftUI.Font {
        .custom("Montserrat-ExtraBoldItalic", size: 20)
    }
    static var extraItalic30: SwiftUI.Font {
        .custom("Montserrat-ExtraBoldItalic", size: 30)
    }
    static var extraItalic40: SwiftUI.Font {
        .custom("Montserrat-ExtraBoldItalic", size: 40)
    }
    static func extraItalicCustom(_ size: CGFloat) -> SwiftUI.Font {
        .custom("Montserrat-ExtraBoldItalic", size: size)
    }
}
