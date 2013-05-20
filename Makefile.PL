use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;
use Config;

my $ldd_flags;
if (! ($Config{osname} =~ /Win/)) {
	chdir("webp-src");
	system("./configure --disable-shared");
	system("make");
	chdir("..");
	my @objs = split(/\n/, `find webp-src/src -name "*.o"`);

	$ldd_flags = " -lpthread " . join(" ", @objs);
}
else {
	my @objs = <precompiled\\win32\\*.o>;
	$ldd_flags = " " . join(" ", @objs) . " ";
}



WriteMakefile(
    NAME             => 'Image::WebP',
    AUTHOR           => q{Zargener <zargener@gmail.com>},
    VERSION_FROM     => 'lib/Image/WebP.pm',
    ABSTRACT_FROM    => 'lib/Image/WebP.pm',
    LICENSE          => 'Artistic_2_0',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        #'ABC'              => 1.6,
        #'Foo::Bar::Module' => 5.0401,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Image-WebP-*' },
    LDDLFLAGS => $Config{lddlflags} . $ldd_flags
);
