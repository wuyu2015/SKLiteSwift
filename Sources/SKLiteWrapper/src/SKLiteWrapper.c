#include "SKLiteWrapper.h"

int skliteConfig(int option, va_list args) {
    return sqlite3_config(option, args);
}

int skliteDbConfig(sqlite3* db, int option, va_list args) {
    return sqlite3_db_config(db, option, args);
}
