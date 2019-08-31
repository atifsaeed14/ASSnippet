//
//  User.swift
//  ASSnippet
//


import Foundation


// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


struct ServiceData: Codable {
    
    //"created_at" = "<null>";
    //"deleted_at" = "<null>";
    //id = 4;
    //image = "4.jpg";
    //"image_url" = "http://homeservices.inlogic.ae/images/services/4.jpg";
    //"is_active" = 1;
    //name = Electrical;
    //"name_ar" = Electrical;
    //"name_en" = Electrical;
    //"parent_id" = 0;
    //"updated_at" = "<null>";
    //"sub_services" =             (
    //    {
    //        "created_at" = "<null>";
    //        "deleted_at" = "<null>";
    //        id = 23;
    //        image = "20.jpg";
    //        "image_url" = "http://homeservices.inlogic.ae/images/services/20.jpg";
    //        "is_active" = 1;
    //        "language_id" = 1;
    //        name = Ligthing;
    //        "name_ar" = Ligthing;
    //        "name_en" = Ligthing;
    //        "parent_id" = 4;
    //        "service_id" = 23;
    //        "updated_at" = "<null>";
    //}
    
    
    // MARK: - Properties
    
    let id: Int
    let image: String?
    let parentID, isActive: Int?
    let deletedAt, createdAt, updatedAt: JSONNull?
    let nameEn, nameAr: String?
    let imageURL: String?
    let name: String?
    let subServices: [ServiceData]?
    let serviceID, languageID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, image
        case parentID = "parent_id"
        case isActive = "is_active"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case nameEn = "name_en"
        case nameAr = "name_ar"
        case imageURL = "image_url"
        case name
        case subServices = "sub_services"
        case serviceID = "service_id"
        case languageID = "language_id"
    }
}

struct ServiceDataResult: Codable {
    
    // MARK: - Properties
    
    let code: Int
    let data: [ServiceData]?
    let message: String?
}


extension ServiceData {
    
    private static var serviceDataKey: String {
        return "serviceDataKey"
    }
    
    static var savedServices: [ServiceData] {
        get {
            if let data = UserDefaults.standard.value(forKey: serviceDataKey) as? Data {
                do {
                    return try JSONDecoder().decode([ServiceData].self, from: data)
                } catch {
                    print(error)
                }
            }
            return []
        }
        
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                UserDefaults.standard.set(data, forKey: serviceDataKey)
                UserDefaults.standard.synchronize()
            } catch {
                print(error)
            }
        }
    }
    
}


