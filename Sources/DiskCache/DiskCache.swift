import Foundation

enum DiskCacheError: Error {
    case pathIsNil
}

public class DiskCache<T: Codable> {
    private var label: String
    private var fileManager: FileManager
    private var path: URL? {
       let documents = self.fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
       return documents?.appendingPathComponent(label)
    }
    
    public init(label: String, fileManager: FileManager = .default) {
        self.label = label
        self.fileManager = fileManager
    }
    
    public func readFromDisk() throws -> T? {
        guard let path = path else { throw DiskCacheError.pathIsNil }
        guard fileManager.fileExists(atPath: path.path) else {
            return nil
        }
        
        let diskData = try Data(contentsOf: path)
        let decoder = JSONDecoder()
        let object = try decoder.decode(T.self, from: diskData)
        return object
    }
    
    public func saveToDisk(object: T) throws {
        guard let path = path else { throw DiskCacheError.pathIsNil }

        let encoder = JSONEncoder()
        let encoded = try encoder.encode(object)
        try encoded.write(to: path)
    }
    
    public func clear() throws {
        guard let path = path else { throw DiskCacheError.pathIsNil }
        guard fileManager.fileExists(atPath: path.path) else { return }
        
        try fileManager.removeItem(at: path)
    }
}
