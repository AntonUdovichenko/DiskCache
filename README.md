# DiskCache
A simple way to save/read data from disk. 

# Usage
```
struct MyStruct: Codable {
    var id = UUID().uuidString
    var name: String
}

let diskCache: DiskCache<MyStruct> = .init(label: "com.my-app.example")) {
...

// Read
do {
  guard let data = try diskCache.readFromDisk() else { return }

  // do something with data
} catch {
  // handle error
}

...

// Write
do {
  try diskCache.saveToDisk(object: data)
} catch {
  // handle error
}
// or simple, if you don't need to handle errors
try? diskCache.saveToDisk(object: data)
```
