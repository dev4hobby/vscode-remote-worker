#include <stdio.h>

int main(int argc, char **argv) {
    int a = 5;
    int b = 0;
    int result;

    result = a / b; // devide by zero exception

    printf("result: %d\n", result);
    return 0;
}
