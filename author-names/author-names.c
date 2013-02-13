#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char* toupperString(char* originalString) {
	char* upperString = (char*) malloc(sizeof(char) * strlen(originalString));
	int i;

	if (strlen(originalString) == 0) {
		return originalString;
	}

	for (i = 0; i < strlen(originalString); ++i) {
		upperString[i] = toupper(originalString[i]);	

	}

	return upperString;
}

int main() {
	printf("expected: \"\" actual: \"%s\"\n", toupperString(""));
	printf("expected: \"N\" actual: \"%s\"\n", toupperString("N"));
	printf("expected: \"N\" actual: \"%s\"\n", toupperString("n"));
	printf("expected: \"NICOLAS\" actual: \"%s\"\n", toupperString("nicolas"));


	return 0;
}
