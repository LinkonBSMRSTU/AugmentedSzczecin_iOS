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
            
            if placemarks.count > 0 {
                var placemark = placemarks[0] as! CLPlacemark
                completionHandler(address: placemark)
            }
            else {
                println("Problem with the data received from geocoder")
                completionHandler(address: nil)
            }
        })
    }

}
