#PODNAME: DBD::Oracle::Troubleshooting::Hpux
#ABSTRACT: Tips and Hints to Troubleshoot DBD::Oracle on HP-UX


__END__
=pod

=head1 NAME

DBD::Oracle::Troubleshooting::Hpux - Tips and Hints to Troubleshoot DBD::Oracle on HP-UX

=head1 VERSION

version 1.50

=head1 INTRODUCTION

Building a working dynamically linked version of the Oracle DBD driver
on HP-UX (11.00) has been a challenge for many.  For months after taking
a new job, where HP-UX was the standard database server environment, I
had only been able to build a statically linked version of Perl and the
DBD-Oracle module on HP-UX 11.00.

Then Roger Foskett posted instructions for what turned out to be dynamic
build.  Rogers's post got me further than I had previously gotten.  In
fact, after resolving some undefined symbol errors, I succeeded where for
I had previously despaired of finding the time to hack out the right
incantation.

This F<README.hpux.txt> describes the combined knowledge of a number of
folks who invested many hours discovering a working set of build options.
The instructions in this file, which include building Perl from source,
will produce a working dynamically linked DBD-Oracle that can be used
with mod_perl and Apache.

See L<APPENDICES> for exact build configurations used by me an others.

For HPUX 11 on Itanium see also
http://www.nntp.perl.org/group/perl.dbi.users/23840

=head1 First things First:  Introduction

The reason you are even reading this file is because you want to connect
to an Oracle database from your perl program using the DBD::Oracle DBI
driver.  So before you start, install (at least the Oracle client
software) (SQL*Net, Pro*C, SQL*Plus) upon the machine you intend to
install Perl/DBI/DBD-Oracle.  You B<do not>, I repeat, I<do not> need to
build a database on this machine.

After you have installed the Oracle client software, B<test it!>. Make
sure you can connect to the target database using SQL*Plus (or any other
Oracle supplied tool).  The (gory) details of the install are beyond the
scope of this document, some information can be found in the section
L<Compiling on a Client Machine>, or see your friendly Oracle DBA.

One final remark, 3 years after this was first written.  This has been
updated numberous times over the years.  And some of the new biuld
recipe's see simpler than some of the original instructions in this file.

I think one reason the recipe is getting simpler may be that the build
hints, in the base perl build have gotten more right, as we have moved
from perl 5.6.1 to the 5.8.8 (now the stable version).

Someday, if I ever find myself building on HP again I should probably
update as many of these recipes (that I can test) by trying to remove
more of the special case stuff I have in my build scripts now.
Gram Ludlows's build for the default bundled C compiler shows that a lot
of this may no longer be necessary.

On the other hand, it would be bad if we deleted information that others
might need, so I err on the side of too much, in the hope that the
person who really needs the information, will not have to look beyond
this file.

   -- Lincoln

=head1 Build your own Perl

HP's default Perl is no good (and antique).

By default, HP-UX 11.00 delivered Perl 5.00503 until September 2001.
Others tell me that the default is a threaded GNUpro build of 5.6.1.
This is not what I found on our systems, and it probably depends on which
packages you install.  In any case, this version of Perl delivered by
HP will in all likelihood not work. Before you check, be sure to prevent
the perl4 located in /usr/contrib/bin from being the first Perl version
found in your $PATH.

As of application release September 2001, HP-UX 11.00 is shipped with
Perl-5.6.1 in /opt/perl. The first occurrence is on CD 5012-7954. The
build is a portable hppa-1.1 multithread build that supports large files
compiled with gcc-2.9-hppa-991112. When you have a modern system with a
hppa-2.0 architecture (PA8xxx processor) and/or the HP C-ANSI-C compiler
consider building your own Perl, which will surely outperform this
version.

If you are reading this, you have probably discovered that something did
not work.  To get a working version of the DBD-Oracle driver, we have to
start with a Perl that as been built with the correct compiler flags and
shared libraries.  This means that you must build your own version of
Perl from source.

See L<EXAMPLE FILES> for a copy of a makefile used by me to build Perl on
HP-UX and all other platforms on which he works (Sun and Red Hat).

The instructions below have been used for building a dynamically linked
working DBD-Oracle driver that works with mod_perl and Apache.  These
instructions are based on Perl 5.6.0 and 5.6.1, and 5.8.0.  To this
author's knowledge, they have not be tested on earlier versions of Perl.

Note that is important to build a B<non>-threaded Perl, but linked with
-lcl and -lpthread.   Since Oracle on HP uses libpthread, everything that
dynamically loads it (such as DBD-Oracle) must be built/linked
with '-lpthread -lcl'.  (When used with Apache, it and any associated
modules must also be built this way - otherwise all it does is core
dump when loading DBD::Oracle).

