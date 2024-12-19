//
//  AppColor.swift
//  Good Fact
//
//  Created by androiddev on 12/9/24.
//

import SwiftUI

public final class AppColor {
    static let primary = Color(red: 0.0549, green: 0.0980, blue: 0.1216)
    static let secondary = Color(red: 0.1686, green: 0.2353, blue: 0.2627)
    static let tertiary = Color(red: 0.3490, green: 0.4471, blue: 0.4627)
    static let inversePrimary = Color(red: 0.2588, green: 0.2275, blue: 0.2157)
    static let inverseSecondary = Color(red: 0.4824, green: 0.4275, blue: 0.3843)
    // https://www.color-meanings.com/dark-color-palettes/
    
    static let ghostWhite = Color(hex: 0xfff8f8ff)
    
    static let blue = Color(hex: 0xff292d3f)
    static let green = Color(hex: 0xff373f38)
    static let orange = Color(hex: 0xff5f3920)
    static let brown = Color(hex: 0xff4b3830)
    static let darkBrown = Color(hex: 0xff332521)
    
    static let palette = [
        blue,
        green,
        orange,
        brown,
        darkBrown
    ]
}
