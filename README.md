# SKLite

SKLite is a Swift package for working with SQLite. The name "SKLite" is simply a twist on "SQLite"—replacing the "Q" with a "K"—to make it stand out among other SQLite libraries.

## Why SKLite?

Most SQLite libraries focus on providing syntactic sugar to simplify SQL operations. `SKLite` takes a different approach: it offers a near one-to-one mapping of the native SQLite C API, preserving its original structure and behavior.

If you learn how to use `SKLite`, you will have effectively learned the SQLite C API as well. The function names and patterns closely mirror those in SQLite’s native interface.

## No Syntactic Sugar—Just Efficient Statements

The reason for avoiding syntactic sugar is to encourage efficient use of SQLite statements. Instead of abstracting SQL execution, SKLite keeps things simple and direct, allowing SQLite itself to handle SQL processing as efficiently as possible.

With `SKLite`, you'll primarily work with the `Stmt` class, which helps execute SQL statements effectively.

## Installation

Add  `SKLite` to your Swift package dependencies.

```swift
.package(url: "https://github.com/wuyu2015/SKLiteSwift.git", from: "1.0.0")
```

### Or Install Using Xcode

1. Open your Xcode project.
2. Select **File** -> **Swift Packages** -> **Add Package Dependency**.
3. In the popup window, enter the EmojiList GitHub repository URL: `https://github.com/wuyu2015/SKLiteSwift.git`.
4. Choose the desired version (e.g., 1.0.0) and complete the installation.

Now, you can use  `SKLite` in your project.

## Example Usage

```swift
import SKLite

let sql = "SELECT ? || ' ' || ?"
let db = try SKLite.Db()
let stmt = db.prepare(sql: sql)
try stmt.bindString(index: 1, value: "Hello")
        .bindString(index: 2, value: "world!")
        .step()
let result = stmt.getString(index: 0) // "Hello world!"
```

## Documentation

There is no extensive documentation—just dive into the source code! The API is straightforward and easy to understand.

## License

MIT License