A good link that explains thread local storage problems is
http://my1.itrc.hp.com/cm/QuestionAnswer/1,1150,0x0d0a6d96588ad4118fef0090279cd0f9!0,00.html

One more note, it would appear that the README.hpux in the Perl 5.8.0
directory, is somewhat out of date, but is up-to-date in versions 5.8.3
and up.  H.Merijn Brand points out that Perl I<is> 64bit compliant when
the -Duse64bitall flag is used to Configure.  While Perl will be built
in a pure LP64 environment via the +DD64 flag is used, the +DA2.0w flag
is preferred on PA-RISC, and when an incantation can be concocted that
eliminates the noisy warnings the produces at link time, this will
probably become the default.  Older 64bit versions of GCC, are known to
be unable to build a good LP64 perl. And these flags will cause gcc to
barf. On HP-UX 11i (11.11), gcc-3.4.4 or gcc-3.4.5 is prefered over
gcc-4.0.2 (or older gcc-4 versions) as 64bit builds on PA-RISC with that
versions of the compiler are unreliable.

=head1 Compilers

=head2 HP Softbench Compiler

Both Roger Foskett, I and most others have been using the HP Softbench
C compiler normally installed in:

	/opt/softbench/bin/cc.

While the DBD-Oracle F<Makefile.PL> checks for some of the conditions
which, when met, we know will produce a working build, there are many
variations of Oracle installations and features.  Not all of these can
be tested by any one of us, if you discover a way to make a variation
which did not previously work, please submit patches to the Makefile.PL
to Tim Bunce, and patches to this README to me, and I will incorporate
them into the next README.

The instructions herein, have compiled, linked cleanly, and tested
cleanly using the HP softbench compiler, and Oracle 8.0.5 (32bit), and
Oracle 8.1.6, 8.1.7 (64 bit).  Oracle 8.1.5 will probably work as well.

Oracle 8.1.7.4 (32bit) with DBI-1.35 and DBD-Oracle-1.13 has been proven
to work on HP-UX 11.00 (64bit) with Perl 5.6.1, Perl 5.8.x using the
guidelines in this document for both HP-C-ANSI-C and gcc-3.2. Later
versions have been proven to work as well.  Current DBI-1.42 and
DBD-Oracle-1.16 have been proven to work.  This Oracle 9.2 client (at
least) should be used if you plan to do work with Unicode.  See the
DBD-Oracle POD/Man documentation.

=head2 gcc Compiler

As of gcc-3.4, perl-5.8.3 and up should build out-of-the box when
Configure is invoked with -Dcc=gcc. Please read README.hpux carefully
for the differences with HP C-ANSI-C. Once built, tested and installed,
both DBI and DBD-Oracle should be able to build against that perl
without trouble.

In the past, Waldemar Zurowski and Michael Schuh sent useful information
about builds of Perl with DBD-Oracle using gcc on HP-UX.  Both were able
to get working executables, and their explanations shed much light on
the issues.

Waldemar's build is described in L<Appendix A>, and Michael's is
described in L<Appendix C>.

While I have not reproduced either of these configurations, I believe
the information is complete enough (particularly in the aggregate) to
be helpful to others who might wish to replicate it.

If someone would be willing to submit a makefile equivalent to the
makefile in any of the examples from L<EXAMPLE FILES>, which uses gcc
to build Perl and the DBI/DBD-Oracle interfaces, I will be happy to
include it in the next README.

=head2 The "default" built in compiler 64bit build (/usr/bin/cc)

And now, at long last, we have a recipe for building perl and DBD-Oracle
using the default bundled C compiler.  Please see the L<Appendix B> build
instructions provided by Gram Ludlow, using the default /usr/bin/cc
bundled compiler. Please note that perl itself will I<NOT> build using
that compiler.

=head2 Just tell me the recipe...

If you are using the softbench compiler, just copy and modify my makefile.
A copy of this makefile, which I use to build Perl and the DBI interfaces
(and all other modules I use for that matter) on all platforms (HP, SUN
and Red Hat) can be found in F<README-files/hpux/Makefile-Lincoln>.  If you
want to skip reading the rest of this screed, try copying the makefile into
a directory where you have all your compressed tar balls, editing the macros
at the top, and running make.

It you are plan to give gcc a go, consider making modifications to this
makefile, and sending it back to me, as a GCC example.

=head2 Configure (doing it manually)

Once you have downloaded and unpacked the Perl sources (version 5.8.8
assumed here), you must configure Perl.  For those of you new to building
Perl from source, the Configure program will ask you a series of
questions about how to build Perl.  You may supply default answers to the
questions when you invoke the Configure program by command line flags.

