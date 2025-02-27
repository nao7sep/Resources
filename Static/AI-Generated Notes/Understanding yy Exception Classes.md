### Understanding `yy` Exception Classes

Custom exception classes are essential in creating robust, maintainable code by clearly communicating what went wrong in specific scenarios. This article explains a series of custom exceptions (`yyArgumentException`, `yyInvalidOperationException`, etc.) designed to address various error situations in a consistent and meaningful way. Here's how these exceptions are intended to work and the rationale behind their design.

---

### **1. `yyArgumentException`**
#### **Purpose**:
`yyArgumentException` is thrown when one or more method arguments are invalid. This could include:
- Arguments being `null` when they shouldn't be.
- A type mismatch.
- Arguments falling outside an acceptable range.

#### **Design Philosophy**:
While .NET provides specific exceptions for some argument-related issues (e.g., `ArgumentNullException`, `ArgumentOutOfRangeException`), this can feel inconsistent. Some edge cases lack specific exceptions, while others have overly granular ones. By creating a single, consistent `yyArgumentException` class that always requires a message, this approach simplifies handling such errors.

#### **Example**:
```csharp
if (age < 0)
{
    throw new yyArgumentException("Age cannot be negative.");
}
```

---

### **2. `yyInvalidOperationException`**
#### **Purpose**:
This exception is used when arguments are valid, but the operation cannot proceed because the object is in an invalid state. Typical scenarios include:
- Calling a method before necessary prerequisites are completed.
- Invoking operations in the wrong sequence.

#### **Design Philosophy**:
`yyInvalidOperationException` ensures a clear separation between errors caused by invalid arguments and those due to improper usage of an object's state.

#### **Example**:
```csharp
if (!_isConnected)
{
    throw new yyInvalidOperationException("Operation requires an active connection.");
}
```

---

### **3. `yyFormatException`**
#### **Purpose**:
This exception is thrown when:
- Arguments are valid, and the operation is appropriate.
- During execution, a format-related issue arises, such as parsing a broken file format or malformed input.

#### **Design Philosophy**:
The key distinction of `yyFormatException` is that the error occurs not from something a user can immediately recognize (like an invalid argument) but from format validation during processing.

#### **Example**:
```csharp
if (!TryParseJson(jsonString, out _))
{
    throw new yyFormatException("The provided JSON string is invalid.");
}
```

---

### **4. `yyInvalidDataException`**
#### **Purpose**:
This exception is for errors caused by inconsistencies in the data. For example:
- A property within an object has an invalid or contradictory value.
- Data relationships are violated (e.g., a vehicle marked as a motorbike but having four tires).

#### **Design Philosophy**:
Unlike `yyFormatException`, which deals with format-related errors, `yyInvalidDataException` addresses logical inconsistencies within data. The error is detectable only after parsing or further inspection of the data.

#### **Example**:
```csharp
if (vehicle.Type == "Motorbike" && vehicle.Tires.Count != 2)
{
    throw new yyInvalidDataException("Motorbike cannot have more than 2 tires.");
}
```

---

### **5. `yyObjectDisposedException`**
#### **Purpose**:
This exception is thrown when an operation is attempted on a disposed object that cannot be reused.

#### **Design Philosophy**:
Aligning with the .NET `ObjectDisposedException`, `yyObjectDisposedException` ensures users are explicitly informed that the object's lifecycle has ended.

#### **Example**:
```csharp
if (_disposed)
{
    throw new yyObjectDisposedException("Cannot perform operation on a disposed object.");
}
```

---

### **6. `yyNotImplementedException`**
#### **Purpose**:
This exception is used when a method or functionality has not been implemented yet, typically as a placeholder.

#### **Design Philosophy**:
It reflects incomplete development, signaling that the developer has yet to provide the functionality.

#### **Example**:
```csharp
public void SomeFeature()
{
    throw new yyNotImplementedException("This feature is not yet implemented.");
}
```

---

### **7. `yyNotSupportedException`**
#### **Purpose**:
This exception is thrown when a method or feature is deliberately not supported, even if it could theoretically be implemented.

#### **Design Philosophy**:
It communicates intentional design choices, distinguishing unsupported scenarios from incomplete development (`yyNotImplementedException`).

#### **Example**:
```csharp
public void ExportToFormat(string format)
{
    if (format != "JSON" && format != "XML")
    {
        throw new yyNotSupportedException($"Export to {format} is not supported.");
    }
}
```

---

### **8. `yyException`**
#### **Purpose**:
This is a catch-all exception for cases that do not fit any of the more specific exceptions listed above.

#### **Design Philosophy**:
`yyException` serves as a last-resort exception. If similar issues arise frequently, a new specific exception class should be created instead of relying on `yyException`.

#### **Example**:
```csharp
throw new yyException("An unexpected error occurred.");
```

---

### **Conclusion**
These `yy` exception classes provide a structured and consistent approach to error handling. By categorizing errors based on their nature—whether argument-related, state-dependent, format-specific, or data-driven—developers can create more readable, maintainable, and user-friendly applications. Each class has a clear and well-defined purpose, ensuring that errors are communicated effectively and appropriately addressed.
