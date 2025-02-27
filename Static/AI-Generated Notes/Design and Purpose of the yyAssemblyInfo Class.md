### Design and Purpose of the `yyAssemblyInfo` Class

The `yyAssemblyInfo` class is designed to provide structured and efficient access to metadata about an assembly (`System.Reflection.Assembly`). This document explains the design of the class, its key features, and the reasoning behind its implementation choices.

---

### **Overview of the Class**

The `yyAssemblyInfo` class serves as a wrapper around an `Assembly` object. It provides easy access to commonly used assembly information, such as its name, version, and attributes. The class ensures efficient retrieval of data, even for rarely accessed properties, by leveraging lazy initialization.

---

### **Design Goals**

1. **Encapsulation**: Provide a single, easy-to-use interface for accessing assembly metadata.
2. **Efficiency**: Avoid unnecessary computation by initializing properties only when they are accessed.
3. **Immutability**: Ensure the core `Assembly` property remains unchanged after an instance of `yyAssemblyInfo` is created, preserving the integrity of the object's state.

---

### **Key Features**

#### **1. Encapsulation of Assembly Metadata**
The class provides properties that expose various pieces of metadata extracted from the assembly, such as:
- `Location`: The file path of the assembly.
- `FullName`: The full name of the assembly, including version and culture.
- Attributes like `Title`, `Company`, `Product`, and `Version`.

The class hides the complexity of extracting these values from the underlying `Assembly` object, presenting them in a simple and consistent interface.

#### **2. Lazy Initialization**
Some assembly attributes, such as `Configuration` and `Description`, are not frequently accessed. To optimize performance, these properties are initialized using `Lazy<T>`. This ensures that their values are only computed when needed.

Example:
```csharp
private readonly Lazy<string?> _configuration;

public string? Configuration => _configuration.Value;
```

By deferring the initialization until access, the class avoids unnecessary computation, making it efficient for scenarios where only a subset of the properties is used.

#### **3. Immutability**
The `Assembly` property is set during object creation and cannot be changed afterward. This design ensures that the metadata properties remain consistent and predictable throughout the lifetime of the `yyAssemblyInfo` instance.

Example:
```csharp
public Assembly Assembly { get; private set; }

public yyAssemblyInfo(Assembly assembly)
{
    Assembly = assembly;
    // Initialize lazy properties...
}
```

---

### **Detailed Property Breakdown**

#### **Essential Properties**
These properties provide direct access to key assembly information:
- **`Location`**: The physical file path of the assembly.
- **`FullName`**: A detailed identifier string for the assembly.
- **`Version`**: The version of the assembly.

#### **Attribute-Based Properties**
These properties are derived from custom attributes of the assembly:
- **`Title`**: The display name of the assembly.
- **`Company`**: The company associated with the assembly.
- **`Product`**: The product name.
- **`Configuration`**: The build configuration (e.g., Debug or Release).

#### **Static Properties for Common Assemblies**
The class includes static properties for convenient access to frequently used assemblies:
- **`AppAssembly`**: Retrieves information about the entry assembly (the main application).
- **`LibraryAssembly`**: Retrieves information about the executing assembly (the library itself).

Example:
```csharp
public static yyAssemblyInfo? AppAssembly => _appAssembly.Value;

public static yyAssemblyInfo LibraryAssembly => _libraryAssembly.Value;
```

---

### **Trade-Offs and Considerations**

1. **Why Use Lazy Initialization?**
   Lazy initialization reduces the overhead of computing properties that might never be accessed. This is particularly important for attributes like `Configuration` and `Description`, which are less commonly used in many applications.

2. **Why Make `Assembly` Immutable?**
   Allowing the `Assembly` property to be mutable could lead to inconsistent or invalid states. By making it immutable, the class ensures that all metadata properties are derived from a single, unchanging assembly.

3. **Exceptions During Property Access**
   If an invalid or null assembly is used to create an instance of `yyAssemblyInfo`, exceptions may occur when accessing properties. This behavior enforces proper usage of the class.

---

### **Example Usage**

```csharp
var assembly = Assembly.GetExecutingAssembly();
var assemblyInfo = new yyAssemblyInfo(assembly);

// Access basic properties
Console.WriteLine($"Location: {assemblyInfo.Location}");
Console.WriteLine($"Version: {assemblyInfo.Version}");

// Access attribute-based properties
Console.WriteLine($"Title: {assemblyInfo.AssemblyTitle}");
Console.WriteLine($"Company: {assemblyInfo.Company}");
```

For frequently used assemblies, static properties can simplify access:
```csharp
Console.WriteLine($"App Assembly Full Name: {yyAssemblyInfo.AppAssembly?.FullName}");
Console.WriteLine($"Library Assembly Title: {yyAssemblyInfo.LibraryAssembly.AssemblyTitle}");
```

---

### **Conclusion**

The `yyAssemblyInfo` class is designed to provide a structured, efficient, and immutable way to access assembly metadata. By combining encapsulation, lazy initialization, and immutability, it balances performance and usability, making it a reliable tool for developers who need to work with assembly information.