We want to build a Perl that understands large files (over 2GB, wich is
the default for building perl on HP-UX), and that is incompatible with
v5.005 Perl scripts (compiling with v5.005 compatibility causes mod_perl
to complain about malloc pollution).  At the command prompt type:

    cd perl-5.8.8
    sh ./Configure -A prepend:libswanted='cl pthread ' -des

or, if you need a 64bit build

    sh ./Configure -A prepend:libswanted='cl pthread ' -Duse64bitall -des

Do not forget the trailing space inside the single quotes. This is also
described by H.Merijn Brand in the README.hpux from the perl core
distribution.

I use this in my standard build now. (See F<README-files/hpux/Makefile-Lincoln>)

When asked:

    Any additional cc flags? - Answer by prepending: I<+Z> to enable
    position independant code.

    For example:
    Any additional cc flags? [-D_HP-UX_SOURCE -Aa] -Ae +Z -z

Though this should be the default inmore recent perl versions.

Lastly, and this is optional, when asked:

    Do you want to install Perl as /usr/bin/perl? [y] n

    You may or may not want to install directly in /usr/bin/perl,
    many persons on HP install Perl in /opt/perl<version>/bin/perl and
    put a symbolic link to /usr/bin/perl.  Furthermore, you can supply
    the answer to this question by adding an additional switch to the
    invocation of Configure such as: Configure -Dprefix=/opt/perl

After you have answered the above questions, accept the default values
for all of the remaining questions.  You may press <Enter> for each
remaining question, or you may enter "& -d" (good idea) at the next
question and the Configure will go into auto-pilot and use the Perl
supplied defaults.

BTW: If you add -lcl and -lpthread to the end of the list it will not
work. I wasted a day and a half trying to figure out why I had lost the
recipe, before I realized that this was the problem. The symptom will
be that

   make test

of Perl itself will fail to load dynamic libraries.

You can check in the generated 'config.sh' that the options you selected
are correct.  If not, modify config.sh and then re-run ./Configure with
the '-d' option to process the config.sh file.

Build & Install

    make
    make test
    make install

If you are going to build mod_perl and Apache it has been suggested
that you modify Config.pm to the change the HP-UX ldflags & ccdlflags in
F</your/install/prefix/lib/5.6.0/PA-RISC2.0/Config.pm> as follows:

    ccdlflags=''
    cccdlflags='+Z'
    ldflags=' -L/usr/local/lib'

This is not necessary if you are not using mod_perl and Apache.

=head1 Build and Install DBI

    cd DBI-1.50
    Perl Makefile.PL
    make
    make test
    make install

=head1 Build and Install DBD-Oracle-1.07 and later

It is critical to setup your Oracle environmental variables.  Many people
do this incorrectly and spend days trying to get a working version of
DBD-Oracle.  Below are examples of a local database and a remote database
(i.e. the database is on a different machine than your Perl/DBI/DBD
installation) environmental variable setup.

Example (local database):

    export ORACLE_USERID=<validuser/validpasswd>
    export ORACLE_HOME=<path to oracle>
    export ORACLE_SID=<a valid instance>
    export SHLIB_PATH=$ORACLE_HOME/lib       #for 32bit HP
    export LD_LIBRARY_PATH=$ORACLE_HOME/lib  #for 64bit HP (I defined them both)

Note that HP-UX supports I<both> SHLIB_PATH I<and> LD_LIBRARY_PATH for
all libraries that need to be found, but that each library itself can
enable or disable any of the two, and can also set preference for the
order they are used, so please set them to the same value.

Example (remote database):

    export ORACLE_USERID=<validuser/validpasswd>
    export ORACLE_HOME=<path to oracle>
    export ORACLE_SID=@<valid tnsnames.ora entry>
    export SHLIB_PATH=$ORACLE_HOME/lib       #for 32bit HP
    export LD_LIBRARY_PATH=$ORACLE_HOME/lib  #for 64bit HP (I defined them both)

The standard mantra now works out of the box on HP-UX:

    cd DBD-Oracle-1.07  # or more recent version
    perl Makefile.PL
    make
    make test
    make install        # if all went smoothly

And with DBD-1.14 and later the following can be used:

    cd DBD-Oracle-1.14  # or more recent version
    perl Makefile.PL -l # uses a simple link to oracle's main library
    make
    make test
    make install        # if all went smoothly

If you have trouble, see the L<Trouble Shooting> instructions below, for
hints of what might be wrong... and send me a note, describing your
configuration, and what you did to fix it.

=head1 Trouble Shooting

=head2 "Unresolved symbol"

In general, find the symbols, edit the Makefile, and make test.

You'll have to modify the recipe accordingly, in my case the symbol
"LhtStrCreate" was unresolved. (Authors Note: thanks patch suggestions
by Jay Strauss this situation which occurs with Oracle 8.1.6 should
now be handled in Makefile.PL.)

