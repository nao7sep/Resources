# Coding Guidelines

## Preparation

When there are many source files, they should be organized into a simple hierarchical structure. Do not create a directory like "Source" just to group all the source files together. While it’s possible to differentiate between source files and others such as UI files, this leads to disorganization, and source files might be related to those other files. They might need to be placed in the project's root directory.

## Design

Each class should be moderately SOLID. Aiming for perfection can delay development, so consider what is "moderate". Asking GitHub Copilot whether each source file is SOLID can be useful.

Do not create static classes that contain static properties which are updated through static methods. Such cases should instead utilize static properties that only get instances of other classes.

When creating properties for a collection, it is important to appropriately choose between interfaces and regular classes. Within model classes, properties of interfaces that are nullable and have get/set are suitable. In regular classes, including properties as non-nullable and with get/private-set of regular classes, which are more functional and performant, is good. Here, "model classes" refer to those that undergo conversion with JSON or data mapping with other instances.

Do not give excessive customization to the code. For example, it's fine to fall back to Environment.NewLine for line breaks and Encoding.UTF8 for encoding. Designing to allow specifying alternatives or automatically switching based on the environment is costly both to implement and to use.

## Implementation

Use Lazy class as much as possible to have many properties initialized only when needed. This not only speeds up startup but also contributes to better SOLID principles.

Collection properties' names should be decided based on their contents, not their form or structure. This is fine in regular classes, but in implementing generic classes, one might mistakenly prefer generic names. In such instances, "Items" is better than "List".

Standardize variable names appropriately. For value types or enums, consider "value"; for DateTime, "utc" or "localTime"; for objects or instances, "object" or "obj"; for strings, "string" or "str"; for arrays, "array"; for collections or IEnumerable, "items". Using "value" or "text" for strings might lead to conflicts with other arguments in the former case, and feel odd in plural form in the latter case.

JSON key names should be lowercase identifiers connected by underscores. If there’s a possibility of user editing, key comparison should be case-insensitive. Where performance is a concern, JSON might not be suitable.

Methods for instance conversion or preprocessing should return null or an equivalent when given null. For example, splitting a string into lines should return an empty array or collection even if the input is null. Null not only signifies "undefined" or "unset" but also "fallback to default value". Exclusively removing null in simple conversions or preprocessing might undermine program stability. "Preprocessing" here refers to operations like Trim that are "safe to call multiple times".

Use IsNullOrWhiteSpace more actively than IsNullOrEmpty. Performance differences are negligible as it usually matches early on, and the latter confirms if the string contains "visible characters, hence valid." Use the former only when certain conditions like "non-null means a definite value exists" are met within your code.

Actively trim/optimize user-entered strings. Markdown assigns meaning to trailing whitespace, but having invisible elements carry meaning might feel odd to many besides myself. Successive blank lines, for example, are only useful in cases like scrolling to reveal quiz answers. In web applications with multiple contributors, trailing spaces or extra blank lines should not be exploited to annoy others.

Ensure callers of each method can access all intermediate data generated within that method. Examples include responses from servers or temporarily generated paths.

Verify that all disposable instances are disposed of.

## Quality Control

Split large classes into partials and organize logic into *Helper.cs files to separate UI and logic, especially in tightly coupled frameworks.

Add summary comments to thread-unsafe classes or methods, enabling users to lock them as necessary.

When adding features to libraries, distinguish whether it's for a personal app or a system used by many. For the latter, imagine scenarios like thousands of users accessing a feature simultaneously or generating thousands of instances, anticipating potential overload.

## Check

Ensure no TODO comments remain in source files.

Specify JsonConverter for each property in model classes as needed.

Ensure the output string is visible. Apply GetVisibleString to places that could be null or empty strings.

Ensure output messages are uniformly formatted.

Hyphens, not underscores, are used in the filename. Underscores may overlap with the underline in urls.

https://developers.google.com/search/docs/crawling-indexing/url-structure
