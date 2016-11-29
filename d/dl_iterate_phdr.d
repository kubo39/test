// core.sys.linux.link.dl_iterate_phdr_cb is not visible, this is work-around.

import std.stdio;
import core.sys.linux.elf;


version(CRuntime_Glibc):
version(linux):

extern (C)
{
    struct dl_phdr_info
    {
        Elf64_Addr dlpi_addr;
        const char *dlpi_name;
        const Elf64_Phdr* dlpi_phdr;
        Elf64_Half dlpi_phnum;
    }

    alias callback_ = int function(dl_phdr_info *info,
                                   size_t size, void *data);

    int dl_iterate_phdr(callback_ callback, void *data);

    int callback(dl_phdr_info *info, size_t size, void *data)
    {
        writefln("name=%s (%d segments)", info.dlpi_name, info.dlpi_phnum);
        foreach (i; 0 .. info.dlpi_phnum)
            writefln("\t\t header %2d: address=%x", i,
                     cast(void*) (info.dlpi_addr + info.dlpi_phdr[i].p_vaddr));
        return 0;
    }
}

void main()
{
    dl_iterate_phdr(&callback, null);
}
