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
#rmtree("$current/lib/mono/gac");
#rmtree("$current/lib/mono/xbuild-frameworks");
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
#rmtree("$current/etc/xml");
rmtree("$current/lib/mono/xbuild");
rmtree("$current/lib/mono/Microsoft SDKs");
rmtree("$current/lib/mono/Microsoft F#");

#system("rm $current/lib/*.a");
#system("rm -r $current/lib/*.dSYM");
#system("rm -r $current/lib/*llvm.dylib");
#system("rm -r $current/lib/*llvm.0.dylib");
#system("rm -r $current/bin/*.dSYM");
system("rm -r $current/lib/mono/4.5/FSharp.*");
system("rm -r $current/lib/mono/4.0/FSharp.*");
system("rm -r $current/lib/mono/portable-*");
#system("rm -r $current/lib/libLTO.dylib");
#system("find $current/bin ! -name mono -type f -delete");
#system("rm $current/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache");
#system("rm $current/lib/gtk-2.0/2.10.0/immodules.cache");

mkpath("$current/etc/pango");
my $filename = "$current/etc/pango/pangorc";
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
print $fh "[Pango]\n";
print $fh "ModuleFiles = /Library/Frameworks/Mono.framework/Versions/3.6.0/etc/pango/pango.modules\n";
close $fh;

chdir($current);
my @array = `grep -RIl /Library/Frameworks/Mono *`;

my $relocatescript = "#!/bin/sh\n";
$relocatescript .= "DIR=\"\$( cd \"\$( dirname \"\${BASH_SOURCE[0]}\" )\" && pwd )\"\n";
$relocatescript .= "cd \$DIR\n";
foreach $line (@array)
{
	chomp($line);
	system("cp $line $line.in");
	$relocatescript .= "sed \"s,/Library/Frameworks/Mono.framework/Versions/3.6.0,\$DIR,g\" \"$line.in\" > \"$line\"\n";
}

my $filename = "$current/relocate_mono.sh";
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
print $fh $relocatescript;
close $fh;

print $relocatescript;