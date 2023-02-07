//
//  UIImage+Ext.swift
//  Photo HQ
//
//  Created by Oleg M on 07/02/2023.
//

import UIKit.UIImage

extension UIImage {
    func convertToDispayP3ColorSpaceIfNeed() -> UIImage? {
        guard let ciImage = CIImage(image: self) else { return nil }
        
        if let colorSpace = ciImage.colorSpace {
            print("Detected image color space: \(String(describing: colorSpace.name))")
            
            let pixelFormat = CIFormat(rawValue: Int32(colorSpace.numberOfComponents + 1))
            print("Detected Pixel format: \(pixelFormat.rawValue)")
        }
        
        guard ciImage.colorSpace?.name != CGColorSpace.displayP3 else {
            print("image in DispayP3 color space converting skip")
            return self
        }
        print("converting to DP3")
        if let dp3Image = convertToDispayP3ColorSpace() {
            print("success converting to DisplayP3")
            return dp3Image
        } else {
            print("Error: converting to DisplayP3 with error")
            return nil
        }
    }
    
    func convertToDispayP3ColorSpace() -> UIImage? {
        guard let colorSpace = CGColorSpace(name: CGColorSpace.displayP3) else { return nil }
        return convert(newColorSpace: colorSpace)
    }
    
    func convert(newColorSpace: CGColorSpace) -> UIImage? {
        guard let ciImage = CIImage(image: self) else { return nil }

        let context = CIContext(options: [.workingColorSpace: newColorSpace])
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            print("Error: unable to create CGImage for changing color space")
            return nil
        }

        let result = UIImage(cgImage: cgImage)
        return result
    }
}
