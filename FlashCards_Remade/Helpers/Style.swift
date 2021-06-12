//
//  Style.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/11/21.
//

import UIKit

extension UIView {
    func addCornerRadius(_ radius: CGFloat = 10) {
            self.layer.cornerRadius = radius
        }
        
        func addRoundedCorner(_ radius: CGFloat = 5) {
            self.layer.cornerRadius = radius
        }
}
