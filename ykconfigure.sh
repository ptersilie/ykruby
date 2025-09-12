# Run the configure scripts with some yk flags
CC=`yk-config debug --cc` LDFLAGS=`yk-config debug --ldflags` ../configure --disable-yjit optflags="-O0 -fno-omit-frame-pointer"

# Patch the Makefile with some extras we require

# Add c and cpp flags
EXTRAARCHFLAGS=`yk-config debug --cflags --cppflags`
sed -i "s@ARCH_FLAG =@ARCH_FLAG = $EXTRAARCHFLAGS@" Makefile
# Remove stack-protection, visibility, and pie flags.
sed -i "s/-fstack-protector-strong//" Makefile
sed -i "s/-fvisibility=hidden//" Makefile
sed -i "s/-fPIE//" Makefile
sed -i "s/-pie//" Makefile
# Add the ykcapi library.
sed -i '/^MAINLIBS =/ s/$/ -lykcapi/' Makefile
