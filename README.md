# DiskCache
A simple way to save/read data from disk. 

# Usage
1. Add package dependency 

```
let package = Package(
    name: "MyPackage"
    ...
    dependencies: [
        .package(url: "https://github.com/AntonUdovychenko/DiskCache", branch: "main"),
    ],
    targets: [
        .target(
            name: "MyTarget",
            dependencies: [
                .product(name: "DiskCache", package: "DiskCache"),
            ],
        ...
    ]
)
...
```

2. Code example
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
