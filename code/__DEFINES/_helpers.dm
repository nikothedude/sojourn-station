// Stuff that is relatively "core" and is used in other defines/helpers

/// Stringifies whatever you put into it.
#define STRINGIFY(argument) #argument

/// subtypesof(), typesof() without the parent path
#define subtypesof(typepath) ( typesof(typepath) - typepath )
