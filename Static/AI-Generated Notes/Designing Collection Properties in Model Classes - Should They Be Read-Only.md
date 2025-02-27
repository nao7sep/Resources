### Designing Collection Properties in Model Classes: Should They Be Read-Only?

When designing model classes in C#, a common question arises about the best way to implement collection properties like `IList<string> Names`. Key considerations include whether the property should be read-only or writable and how to handle its initialization. This article explores the trade-offs and provides recommendations for designing collection properties effectively.

---

#### **Read-Only vs Writable Properties**

The first decision to make is whether the property should be read-only or writable.

1. **Read-Only Properties (Recommended for Immutability)**
   - Expose the collection as read-only using types like `IReadOnlyList<T>` or `IEnumerable<T>`, and initialize it to an empty collection (e.g., `new List<T>()`).
   - **Benefits**:
     - Promotes immutability, reducing the risk of unintended modifications.
     - Simplifies usage by ensuring the property is always in a valid state.
     - Differentiates between "unset" (`null`) and "set but empty" (`new List<T>()`).
   - **Example**:
     ```csharp
     public IReadOnlyList<string> Names { get; } = new List<string>();
     ```

2. **Writable Properties**
   - Use writable properties if the collection needs to be reassigned after the object is created.
   - If distinguishing "unset" from "set to empty" is important, consider using a nullable type (`IList<string>?`).
   - **Example**:
     ```csharp
     public IList<string>? Names { get; set; } // Nullable to indicate uninitialized state.
     ```

---

#### **Nullable vs Non-Nullable Collections**

The choice between nullable and non-nullable collections impacts how the property behaves when uninitialized.

1. **Nullable Collection (`IList<string>?`)**
   - Use a nullable collection if you want to allow `null` to represent an "unset" state. This is useful when distinguishing between "unset" and "set to empty" is meaningful, such as in optional configuration or deserialization.
   - **Example**:
     ```csharp
     public IList<string>? Names { get; set; }
     ```

2. **Non-Nullable Collection (`IList<string>` or `IReadOnlyList<string>`)**
   - Use a non-nullable collection if you want the property to always have a valid collection, even if it’s empty. This approach eliminates the need for `null` checks in client code.
   - Initialize the property to an empty collection (`new List<string>()`) in the constructor or inline.
   - **Example**:
     ```csharp
     public IList<string> Names { get; set; } = new List<string>();
     ```

---

#### **Null vs Empty: Understanding the Difference**

Deciding whether to allow `null` for a collection often depends on the context:

1. **Allowing `null` to Indicate "Unset"**
   - A nullable collection (`IList<string>?`) can represent a meaningful "unset" state, which is different from an empty collection.
   - This is particularly useful in scenarios like API responses or configuration models, where a `null` value might indicate that a property was not provided.

2. **Defaulting to an Empty Collection**
   - Initializing the collection to an empty state simplifies usage. Client code does not need to check for `null`, as the property is always initialized.
   - This treats "unset" and "empty" as equivalent, which is often sufficient in many applications.

---

#### **Serialization Considerations**

If the model is used in serialization (e.g., JSON), how the property is initialized impacts the serialized output:
- A `null` collection might not be serialized at all or could appear explicitly as `null` in the output.
- An empty collection is typically serialized as an empty array (`[]`).

To ensure consistent behavior, consider using JSON configuration options like `JsonSerializerOptions.DefaultIgnoreCondition` or `[JsonProperty]` attributes.

---

#### **Recommendations**

1. **Default to Non-Nullable and Initialize with an Empty Collection**
   - This simplifies client code, as `null` checks are unnecessary.
   - Use a read-only type like `IReadOnlyList<T>` if the collection should not be modified directly.

2. **Use Nullable if "Unset" is Meaningful**
   - If distinguishing between "unset" and "set to empty" is critical, use a nullable collection (`IList<T>?`) and document this behavior clearly.

---

#### **Example Design**

Here’s an example of how to combine these principles:

```csharp
public class Model
{
    // Non-nullable property, initialized to an empty collection.
    public IReadOnlyList<string> Names { get; } = new List<string>();

    // Nullable property, allowing distinction between "unset" and "empty."
    public IList<string>? OptionalNames { get; set; }
}
```

---

### **Conclusion**

When designing collection properties in model classes, consider the specific requirements of your application. If simplicity and immutability are priorities, use non-nullable collections and initialize them to an empty state. If distinguishing between "unset" and "set but empty" is important, consider nullable collections. By carefully selecting the approach that aligns with your application's needs, you can create more robust and maintainable model classes.