1) Find the symbols.

   a) The following ksh/bash code (courtesy of Roger) will search
      from $ORACLE_HOME and below for Symbols in files in lib directories.
      Save the following to a file called "findSymbol".

   >>>>  CUT HERE <<<<<
   cd $ORACLE_HOME

   echo "\nThis takes a while, grepping a lot of stuff"
   echo "   ignore the \"no symbols\" warnings\n"

   sym=$1; shift;
   libs="*.sl"

   for lib in  $(find . -name $libs -print); do
      if nm -p $lib | grep -q $sym; then
         echo "found \"$sym\" in $lib"
      fi
   done
   >>>>> CUT HERE <<<<

      Note that on Itanium machines (HP-UX 11.23), the shared libraries
      have a .so extension instead of the .sl HP-UX uses on PA-RISC.

   b) Run it (replace "LhtStrCreate" with your "Unresolved symbol").
      For example, at my installation, findSymbols produced the
      following output:

      # chmod 755 findSymbols
      # ./findSymbol LhtStrCreate

      found "LhtStrCreate" in ./lib/libagtsh.sl
      found "LhtStrCreate" in ./lib/libclntsh.sl
      found "LhtStrCreate" in ./lib/libwtc8.sl

2) Edit the Makefile

In the previous step your unresolved symbol was found in one or more
library files.  You will need to edit the OTHERLDFLAGS makefile macro,
and add the missing libraries.

When you add those library files to OTHERLDFLAGS you must convert the
name from the actual name to the notation that OTHERLDFLAGS uses.

      libclntsh.sl         becomes =>	-lclntsh
      libagtsh.sl          becomes =>	-lagtsh
      libwtc8.sl           becomes =>	-lwtc8

That is, you replace the "lib" in the name to "-l" and remove the ".sl"
(or the .so).

You can edit the Makefile in 2 ways:

   a) Do this:

      perl -pi -e's/\b(OTHERLDFLAGS.*$)/$1 -lclntsh/' Makefile

   b) Using vi, emacs... edit the file, find OTHERLDFLAGS, and add the
      above "-l" entries to the end of the line.

      For example the line:
      OTHERLDFLAGS =  -L/opt/oracle/product/8.1.6/lib/... -lqsmashr

      Becomes:
      OTHERLDFLAGS =  -L/opt/oracle/product/8.1.6/lib/... -lqsmashr -lclntsh

3) make test

Perform a make test, if symbols are still unresolved repeat the editing
of the Makefile and make test again.

=head1 DBD-Oracle-1.06

You are strongly urged to upgrade. However here is what you may need to
know to get it or work, if you insist on using an earlier version.

Check the output that above command produces, to verify that

   -Wl,+n
   -W1,+s

is b<NOT> present. and that

   -lqsmashr

B<is> present.

If the version of Makefile.PL does not include the patch produced at the
time of this README.hpux,  then the above conditions will likely not be
met.
You can fix this as follows:

	perl -pi -e's/-Wl,\+[sn]//' Makefile

=head1 Building on a Oracle Client Machine

If you need to build or deliver the DBD-Oracle interface on or to a
machine upon which the Oracle database has not been installed you need
take the following into consideration:

=over

=item 1) Oracle files are needed for DBD::Oracle to compile

=item 2) Oracle files are needed for the compiled DBD to connect

=item 3) ORACLE_HOME environment variable must be set

=item 4) SHLIB_PATH environment variable must be set

=back

=head2 Compiling on a Client Machine

This may seem obvious to some, but the Oracle software has to be present
to compile and run DBD-Oracle.  The best way to compile and install on a
client machine, is to use the oracle installer to install the oracle
(client) software locally.  Install SQL*Net, Pro*C and SQL*Plus.  After
this some tests with SQL*Net (tnsping at a minimum) are an good idea.
Make sure you can connect to your remote database, and everything works
with Oracle before you start bashing your head into the wall trying to
get DBD-Oracle to work.

If you do not have the Oracle installer handy, the following hack has
been known to work:

Either open an NFS share from the oracle installation directory on the
machine that has Oracle and point both of the above-mentioned env vars to
that share, or alternatively copy the following four directories from your
Oracle installation over to the machine on which you are compiling the DBD:

drwxr-xr-x   3 oracle   dba         3072 Jul  3 09:36 lib
drwxr-xr-x  13 oracle   dba          512 Jul  3 09:38 network
drwxr-xr-x   7 oracle   dba          512 Jul  2 19:25 plsql
drwxr-xr-x  12 oracle   dba          512 Jul  3 09:38 rdbms

then point the above-mentioned env vars to the containing directory (good
place to put them, if copying locally, might be /usr/lib/oracle,
/usr/local/lib/oracle, or /opt/oracle/lib )

