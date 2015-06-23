// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ASPOI.swift instead.

import CoreData

enum ASPOIAttributes: String {
    case city = "city"
    case desription = "desription"
    case houseNumber = "houseNumber"
    case id = "id"
    case latitude = "latitude"
    case longitude = "longitude"
    case name = "name"
    case street = "street"
    case streetNumber = "streetNumber"
    case subcategory = "subcategory"
    case tag = "tag"
    case zipCode = "zipCode"
}

@objc
class _ASPOI: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "ASPOI"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _ASPOI.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var city: String?

    // func validateCity(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged

    var desription: String?

    // func validateDesription(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var houseNumber: String?

    // func validateHouseNumber(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var id: String?

    // func validateId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var latitude: NSNumber?

    // func validateLatitude(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var longitude: NSNumber?

    // func validateLongitude(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var name: String?

    // func validateName(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var street: String?

    // func validateStreet(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var streetNumber: String?

    // func validateStreetNumber(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var subcategory: String?

    // func validateSubcategory(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var tag: String?

    // func validateTag(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var zipCode: String?

    // func validateZipCode(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

}

