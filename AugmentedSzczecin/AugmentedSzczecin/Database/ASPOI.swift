import CoreLocation

@objc(ASPOI)
class ASPOI: _ASPOI {
    
    func getAddress(geocoder: CLGeocoder, completionHandler: (address: CLPlacemark?) -> Void) {
        var location:CLLocation = CLLocation(latitude: self.latitude as! Double, longitude: self.longitude as! Double)
        
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                completionHandler(address: nil)
                return
            }
            
            let placemark = placemarks.first as? CLPlacemark
            if placemark == nil {
                println("Problem with the data received from geocoder")
            }
            completionHandler(address: placemark)
        })
    }

}
