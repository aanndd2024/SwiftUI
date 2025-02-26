//
//  UIImage+Extension.swift
//  ShoeShop
//
//  Created by Anand Yadav on 23/02/25.
//

import UIKit
import CoreImage

extension UIImage {
    func averageColor() -> UIColor? {
        guard let ciImage = CIImage(image: self) else { return nil }

        let extentVector = CIVector(x: ciImage.extent.origin.x,
                                    y: ciImage.extent.origin.y,
                                    z: ciImage.extent.size.width,
                                    w: ciImage.extent.size.height)

        let filter = CIFilter(name: "CIAreaAverage", parameters: [
            kCIInputImageKey: ciImage,
            kCIInputExtentKey: extentVector
        ])

        guard let outputImage = filter?.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext()
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: CGColorSpaceCreateDeviceRGB())

        return UIColor(red: CGFloat(bitmap[0]) / 255.0,
                       green: CGFloat(bitmap[1]) / 255.0,
                       blue: CGFloat(bitmap[2]) / 255.0,
                       alpha: CGFloat(bitmap[3]) / 255.0)
    }
}