In any case, the compiler needs to be able to find files in the above
four directories from Oracle in order to get all the source code needed
to compile properly.

=head2 Required Runtime environment

Again, use the Oracle installer to install the Oracle Client on the
machine where your scripts will be running.  If the Oracle installer is
not available, the following hack should suffice:

For running the compiled DBD in Perl and connecting, you need only the
files in the 'lib' folder mentioned above, either connecting to them
through an NFS share on the Oracle machine, or having copied them
directly onto the local machine, say, in /usr/lib/oracle . Make sure the
env variable for ORACLE_HOME = /usr/lib/oracle and LD_LIBRARY_PATH
includes /usr/lib/oracle .  You can set the env var in your perl script
by typing

    $ENV{ORACLE_HOME} = '/usr/lib/oracle';

=head1 Apache and mod_perl

B<Nota Bene:> these instructions are now more than a year and a half old,
you may have to tinker.

If you are not building this version of Perl for Apache you can go on to
build what ever other modules you require.  The following instructions
describe how these modules were built with the Perl/DBD-Oracle built
above: The following is what worked for Roger Foskett:

=head1 Apache Web server

    cd apache_1.3.14/
    LDFLAGS_SHLIB_EXPORT="" \
    LDFLAGS="-lm -lpthread -lcl" \
    CC=/usr/bin/cc \
    CFLAGS="-D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
    ./configure \
        --prefix=/opt/www/apache \
        --enable-shared=max \
        --disable-rule=EXPAT \
        --enable-module=info \
        --enable-rule=SHARED_CORE

The Expat XML parser is disabled as it conflicts with the Perl XML-Parser
module causing core dumps.  -lcl is needed to ensure that Apache does not
coredump complaining about thread local storage

    make
    make install

