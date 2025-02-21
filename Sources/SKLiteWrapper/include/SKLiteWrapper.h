#ifndef SKLiteWrapper_h
#define SKLiteWrapper_h
#include <stdarg.h>
#include <sqlite3.h>

int skliteConfig(int option, va_list args);
int skliteDbConfig(sqlite3* db, int option, va_list args);

#endif /* SqliteWrapper_h */
