//
//  AppColors.swift
//  PokeBook
//
//  Created by 디해 on 3/3/24.
//

import UIKit

enum AppColor {
    case text(Text)
    case tap(Tap)
    case button(Button)
    case background(Background)
    
    var light: UIColor {
        switch self {
        case .text(let text):
            return text.light
            
        case .tap(let tap):
            return tap.light
            
        case .button(let button):
            return button.light
            
        case .background(let background):
            return background.light
        }
    }
    
    var dark: UIColor {
        switch self {
        case .text(let text):
            return text.dark
            
        case .tap(let tap):
            return tap.dark
            
        case .button(let button):
            return button.dark
            
        case .background(let background):
            return background.dark
        }
    }
}

extension AppColor {
    enum Text {
        case primary
        case secondary
        
        var light: UIColor {
            switch self {
            case .primary:
                return UIColor(hexString: "000000")
            case .secondary:
                return UIColor(hexString: "A9A9A9")
            }
        }
        
        var dark: UIColor {
            switch self {
            case .primary:
                return UIColor(hexString: "FFFFFF")
            case .secondary:
                return UIColor(hexString: "FFFFFF")
            }
        }
    }
}

extension AppColor {
    enum Tap {
        case selected
        case notSelected
        
        var light: UIColor {
            switch self {
            case .selected:
                return UIColor(hexString: "5E5E5E")
            case .notSelected:
                return UIColor(hexString: "C0C0C0")
            }
        }
        
        var dark: UIColor {
            switch self {
            case .selected:
                return UIColor(hexString: "FFFFFF")
            case .notSelected:
                return UIColor(hexString: "757575")
            }
        }
    }
}

extension AppColor {
    enum Button {
        case shinyBackgroundOn
        case shinyBackgroundOff
        
        var light: UIColor {
            switch self {
            case .shinyBackgroundOn:
                return UIColor(hexString: "5E5E5E")
            case .shinyBackgroundOff:
                return UIColor(hexString: "cfcfcf")
            }
        }
        
        var dark: UIColor {
            switch self {
            case .shinyBackgroundOn:
                return UIColor(hexString: "FFFFFF")
            case .shinyBackgroundOff:
                return UIColor(hexString: "525252")
            }
        }
    }
}

extension AppColor {
    enum Background {
        case screen
        case cell
        case stroke
        case line
        
        var light: UIColor {
            switch self {
            case .screen:
                return UIColor(hexString: "FFFFFF")
            case .cell:
                return UIColor(hexString: "FFFFFF")
            case .stroke:
                return UIColor(hexString: "EBEBEB")
            case .line:
                return UIColor(hexString: "f0f0f0")
            }
        }
        
        var dark: UIColor {
            switch self {
            case .screen:
                return UIColor(hexString: "1c1c1c")
            case .cell:
                return UIColor(hexString: "424242")
            case .stroke:
                return UIColor(hexString: "424242")
            case .line:
                return UIColor(hexString: "383838")
            }
        }
    }
}
