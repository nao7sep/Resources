<!--
2024-01-15
Version: 0.1
Yoshinao Inoguchi
-->

# Coding Guidelines

## Preparation

* Source files should be in simply structured subdirectories if they need to be grouped
    * No meaningless subdirectories like "Source" just to put them together

## Design

* Each class is SOLID enough
    * Ask GitHub Copilot about it
* No static classes containing static properties updated by nearby static methods
    * They must be static get-only properties that return instance classes' instances
* Choosing between interfaces and concrete classes for collection properties
    * Model class properties should be Nullable get/set interfaces like IList for flexibility
        * Let's say a "model class" is any class that is converted from or to JSON and has its JSON property names defined
    * More specific classes' properties should be non-Nullable get/private-set concrete classes for functionality and performance
* Avoid excessive customization capabilities
    * Like new lines can fallback to Environment.NewLine and encodings to Encoding.UTF8
    * Properties like DefaultFallbackEncoding would be rarely customized

## Implementation

* Lazy/JIT initialization of properties
* Collection properties must be named after their contents rather than their types/structures
    * A List containing items for the upper class for example would be "Items" rather than "List"
* Names for general variables: "value" for enums and value types, "utc" or "localTime" for DateTime, "obj" for objects and instances, "str" for strings, "array" for arrays, "items" for IList and IEnumerable
* JSON property names should be in small letters containing underscores and should be treated case-insensitively if there's a chance that they are updated by users
* Conversion methods return null when given null
    * Methods that take meaningful arguments must throw or return error when null is given
    * Methods that are casually called for preprocessing of strings shouldnt
* Use IsNullOrWhiteSpace rather than IsNullOrEmpty
    * We determine whether the strings contain visible meaningful contents or not
* Trim/optimize user input strings
* Ensure all intermediate data can be retrieved by callers of the methods
    * Response strings from servers, temporarily generated paths, etc
* All disposable instances are disposed

## Quality

<!-- Guidelines that are not required for function but improve quality. -->

* Create a *Helper.cs file to make the class partial to separate UI-related code and backend operations
    * If the additional file contains extension methods, it can be a static class with "Helper" as a suffix in its name
* No thread-unsafe classes without warnings
    * Add summaries at least
* For each class, ask, "Can this be a part of a large system with a thousand users?"
    * Expect scalability, multi-threading, failure-safe mechanisms, etc
* Look for missing comments that might help other developers

## Checks

* No todo comments are left
* JsonConverter is specified wherever one can make the implementation safer
* Ensure output strings are visible
    * Call GetVisibleString or something similar for any output
* Check message formats
    * Search for "catch", "Console", "MessageBox", "yySimpleLogger", etc
* Use hyphens rather then underscores for file names
    * Suggested by Google: https://developers.google.com/search/docs/crawling-indexing/url-structure
    * Underscores often overlap with URLs' underlines
* Ask GitHub Copilot about potential risks/improvements
    * Open a source file on Visual Studio Code and ask quality-related questions
* Analyze code using tools such as the built-in functionality of Visual Studio
