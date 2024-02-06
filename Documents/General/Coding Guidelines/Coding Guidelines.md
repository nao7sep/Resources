# Coding Guidelines

## Preparation

If there are many source files, they should be organized into a simple hierarchical structure. Do not create a directory like "Source" just to gather all source files in one place. Doing so might distinguish them from other files such as UI files, but it leads to clutter and those files might also be associated with source files. They may need to be placed in the project's root directory.

## Design

Each class should be moderately SOLID. Aiming for perfection can delay development, so consider what is "moderate". It can also be useful to ask GitHub Copilot whether each source file is SOLID or not.

Do not create static classes that contain static properties updated by static methods. Instead, make such properties static and only include a getter that returns instances of other classes.

When creating properties in a collection, it is important to properly distinguish between interfaces and regular classes. Within a model class, properties that are nullable and handle interfaces with get/set are suitable. In regular classes, it is good to include regular classes that are superior in functionality and performance as properties with non-nullable get/private-set. Here, a "model class" refers to something that undergoes conversion with JSON or mapping of data with other instances.

Do not allow excessive customization of the code. For example, it's fine to fallback to Environment.NewLine for new lines, and to Encoding.UTF8 for encoding. Designing for fallback options or automatic switching depending on the environment incurs significant implementation and usage costs.

## Implementation

Use the Lazy class as much as possible to increase the number of properties that are initialized when needed. This not only speeds up startup but also contributes to improved SOLID principles.

The names of the properties in a collection should be determined by their contents, not their types or structures. For example, when creating a class for a list that automatically expands, a property name for the list's actual data should be "Items" rather than "List".

Keep variable names reasonably consistent. For value types or enums, use "value"; for DateTime, use "utc" or "localTime"; for objects or instances, use "object" or "obj"; for strings, use "string" or "str"; for arrays, use "array"; and for collections or IEnumerable, consider using "items". Using "value" or "text" for strings could lead to potential conflicts with other parameters in the former case, and the latter may feel awkward when pluralized.

JSON key names should be lowercase identifiers connected by underscores. If there's a possibility of user editing, key matching should be done without considering case. If performance is a concern, JSON is not suitable in the first place.

Methods for converting and preprocessing instances should return null or its equivalent when given null. For example, when splitting a string into lines, an input of null should still yield an empty array or List. Null not only means "indefinite" or "unset," but can also mean "I want you to fall back to a default value." Treating null as an error in simple conversions and preprocessing harms the stability of the program.

Prefer using IsNullOrWhiteSpace over IsNullOrEmpty. Usually, something will match early on, so the performance difference is negligible. Moreover, the latter allows for checking whether it's "a valid string containing visible characters." Use the former only when conditions like "a value certainly exists if it's not null" are guaranteed within the code you implemented.

For methods that return an alternative to IEnumerable, prepare both methods that return an array and those that return a List. While it can be easily converted, only preparing one can sometimes lead to double conversion.

Ensure that the caller of each method can access all intermediate data generated within that method. Examples include responses from servers or temporarily generated paths.

Ensure that all disposable instances are disposed of.

## Quality Management

Split a large class into partials, packing backend-like processes into *Helper.cs files. Even when developing with frameworks that tend to tightly couple UI and logic code, utilize two partial classes to separate UI and logic as much as possible.

For classes and methods that are not thread-safe, add summary comments so that users can lock them as necessary.

When adding functionality to a library, distinguish whether it is for an application used by one person or for a system used by many people. In the latter case, consider scenarios of overload, such as a thousand people accessing the feature simultaneously or a thousand instances being created.

If there is a significant sense of discomfort with the specifications of a library and you feel a psychological resistance to developing from it, do not hesitate to make destructive changes and greatly improve it. There have been several instances in the past where, despite not liking the specifications, development was stalled because changing them seemed too difficult, but I always ended up rewriting them in the end. Hesitating is just a waste of time.

## Check

Ensure no TODO comments remain in the source files.

Verify that JsonConverter is specified for each property of the model class as necessary.

Ensure the output strings are visible. Apply GetVisibleString where the output could be null or an empty string.

Ensure that the format of the messages output is adequately organized, allowing users to understand them immediately.

Confirm that hyphens, not underscores, are used in file names. This is because underscores can overlap with the underline in URLs.

https://developers.google.com/search/docs/crawling-indexing/url-structure
