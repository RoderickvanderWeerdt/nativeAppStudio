//
//  Car.swift
//  Vehicles
//
//  Created by Roderick van der Weerdt on 30-08-15.
//  Copyright (c) 2015 Razeware, LLC. All rights reserved.
//

import Foundation

class Car : Vehicle {
    let isConvertible:Bool
    let isHatchback:Bool
    let hasSunroof:Bool
    let numberOfDoors:Int
    
    init(brandName: String, modelName: String, modelYear: Int, powerSource: String,
        isConvertible: Bool, isHatchback: Bool, hasSunroof: Bool, numberOfDoors: Int) {
            
            self.isConvertible = isConvertible
            self.isHatchback = isHatchback
            self.hasSunroof = hasSunroof
            self.numberOfDoors = numberOfDoors
            
            super.init(brandName: brandName, modelName: modelName, modelYear: modelYear,
                powerSource: powerSource, numberOfWheels: 4)
    }
    
    // MARK: - Private method implementations
    private func start() -> String {
        return String(format: "Start power source %@.", powerSource)
    }
    
    // MARK: - Superclass Overrides
    override func goForward() -> String {
        return String(format: "%@ %@ Then depress gas pedal.", start(), changeGears("Forward"))
    }
    
    override func goBackward() -> String {
        return String(format: "%@ %@ Check your rear view mirror. Then depress gas pedal.", start(), changeGears("Reverse"))
    }
    
    override func stopMoving() -> String {
        return String(format: "Depress brake pedal. %@", changeGears("Park"))
    }
    
    override func makeNoise() -> String {
        return "Beep beep!"
    }
    
    override var vehicleDetails: String {
        // Get basic details from superclass
        let basicDetails = super.vehicleDetails
        
        // Initialize mutable string
        var carDetailsBuilder = "\n\nCar-Specific Details:\n\n"
        
        // String helpers for booleans
        let yes = "Yes\n"
        let no = "No\n"
        
        // Add info about car-specific features.
        carDetailsBuilder += "Has sunroof: "
        carDetailsBuilder += hasSunroof ? yes : no
        
        carDetailsBuilder += "Is Hatchback: "
        carDetailsBuilder += isHatchback ? yes : no
        
        carDetailsBuilder += "Is Convertible: "
        carDetailsBuilder += isConvertible ? yes : no
        
        carDetailsBuilder += "Number of doors: \(numberOfDoors)"
        
        // Create the final string by combining basic and car-specific details.
        let carDetails = basicDetails + carDetailsBuilder
        
        return carDetails
    }
}