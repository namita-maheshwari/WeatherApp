//
//  CustomControls.swift
//  WeatherApp
//
//  Created by Namita Maheshwari on 01/10/24.
//

import UIKit

class PaddedLabel: UILabel {
    var topInset: CGFloat = 5
    var bottomInset: CGFloat = 5
    var leftInset: CGFloat = 10.0
    var rightInset: CGFloat = 10.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if needed
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}
