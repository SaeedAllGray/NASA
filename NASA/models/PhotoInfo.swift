import Foundation

struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    

   static let documentsDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first!

    static let archiveURL = documentsDirectory.appendingPathComponent("favorites").appendingPathExtension("plist")

    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
    }
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy:
           CodingKeys.self)
        self.title = try valueContainer.decode(String.self,
           forKey: CodingKeys.title)
        self.description = try
           valueContainer.decode(String.self, forKey:
           CodingKeys.description)
        self.url = try valueContainer.decode(URL.self, forKey:
           CodingKeys.url)
        self.copyright = try? valueContainer.decode(String.self,
           forKey: CodingKeys.copyright)
    }
    
    static func saveToFile(photoInfo: PhotoInfo) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedPhotoInfo = try? propertyListEncoder.encode(photoInfo)
        try? encodedPhotoInfo?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> Array<PhotoInfo> {
        var photoInfos: Array<PhotoInfo> = []
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedPhotoInfos = try? Data(contentsOf: archiveURL),
            let decodedPhotoInfos = try? propertyListDecoder.decode(Array<PhotoInfo>.self, from: retrievedPhotoInfos) {
            photoInfos = decodedPhotoInfos
            print(photoInfos)
        }
        return photoInfos
    }
    
    static func loadFromFile2()  {
           var photoInfo: PhotoInfo?
           let propertyListDecoder = PropertyListDecoder()
           if let retrievedPhotoInfo = try? Data(contentsOf: archiveURL),
               let decodedPhotoInfo = try? propertyListDecoder.decode(PhotoInfo.self, from: retrievedPhotoInfo) {
               photoInfo = decodedPhotoInfo
               print(photoInfo!)
           }


    }
}
