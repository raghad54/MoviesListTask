//
//  GalleryPickerDelegate.swift

//
//  Created by rh.com.sa on 02/06/2021.

//

import Foundation
import UIKit
import CoreData

internal typealias VideoPickerDelegate = UIImagePickerControllerDelegate & UINavigationControllerDelegate

internal enum PickingType {
    case picture, video
}

protocol GalleryPickerDelegate: AnyObject {
    func galleryPicker(_ galleryPicker: GalleryPickerHelper?, forImage: UIImage)
    func galleryPicker(_ galleryPicker: GalleryPickerHelper?, forURL: URL?)
}

extension GalleryPickerDelegate {
    func galleryPicker(_ galleryPicker: GalleryPickerHelper?, forImage: UIImage) { }
    func galleryPicker(_ galleryPicker: GalleryPickerHelper?, forURL: URL?) { }
}
