# test strings

START TRANSACTION;

CREATE FUNCTION capi04(inp STRING) RETURNS STRING LANGUAGE C {
#include <string.h>

	result->initialize(result, inp.count);
	for(size_t i = 0; i < inp.count; i++) {
		if (inp.is_null(inp.data[i])) {
			result->data[i] = result->null_value;
		} else {
			// the contract says we must use "malloc" to allocate for the result strings
			// "malloc" is a function pointer that actually points to GDKmalloc
			result->data[i] = malloc(strlen(inp.data[i]) + 2);
			strcpy(result->data[i] + 1, inp.data[i]);
			result->data[i][0] = 'H';
		}
	}
};

CREATE TABLE strings(i STRING);
INSERT INTO strings VALUES ('ello'), ('ow'), (NULL), ('onestly?'), ('annes');

SELECT capi04(i) FROM strings;

DROP FUNCTION capi04;

# try to modify one of the input strings
CREATE FUNCTION capi04(inp STRING) RETURNS STRING LANGUAGE C {
	result->initialize(result, inp.count);
	for(size_t i = 0; i < inp.count; i++) {
		result->data[i][0] = 'h';
	}
};

SELECT capi04(i) FROM strings;

ROLLBACK;



