//
//  UIImage+.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 18/12/21.
//

import UIKit
extension UIImage {
    
    func averageColor() -> UIColor {
        guard let rawImageRef = cgImage, let data = rawImageRef.dataProvider?.data else {
            return .clear
        }
        let rawPixelData = CFDataGetBytePtr(data)
        let imageHeight = rawImageRef.height
        let imageWidth = rawImageRef.width
        let bytesPerRow = rawImageRef.bytesPerRow
        let stride = rawImageRef.bitsPerPixel / 8
        
        var red = 0
        var green = 0
        var blue  = 0
        for row in 0...imageHeight {
            var rowPtr = rawPixelData! + bytesPerRow * row
            for _ in 0...imageWidth {
                red += Int(rowPtr[0])
                green += Int(rowPtr[1])
                blue += Int(rowPtr[2])
                rowPtr += Int(stride)
            }
        }
        
        let f: CGFloat = 1 / (255 * CGFloat(imageWidth) * CGFloat(imageHeight))
        return UIColor(red: f * CGFloat(red), green: f * CGFloat(green), blue: f * CGFloat(blue), alpha: 1)
    }
    
}