Once installed, ensure that the generated httpd.conf is properly
configured, change the relevant lines to below (the default user/group
caused problems on HP (the user 'www' may need to be created)

        User www
        Group other
        port 80

=head2 mod_perl

    cd mod_perl-1.24_01/
    perl Makefile.PL \
        NO_HTTPD=1 \
        USE_APXS=1 \
        WITH_APXS=/opt/www/apache/bin/apxs \
        EVERYTHING=1
    make
    make install

=head2 htdig intranet search engine

    cd htdig-3.1.5/
    CC='cc' CPP='aCC' \
    ./configure \
        --prefix=/opt/www/htdig \
        --with-cgi-bin-dir=/opt/www/htdig/cgi-bin \
        --with-image-dir=/opt/www/htdig/images

=head1 CONTRIBUTORS

The following folks contributed to this README:

   Lincoln A. Baxter <lab@lincolnbaxter.com.Fix.This>
   H.Merijn Brand    <h.m.brand@xs4all.nl>
   Jay Strauss       <me@heyjay.com.Fix.This>
   Roger Foskett     <Roger.Foskett@icl.com.Fix.This>
   Weiguo Sun        <wesun@cisco.com.Fix.This>
   Tony Foiani       <anthony_foiani@non.hp.com.Fix.This>
   Hugh J. Hitchcock <hugh@hitchco.com.Fix.This>
	Heiko Herms  <Heiko.Herms.extern@HypoVereinsbank.de.Fix.This>
   Waldemar Zurowski <bilbek0@poczta.onet.pl.Fix.This>
   Michael Schuh     <Michael.Schuh@airborne.com.Fix.This>
   Gram M. Ludlow    <LUDLOW_GRAM_M@cat.com.Fix.This>

And probably others unknown to me.

=head1 AUTHOR

   Lincoln A. Baxter <lab@lincolnbaxter.com.Fix.This>
   H.Merijn Brand    <h.m.brand@xs4all.nl>

=head1 EXAMPLE FILES

Example files have been split off this document to README-files/hpux/

=head2 Lincoln's Makefile

Lincoln's Makefile can be found in README-files/hpux/Makefile-Lincoln

It contains the text of the makefile Lincoln uses to build Perl on all
platforms he runs on.

=head2 Perl Configuration Dumps

The following to sections provide full dumps of perl -V for three versions
of Perl that were successfully built and linked on HP-UX 11.00.

=head3 Lincoln Baxter's DBD-Oracle-1.07 Configuration

See F<README-files/hpux/Conf-Lincoln-1.07>

=head3 Lincoln Baxter's DBD-Oracle-1.06 Configuration

See F<README-files/hpux/Conf-Lincoln-1.06>

=head3 Roger Foskett's Configuration (works with Apache and mod_perl)

See F<README-files/hpux/Conf-Roger>

Roger also provides a link to some threads containing some of his
DBD-Oracle and HP-UX 11 trials...
L<http://www.geocrawler.com/search/?config=183&words=Roger+Foskett>

=head3 Mike Shuh's Configuration.

See also appendix C

See F<README-files/hpux/Conf-Mike>

=head3 H.Merijn Brand's Configurations

See
F<README-files/hpux/Conf-Merijn-580-10.20-cc>,
F<README-files/hpux/Conf-Merijn-588-10.20-gcc>,
F<README-files/hpux/Conf-Merijn-585-11.00-cc>,
F<README-files/hpux/Conf-Merijn-588-11.00-gcc32>,
F<README-files/hpux/Conf-Merijn-588-11.00-gcc64>,
F<README-files/hpux/Conf-Merijn-585-11.11-cc>,
F<README-files/hpux/Conf-Merijn-588-11.11-gcc32>,
F<README-files/hpux/Conf-Merijn-588-11.11-gcc64>,
F<README-files/hpux/Conf-Merijn-587-11.23-cc>, and
F<README-files/hpux/Conf-Merijn-588-11.23-gcc64>

=head3 RE problem with libjava.sl

A copy of the message Lincoln received from Jon Stevenson concerning a
problem with the libjava.sl can be found in L<README-files/hpux/libjava.eml>.
Note that the gcc build described in L<Appendix A> also describes a problem
with libjava.sl, which was solved by putting it in the extra libraries option
at configure time.  That is probably a preferable solution.

=head1 APPENDICES

=head2 Appendix A (gcc build info from Waldemar Zurowski)

This is pretty much verbatim the build information I received from
Waldemar Zurowski on building Perl and DBD-Oracle using gcc on HP.  Note
that this build was on a PA-RISC1.1 machine.  Differences for building on
PA-RISC2.0 would be welcome and incorporated into the next README.

=head3 Host

   HP-UX hostname B.11.11 U 9000/800 XXXXXXXXX unlimited-user license

=head3 Oracle

   Oracle 8.1.7

=head3 Parameters to build Perl

   ./Configure -des -Uinstallusrbinperl -Uusethreads -Uuseithreads
   -Duselargefiles -Dcc=gcc -Darchname=PA-RISC1.1 -Dprefix=/opt/perl-non-thread
   -Dlibs='-lcl -lpthread -L${ORACLE_HOME}/JRE/lib/PA_RISC/native_threads
   -ljava -lnsl -lnm -lndbm -ldld -lm -lc -lndir -lcrypt -lsec'

-L${ORACLE_HOME}/JRE/lib/PA_RISC/native_threads -ljava, was added
because DBD::Oracle wants to link with it (probably due to Oracle's own
build rules picked up by Makefile.PL)

Set environment variable LDOPTS to '+s' (see ld(1)). This holds extra
parameters to HP-UX's ld command, as I don't use GNU ld (does anybody?).
This allows you to build an executable, which when run would search for
dynamic linked libraries using SHLIB_PATH (for 32-bit executable) and
LD_LIBRARY_PATH (for 64-bit executable). Obviously LDOPTS is needed only
when building Perl _and_ DBI + DBD::Oracle.

Then, after building Perl + DBI + DBD::Oracle and moving it into
production environment it was enough to add to SHLIB_PATH
${ORACLE_HOME}/lib and ${ORACLE_HOME}/JRE/lib/PA_RISC/native_threads,
for example:

SHLIB_PATH=${ORACLE_HOME}/lib:${ORACLE_HOME}/JRE/lib/PA_RISC/native_threads:
$SHLIB_PATH

Please note output of ldd command:

   $ ldd -s ./perl
    [...]
     find library=/home/ora817/JRE/lib/PA_RISC/native_threads/libjava.sl;
   required by ./perl
       search path=/home/ora817/lib:/home/ora817/JRE/lib/PA_RISC/native_threads
   (SHLIB_PATH)
       trying path=/home/ora817/lib/libjava.sl
       trying path=/home/ora817/JRE/lib/PA_RISC/native_threads/libjava.sl
           /home/ora817/JRE/lib/PA_RISC/native_threads/libjava.sl =>
   /home/ora817/JRE/lib/PA_RISC/native_threads/libjava.sl
    [...]

All of this mess is necessary because of weakness of shl_load(3X),
explained in current README.hpux and in some discussion forums at HP.com
site. I have learned, that HP issued patch PHSS_24304 for HP-UX 11.11
and PHSS_24303 for HP-UX 11.00, which introduced variable LD_PRELOAD.
I haven't tried it yet, but it seems promising that it would allow you
to completely avoid building your own Perl binary, as it would be enough
to set LD_PRELOAD to libjava.sl (for example) and all
'Cannot load XXXlibrary' during building of DBD::Oracle should be gone.

The documentation says, that setting this variable should have the same
effect as linking binary with this library. Also please note, that this
variable is used only when binary is not setuid nor setgid binary (for
obvious security reasons).

It seems, that the best way to find out if you already have this patch
applied, is to check if 'man 5 dld.sl' says anything about LD_PRELOAD
environment variable.

Best regards,

Waldemar Zurowski

Authors Note:  Search for references to LD_PRELOAD else where in this
document.  Using LD_PRELOAD is probably a fragile solution at best.
Better to do what Waldemar actually did, which is to include libjava in
the extra link options.

=head2 Appendix B (64 bit build with /usr/bin/cc -- bundled C compiler)

Gram M. Ludlow writes:

I recently had a problem with Oracle 9 64-bit on HPUX 11i. We have
another application that required SH_LIBARY_PATH to point to the 64-bit
libraries, which "broke" the Oraperl module. So I did some research and
successfully recompiled and re-installed with the most recent versions of
everything (perl, DBI, DBD) that works with 64-bit shared libraries. This
is the error we were getting (basically)
"/usr/lib/dld.sl: Bad magic number for shared library:
/ora1/app/oracle/product/9.2.0.1.0/lib32"

Here is my step-by-step instructions, pretty much what you have but
streamlined for this particular case.

Required software:

   HPUX 11.11 (11i) PA-RISC
   perl 5.8.4 source
   DBI-1.42 source
   DBD-Oracle-1.16 source
   Oracle 9.2.0.1.0 installation

=over

=item Step 1: Compiling Perl

This compiles PERL using the default HPUX cc compiler. The important
things to note here are the configure parameters. the only non-default
option to take is to add "+z" to the additional cc flags step.

   gunzip perl-5.8.4.tar.gz
   tar -xf perl-5.8.4.tar
   cd perl-5.8.4
   ./Configure -Ubincompat5005 -Duselargefiles -A prepend:libswanted='cl pthread ' -Duse64bitall

Any additional cc flags?
Add +z to beginning of list, include all other options.

   make; make test

98% of tests should succeed. If less, something is wrong.

=item Step 2: DBI

   gunzip DBI-1.42.tar.gz
   tar -xvf DBI-1.42.tar
   cd DBI-1.42
   perl Makefile.PL
   make;make test
   make install

=item Step 3: Install DBD-Oracle

First, set the following environment variables specific you your Oracle
installation:

   export ORACLE_USERID=user/pass
   export ORACLE_HOME=/oracle/product/9.2.0.1.0
   export ORACLE_SID=orap1

Then unpack and build:

   gunzip DBD-Oracle-1.16.tar.gz
   tar -xvf DBD-Oracle-1.16.tar
   cd DBD-Oracle-1.16
   perl Makefile.PL -l
   make;make test
   make install

=back

Note from H.Merijn Brand: In more recent perl distributions using
HP C-ANSI-C should "just work" (TM), provided your C compiler can be
found and used, your database is up and running, and your enviroment
variables are set as noted. Example is for a 64bit build, as Oracle
ships Oracle 9 and up for HP-UX only in 64bit builds.

   gzip -d <perl-5.8.8.tgz | tar xf -
   cd perl-5.8.8
   sh ./Configure -Duse64bitall -A prepend:libswanted='cl pthread ' -des
   make
   make test_harness
   make install

   gzip -d <DBI-1.50.tgz | tar xf -
   perl Makefile.PL
   make
   make test
   make install

   gzip -d <DBD-Oracle-1.17.tgz | tar xf -
   perl Makefile.PL
   make
   make test
   make install

=head2 Appendix C (Miscellaneous links which might be useful)

Michael Schuh writes:

It was a bit by trial and error and a bit more by following your
suggestions (and mapping them to gcc) that I got something that worked.

One of the most significant "mappings" was to take your suggestion under
"Configure" to add "+Z" to the ccflags variable and to change that to
"-fPIC" (which, I learned from the gcc man page, is different than
"-fpic", which is the counterpart for +z). -fPIC (+Z) allows I<big>
offsets in the Position Independent Code, where -fpic (+z) only allows
small offsets.

I suspect that your hint about adding -lcl and -lpthread were crucial,
but (after doing so) I never encountered any problems that were related
to them.

One thing that I did was create a shell script to set some variables,
as the initial environment for root on the target system didn't work
very well.  Here is that script, trimmed to remove a bunch of echo
statements, etc.:

   # -------------------------------------------------------------------
   # root.env - sets some environment variables the way I want them...
   #
   # Mike Schuh, June 2002, July 2002

   export CC=/usr/local/bin/gcc

   export INSTALL=./install-sh

   . appl_setup DDD

   export ORACLE_SID="SSS"
   export ORACLE_USERID="XXX/YYY"

   export PATH=/usr/local/bin:/usr/sbin:/usr/bin:/usr/ccs/bin:/opt/perl5/bin:/usr/c
   ontrib/bin:/opt/nettladm/bin:/opt/fc/bin:/opt/fcms/bin:/opt/pd/bin:/usr/bin/X11:
   /usr/contrib/bin/X11:/opt/hparray/bin:/opt/resmon/bin:/usr/sbin/diag/contrib:/op
   t/pred/bin:/opt/gnome/bin:/sbin

   # end of root.env

The appl_setup sets some Oracle variables (specific to our installation),
which I then override for the database that I am working on.  The script
(which I source) also unse some variables specific to other applications
(e.g., Tivoli), mostly to unclutter my debugging.  The INSTALL variable
is related to building libgdbm.

The output of perl -V can be found in README-files/hpux/Conf-Mike

=head2 http://www.mail-archive.com/dbi-users@perl.org/msg18687.html

Garry Ferguson's notes on a successful build using perl 5.8.0, DBI-1.38
and DBD-Oracle-1.14 on HPUX 11.0 ( an L2000 machine ) with Oracle 9.0.1

=head2 http://www.sas.com/service/techsup/unotes/SN/001/001875.html

This is a not from from the SAS support people documenting the
LhtStrInsert() and LhtStrCreate() undefined symbols errors, and how to
fix them in the Oracle makefiles.

=head1 Appendix D (Why Dynamic Linking)

Some one posted to the DBI email list the following question:

   What are the advantages of building a dynamically linked version?
   Being able to use threads? Or something besides that?

The answer is there are too many to count, but here are several big ones:

=over

=item 1 Much smaller executables

Only the code referenced gets loaded... this
means faster execution times, and less machine resources (VM) used)

