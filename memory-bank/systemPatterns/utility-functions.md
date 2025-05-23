# Utility Functions

The codebase uses a variety of utility functions to perform common tasks, such as string manipulation, data conversion, and data validation. These functions are typically located in the `src/utils` directory.

## Example: `LogicUtils.res`

The `src/utils/LogicUtils.res` file contains a number of utility functions, including:

- `isEmptyString`: Checks if a string is empty.
- `isNonEmptyString`: Checks if a string is not empty.
- `methodStr`: Converts a `Fetch.requestMethod` to a string.
- `safeParseOpt`: Parses a string into JSON and returns an optional JSON value.
- `safeParse`: Parses a string into JSON and returns a JSON value with a null default.
- `getDictFromJsonObject`: Gets a dictionary from a JSON object.
- `convertMapObjectToDict`: Converts a map object to a dictionary.
- `removeDuplicate`: Removes duplicate elements from an array of strings.
- `sortBasedOnPriority`: Sorts an array of strings based on a priority array.
- `toCamelCase`: Converts a string to camel case.
- `toKebabCase`: Converts a string to kebab case.
- `kebabToSnakeCase`: Converts a string from kebab case to snake case.
- `getNameFromEmail`: Gets the name from an email address. This function splits the email string by "@" and capitalizes each name after splitting by ".".
- `getOptionString`: Gets an optional string from a dictionary.
- `getString`: Gets a string from a dictionary with a default value.
- `getStringFromJson`: Gets a string from a JSON value with a default value.
- `getBoolFromJson`: Gets a boolean from a JSON value with a default value.
- `getArrayFromJson`: Gets an array from a JSON value with a default value.
- `getOptionalArrayFromDict`: Gets an optional array from a dictionary.
- `getArrayFromDict`: Gets an array from a dictionary with a default value.
- `getArrayDataFromJson`: Gets an array of data from a JSON value, mapping each item to an object.
- `getStrArray`: Gets an array of strings from a dictionary.
- `getStrArrayFromJsonArray`: Gets an array of strings from a JSON array.
- `getStrArryFromJson`: Gets an array of strings from a JSON value.
- `getOptionStrArrayFromJson`: Gets an optional array of strings from a JSON value.
- `getStrArrayFromDict`: Gets an array of strings from a dictionary with a default value.
- `getOptionStrArrayFromDict`: Gets an optional array of strings from a dictionary.
- `getNonEmptyString`: Gets a non-empty string.
- `getNonEmptyArray`: Gets a non-empty array.
- `getOptionBool`: Gets an optional boolean from a dictionary.
- `getBool`: Gets a boolean from a dictionary with a default value.
- `getJsonObjectFromDict`: Gets a JSON object from a dictionary.
- `getvalFromDict`: Gets a value from a dictionary.
- `getBoolFromString`: Gets a boolean from a string.
- `getStringFromBool`: Gets a string from a boolean.
- `getIntFromString`: Gets an integer from a string.
- `getOptionIntFromString`: Gets an optional integer from a string.
- `getOptionFloatFromString`: Gets an optional float from a string.
- `getFloatFromString`: Gets a float from a string.
- `getIntFromJson`: Gets an integer from a JSON value.
- `getOptionIntFromJson`: Gets an optional integer from a JSON value.
- `getOptionFloatFromJson`: Gets an optional float from a JSON value.
- `getFloatFromJson`: Gets a float from a JSON value.
- `getInt`: Gets an integer from a dictionary with a default value.
- `getOptionInt`: Gets an optional integer from a dictionary.
- `getOptionFloat`: Gets an optional float from a dictionary.
- `getFloat`: Gets a float from a dictionary with a default value.
- `getObj`: Gets an object from a dictionary with a default value.
- `getDictFromUrlSearchParams`: Gets a dictionary from URL search parameters.
- `setDictNull`: Sets a dictionary value to null.
- `setOptionString`: Sets an optional string in a dictionary.
- `setOptionJson`: Sets an optional JSON value in a dictionary.
- `setOptionBool`: Sets an optional boolean in a dictionary.
- `setOptionArray`: Sets an optional array in a dictionary.
- `setOptionDict`: Sets an optional dictionary in a dictionary.
- `setOptionInt`: Sets an optional integer in a dictionary.
- `mapOptionOrDefault`: Maps an optional value to a default value.
- `capitalizeString`: Capitalizes a string.
- `snakeToCamel`: Converts a string from snake case to camel case.
- `camelToSnake`: Converts a string from camel case to snake case.
- `userNameToTitle`: Converts a user name to a title.
- `camelCaseToTitle`: Converts a camel case string to a title. This function capitalizes the input string and replaces the camel case with spaces.
- `isContainingStringLowercase`: Checks if a string contains a substring in lowercase.
- `snakeToTitle`: Converts a string from snake case to a title. This function splits the input string by "\_" and capitalizes each word.
- `titleToSnake`: Converts a string from a title to snake case. This function splits the input string by " " and converts each word to lowercase, joining them with "\_".
- `getIntFromString`: Gets an integer from a string.
- `removeTrailingZero`: Removes trailing zeros from a numeric string.
- `shortNum`: Shortens a number.
- `latencyShortNum`: Shortens a latency value.
- `checkEmptyJson`: Checks if a JSON value is empty.
- `numericArraySortComperator`: A comparator for sorting numeric arrays.
- `isEmptyDict`: Checks if a dictionary is empty.
- `isNullJson`: Checks if a JSON value is null.
- `stringReplaceAll`: Replaces all occurrences of a string in another string.
- `getUniqueArray`: Gets a unique array.
- `getFirstLetterCaps`: Gets the first letter of each word in a string in caps.
- `getDictfromDict`: Gets a dictionary from a dictionary.
- `checkLeapYear`: Checks if a year is a leap year.
- `getValueFromArray`: Gets a value from an array.
- `isEqualStringArr`: Checks if two string arrays are equal.
- `getDefaultNumberFormat`: Gets the default number format.
- `indianShortNum`: Shortens a number using the Indian number format.
- `convertNewLineSaperatedDataToArrayOfJson`: Converts newline separated data to an array of JSON values.
- `getTypeValue`: Gets a type value.
- `formatCurrency`: Formats a currency.
- `formatAmount`: Formats an amount.
- `valueFormatter`: Formats a value based on its type.
- `getObjectArrayFromJson`: Gets an array of objects from a JSON value.
- `getListHead`: Gets the head of a list.
- `dataMerge`: Merges data.
- `getJsonFromStr`: Gets JSON from a string.
- `compareLogic`: Compares two values.
- `getJsonFromArrayOfJson`: Gets JSON from an array of JSON values.
- `getTitle`: Gets the title of a string.
- `regex`: Creates a regular expression. This function creates a regular expression with the given search string.
- `checkStringStartsWithSubstring`: Checks if a string starts with a substring.
- `listOfMatchedText`: Gets a list of matched text. This function returns a list of matched text based on a search string.
- `getJsonFromArrayOfString`: Gets JSON from an array of strings.
- `truncateFileNameWithEllipses`: Truncates a file name with ellipses. This function truncates a file name with ellipses if it exceeds the maximum text length.
- `getDaysDiffForDates`: Gets the difference in days between two dates.
- `getOptionalFromNullable`: Gets an optional value from a nullable value.
- `getValFromNullableValue`: Gets a value from a nullable value.
- `dateFormat`: Formats a date.
- `deleteNestedKeys`: Deletes nested keys from a dictionary.
- `removeTrailingSlash`: Removes a trailing slash from a string.
- `getMappedValueFromArrayOfJson`: Gets a mapped value from an array of JSON values.
- `uniqueObjectFromArrayOfObjects`: Gets a unique object from an array of objects.
