#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char* toupperString(char* originalString) {
	char* upperString = (char*) malloc(sizeof(char) * strlen(originalString));
	int i;

	for (i = 0; i < strlen(originalString); ++i) {
		upperString[i] = toupper(originalString[i]);
	}

	return upperString;
}

char* formatRegularName(char* regularName) {
	char* formattedRegularName = (char*) malloc(sizeof(char) * strlen(regularName));
	int i;

	for (i = 0; i < strlen(regularName); ++i) {
		if (i == 0) {
			formattedRegularName[i] = toupper(regularName[i]);
		}
		else {
			formattedRegularName[i] = tolower(regularName[i]);
		}
	}

	return formattedRegularName;
}

int main() {
	printf("\n\ntoupperString()\n");

	printf("expected: \"\" actual: \"%s\"\n", toupperString(""));
	printf("expected: \"N\" actual: \"%s\"\n", toupperString("N"));
	printf("expected: \"N\" actual: \"%s\"\n", toupperString("n"));
	printf("expected: \"TESTE\" actual: \"%s\"\n", toupperString("teste"));

	printf("\n\nformatRegularName()\n");

	printf("expected: \"\" actual: \"%s\"\n", formatRegularName(""));
	printf("expected: \"R\" actual: \"%s\"\n", formatRegularName("R"));
	printf("expected: \"Teste\" actual: \"%s\"\n", formatRegularName("teste"));
	// http://www.coisinha.com.br/miguxeitor/
	printf("expected: \"Testi\" actual: \"%s\"\n", formatRegularName("tesTI"));

	return 0;
}