=item 2 Modular addition and updating of modules.

This is HUGE.  One does not relink B<EVERYTHING, EVERY time> one changes
or updates  a module.

=item 3 It eliminates Dynaloader warning (multiply defined).

This occurs with the static build when Perl is run with -w.  I fixed
this by removing -w from my #! lines, converting the the pragam "use
warnings;". However, it was annoying, since all my scripts had -w in the
#! line.

=item 4 It's the default build

Since almost every OS now supports dynamic linking, I believe that static
linking is NOT getting the same level of vetting it maybe used to.
Dynamicly linking is what you get by default, so its way better tested.

=item 5 It's required for Apache and mod_perl.

=back

=head1 Appendix E (WebLogic Driver for Oracle with the Oracle8i Server Lob Bug)

Michael Fox reported a bug when you are using DBD-Oracle-1.18 or later and when using older Oracle versions. 
The bug will result in an error report 

   'Failed to load Oracle extension and/or shared libraries'.

This problem occurs if you use the WebLogic Driver for Oracle with the Oracle8i Server 
- Enterprise Edition 8.1.7 and the corresponding Oracle Call Interface (OCI). 
This problem occurs only in Oracle 8.1.7; it is fixed in Oracle 9i.

This link details the problem

=head1 http://e-docs.bea.com/platform/suppconfigs/configs70/hptru64unix51_alpha/70sp1.html#88784

