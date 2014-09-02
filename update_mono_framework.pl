use File::Path;
use File::Basename qw(dirname basename fileparse);
my $scriptDir = File::Spec->rel2abs( dirname($0) );

my $mf = "$scriptDir/template.app/Contents/Frameworks/Mono.framework";

rmtree($mf);

system("mkdir $mf");
system("mkdir $mf/Versions");
my $current = "$mf/Versions/Current";
system("mkdir $current");
system("cp -r /Library/Frameworks/Mono.framework/Versions/Current/* $current");
rmtree("$current/lib/mono/gac");
rmtree("$current/lib/mono/xbuild-frameworks");
rmtree("$current/lib/mono/monodroid");
rmtree("$current/lib/mono/monotouch");
rmtree("$current/lib/ironruby");
rmtree("$current/lib/ironpython");
rmtree("$current/lib/mono/boo");
rmtree("$current/lib/mono/Reference Assemblies");
rmtree("$current/lib/monodoc");
rmtree("$current/include");
rmtree("$current/share/xml");
rmtree("$current/share/autoconf");
rmtree("$current/share/automake-1.13");
rmtree("$current/share/libtool");
rmtree("$current/share/man");
rmtree("$current/etc/xml");

system("rm $current/lib/*.a");
system("rm -r $current/lib/*.dSYM");
system("rm -r $current/lib/*llvm.dylib");
system("rm -r $current/lib/*llvm.0.dylib");
system("rm -r $current/bin/*.dSYM");
system("rm -r $current/lib/mono/4.5/FSharp.*");
system("rm -r $current/lib/mono/4.0/FSharp.*");
system("rm -r $current/lib/mono/portable-*");
system("rm -r $current/bin/opt");
system("rm -r $current/bin/llc");
system("rm -r $current/lib/libLTO.dylib");
system("rm -r $current/bin/pedump");
