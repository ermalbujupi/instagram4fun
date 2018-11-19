//
//  Extensions.swift
//  Instagram
//
//  Created by Ermal Buju on 19.11.18.
//  Copyright © 2018 Ermal Bujupaj. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
}