The solution from this page is below;

To work around this problem, complete the following procedure:

=item 1 Log in to your Oracle account: 

   su - oracle 

=item 2 In a text editor, open the following file:  

   $ORACLE_HOME/rdbms/admin/shrept.lst

=itme 3 Add the following line: 

   rdbms:OCILobLocatorAssign

=item 4 (optional) Add the names of any other missing functions needed by applications, other than WebLogic Server 7.0, that you want to execute. 
Note: The OCILobLocatorAssign function is not the only missing function that WebLogic Server 7.0 should be able to call, but it is the only missing function that WebLogic Server 7.0 requires. Other functions that WebLogic Server should be able to call, such as OCIEnvCreate and OCIerminate, are also missing. If these functions are required by other applications that you plan to run, you must add them to your environment by specifying them, too, in $ORACLE_HOME/rdbms/admin/shrept.lst.

=item 5 Rebuild the shared client library: 

   $ cd $ORACLE_HOME/rdbms/lib 
   $ make -f ins_rdbms.mk client_sharedlib 

The make command updates the following files in /opt/oracle/product/8.1.7/lib:

   clntsh.map 
   ldap.def libclntsh.so 
   libclntsh.so.8.0 libclntst8.a 
   network.def 
   plsql.def 
   precomp.def 
   rdbms.def 

Because OCILobLocatorAssign is now visible in libclntsh.so, WebLogic Server can call it.

=back

=head1 AUTHORS

=over 4

=item *

Tim Bunce <timb@cpan.org>

=item *

John Scoles

=item *

Yanick Champoux <yanick@cpan.org>

=item *

Martin J. Evans <mjevans@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 1994 by Tim Bunce.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

