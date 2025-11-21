#include <unistd.h>
#include <sys/syscall.h>

int main() {
    const char *str = "y\n";
    while (1) {
        syscall(SYS_write, 1, str, 2);
    }
}
