//
//  LocationHelperDelegate.swift
//  BaseIOS
//
//  Created by R.Soliman on 03/06/2021.

//

import Foundation
import CoreLocation
import CoreData

typealias OnUpdateLocation = ((CLLocationCoordinate2D?) -> Void)
typealias OnErrorLocation = (() -> Void)

protocol LocationDelegate: AnyObject {
    func location(_ locationHelper: LocationHelper?, lat: Double, lng: Double)
    func location(_ locationHelper: LocationHelper?, didError: Bool)
}
extension LocationDelegate {
    func location(_ locationHelper: LocationHelper?, lat: Double, lng: Double) { }
    func location(_ locationHelper: LocationHelper?, didError: Bool) { }
}
