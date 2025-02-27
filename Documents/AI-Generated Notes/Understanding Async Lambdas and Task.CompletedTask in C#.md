# **Understanding Async Lambdas and Task.CompletedTask in C#**

## **Introduction**
When working with asynchronous programming in C#, developers often encounter scenarios where they need to pass a `Func<Task>` or `Func<CancellationToken, Task>` to an asynchronous method. This leads to questions about how different lambda expressions behave, when to use `async` lambdas, and whether returning `Task.CompletedTask` is a valid approach.

This article explores these topics and provides best practices to ensure maintainable and future-proof async code.

---

## **Are All `Func`s Executed Asynchronously?**
No, not all `Func`s execute asynchronously, even when passed to an `async` method. A `Func<T>` delegate can be either:
- **Synchronous**, executing immediately and returning a result.
- **Asynchronous**, returning a `Task` that represents an ongoing operation.

### **Example: Synchronous vs. Asynchronous Func**
```csharp
Func<int> syncFunc = () => 42;  // Synchronous
Func<Task<int>> asyncFunc = async () => await GetValueAsync();  // Asynchronous
```
If an `async` method accepts a `Func<Task>`, but a caller provides a synchronous method, the execution behavior may not be as expected.

---

## **Behavior of Different Lambda Expressions**
Consider an asynchronous method that accepts a `Func<Task>` parameter:

```csharp
static async Task ExecuteAsync(Func<Task> func)
{
    await func();
}
```

Now, let’s compare two lambda expressions when calling `ExecuteAsync`:

```csharp
await ExecuteAsync(() => SomeAsyncMethod());  // No async keyword
await ExecuteAsync(async () => await SomeAsyncMethod());  // Explicit async lambda
```

### **Case 1: `() => SomeAsyncMethod()` (Implicitly Returning Task)**
- `SomeAsyncMethod()` returns a `Task`, but the lambda itself does **not** use `async`.
- The method is called and a `Task` is returned, but nothing inside the lambda explicitly `await`s it.
- **If the caller of `ExecuteAsync` does not `await` the task, it may result in unintended fire-and-forget execution.**

### **Case 2: `async () => await SomeAsyncMethod()` (Explicitly Awaiting Task)**
- The `async` lambda ensures that `SomeAsyncMethod()` is awaited before the lambda completes.
- This guarantees proper execution flow and prevents potential race conditions.

#### **Key Takeaway:**
If a method is asynchronous, always ensure that the lambda explicitly awaits it using `async () => await ...`. This prevents unintended behavior.

---

## **Returning `Task.CompletedTask` in Async Lambdas**
Sometimes, you need to pass a function that currently does nothing but might perform asynchronous work in the future. The recommended way to handle this is to return `Task.CompletedTask`:

```csharp
Task DoNothingAsync() => Task.CompletedTask;
```

Now, when passing this method to an async function, there are several ways to structure the lambda:

### **✅ Best Approach (Direct Reference)**
```csharp
await ExecuteAsync(DoNothingAsync);
```
- This approach is **simple and efficient**.
- It avoids unnecessary overhead while ensuring correctness.

### **⚠️ Acceptable but Unnecessary**
```csharp
await ExecuteAsync(async () => await DoNothingAsync());
```
- This **works**, but it creates an **unnecessary async state machine**.
- Recommended **only if you plan to modify `DoNothingAsync` later to perform actual asynchronous work**.

### **❌ Incorrect: Forgetting `async` While Using `await`**
```csharp
await ExecuteAsync(() => await DoNothingAsync());  // ❌ Compilation error
```
- The `await` keyword must be inside an `async` function, so this results in a compilation error.

---

## **What If the Function Takes a CancellationToken?**
If your function is likely to be extended to perform heavy work and already accepts a `CancellationToken`, the lambda should match its signature:

```csharp
static async Task ExecuteAsync(Func<CancellationToken, Task> func, CancellationToken token)
{
    await func(token);
}
```

### **Recommended Approach**
```csharp
await ExecuteAsync(async (cancellationToken) => await DoNothingAsync(cancellationToken), cancellationToken);
```
- Even though `DoNothingAsync` currently does nothing, using `async` ensures that when asynchronous work is introduced, the lambda remains correct.

### **Alternative (Less Preferred)**
```csharp
await ExecuteAsync((cancellationToken) => DoNothingAsync(cancellationToken), cancellationToken);
```
- This works fine for now, but it **lacks the explicit `async` keyword**, which may lead to mistakes when modifying the function later.

#### **Key Takeaway:**
If the function **may** be extended to perform asynchronous work, **use an `async` lambda (`async (...) => await ...`)** to maintain a clear and consistent structure.

---

## **Final Recommendations**
### ✅ **Best Practices**
✔ **Always use `async () => await ...` for clarity and correctness.**
✔ **If passing a method reference, ensure the caller properly awaits it.**
✔ **Use `Task.CompletedTask` when an async method does nothing (for now).**
✔ **If `CancellationToken` is involved, pass it explicitly to maintain consistency.**

### ⚠️ **Things to Avoid**
❌ **Using `() => SomeAsyncMethod()` without `await` in cases where proper awaiting is required.**
❌ **Using unnecessary `async () => await SomeAsyncMethod()` when passing a method reference suffices.**
❌ **Forgetting the `async` keyword while trying to `await` inside a lambda.**

---

## **Conclusion**
Using `async` lambdas correctly in C# is crucial to maintaining clean, reliable, and scalable asynchronous code. By ensuring explicit `await` usage and structuring lambdas with future extensibility in mind, you can avoid common pitfalls and improve code maintainability. 🚀
