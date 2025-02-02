$dbd_oracle_mm_opts = {
                        'NAME' => 'DBD::Oracle',
                        'META_MERGE' => {
                                          'resources' => {
                                                           'repository' => {
                                                                             'web' => 'http://github.com/yanick/DBD-Oracle/tree',
                                                                             'url' => 'git://github.com/yanick/DBD-Oracle.git',
                                                                             'type' => 'git'
                                                                           },
                                                           'homepage' => 'http://search.cpan.org/dist/DBD-Oracle',
                                                           'bugtracker' => {
                                                                             'web' => 'http://rt.cpan.org/Public/Dist/Display.html?Name=DBD-Oracle',
                                                                             'mailto' => 'bug-dbd-oracle at rt.cpan.org'
                                                                           }
                                                         },
                                          'build_requires' => {
                                                                'ExtUtils::MakeMaker' => 0,
                                                                'Test::Simple' => '0.90',
                                                                'DBI' => '1.51'
                                                              },
                                          'configure_requires' => {
                                                                    'DBI' => '1.51'
                                                                  }
                                        },
                        'INC' => '-IC:/cygwin/home/gecko/build-20121219T123114-skkeyhqctt/DBD-Oracle/instantclient_11_2/sdk/include -IC:/cygwin/home/gecko/build-20121219T123114-skkeyhqctt/DBD-Oracle/instantclient_11_2/rdbms/demo -IC:\Perl\\lib\\auto\\DBI',
                        'LIBS' => [
                                    '-LC:/cygwin/home/gecko/build-20121219T123114-skkeyhqctt/DBD-Oracle/instantclient_11_2/sdk/LIB/MSVC OCI'
                                  ],
                        'AUTHOR' => 'Tim Bunce (dbi-users@perl.org)',
                        'DIR' => [],
                        'DEFINE' => ' -DUTF8_SUPPORT -DORA_OCI_VERSION=\\"11.2.0.1\\" -DORA_OCI_102 -DORA_OCI_112',
                        'dist' => {
                                    'DIST_DEFAULT' => 'clean distcheck disttest tardist',
                                    'COMPRESS' => 'gzip -v9',
                                    'PREOP' => '$(MAKE) -f Makefile.old distdir',
                                    'SUFFIX' => 'gz'
                                  },
                        'OBJECT' => '$(O_FILES)',
                        'clean' => {
                                     'FILES' => 'xstmp.c Oracle.xsi dll.base dll.exp sqlnet.log libOracle.def mk.pm DBD_ORA_OBJ.*'
                                   },
                        'ABSTRACT_FROM' => 'lib/DBD/Oracle.pm',
                        'VERSION_FROM' => 'lib/DBD/Oracle.pm',
                        'LICENSE' => 'perl',
                        'PREREQ_PM' => {
                                         'DBI' => '1.51'
                                       }
                      };
$dbd_oracle_mm_self = bless( {
                               'MM_Win32_VERSION' => '6.63_02',
                               'BSLOADLIBS' => '',
                               'ECHO_N' => '$(ABSPERLRUN)  -e "print qq{@ARGV}" --',
                               'BOOTDEP' => '',
                               'INSTALLSITESCRIPT' => 'C:\Perl\\site\\bin',
                               'CCDLFLAGS' => ' ',
                               'LDDLFLAGS' => '-dll -nologo -nodefaultlib -debug -opt:ref,icf  -libpath:"C:\Perl\\lib\\CORE"  -machine:x86',
                               'DESTINSTALLVENDORMAN3DIR' => '$(DESTDIR)$(INSTALLVENDORMAN3DIR)',
                               'LDLOADLIBS' => 'C:\\cygwin\\home\\gecko\\build-20121219T123114-skkeyhqctt\\DBD-Oracle\\instantclient_11_2\\sdk\\LIB\\MSVC\\OCI.lib C:\\PROGRA~1\\MICROS~1\\VC98\\LIB\\oldnames.lib C:\\PSDK\\Lib\\kernel32.lib C:\\PSDK\\Lib\\user32.lib C:\\PSDK\\Lib\\gdi32.lib C:\\PSDK\\Lib\\winspool.lib C:\\PSDK\\Lib\\comdlg32.lib C:\\PSDK\\Lib\\advapi32.lib C:\\PROGRA~1\\MICROS~1\\VC98\\LIB\\PSDK\\shell32.lib C:\\PSDK\\Lib\\ole32.lib C:\\PSDK\\Lib\\oleaut32.lib C:\\PSDK\\Lib\\netapi32.lib C:\\PROGRA~1\\MICROS~1\\VC98\\LIB\\PSDK\\uuid.lib C:\\PSDK\\Lib\\ws2_32.lib C:\\PSDK\\Lib\\mpr.lib C:\\PSDK\\Lib\\winmm.lib C:\\PSDK\\Lib\\version.lib C:\\PSDK\\Lib\\odbc32.lib C:\\PSDK\\Lib\\odbccp32.lib C:\\PSDK\\Lib\\comctl32.lib C:\\PROGRA~1\\MICROS~1\\VC98\\LIB\\msvcrt.lib',
                               'INST_HTMLDIR' => 'blib\\html',
                               'PREOP' => '$(NOECHO) $(NOOP)',
                               'MACROSTART' => '',
                               'DESTINSTALLVENDORHTMLDIR' => '$(DESTDIR)$(INSTALLVENDORHTMLDIR)',
                               'XS_VERSION' => '1.50',
                               'MAKEMAKER' => 'C:/tmp/perl-skkeyhqcttqbchmiiwvsljixfzebnkphnthverynironryhtwmtz/lib/ExtUtils/MakeMaker.pm',
                               'USEMAKEFILE' => '-f',
                               'RM_RF' => '$(ABSPERLRUN) -MExtUtils::Command -e rm_rf --',
                               'PMLIBDIRS' => [
                                                'lib'
                                              ],
                               'INST_LIBDIR' => '$(INST_LIB)\\DBD',
                               'SITEARCHEXP' => 'C:\Perl\\site\\lib',
                               'ABSTRACT' => 'Oracle database driver for the DBI module',
                               'INST_MAN1DIR' => 'blib\\man1',
                               'MAN3EXT' => '3',
                               'XS' => {
                                         'Oracle.xs' => 'Oracle.c'
                                       },
                               'MAKE' => 'nmake',
                               'FULL_AR' => '',
                               'TRUE' => '$(ABSPERLRUN)  -e "exit 0" --',
                               'FULLPERL' => 'C:\Perl\\bin\\perl.exe',
                               'DIR' => $dbd_oracle_mm_opts->{'DIR'},
                               'CONFIG' => [
                                             'ar',
                                             'cc',
                                             'cccdlflags',
                                             'ccdlflags',
                                             'dlext',
                                             'dlsrc',
                                             'exe_ext',
                                             'full_ar',
                                             'ld',
                                             'lddlflags',
                                             'ldflags',
                                             'libc',
                                             'lib_ext',
                                             'obj_ext',
                                             'osname',
                                             'osvers',
                                             'ranlib',
                                             'sitelibexp',
                                             'sitearchexp',
                                             'so',
                                             'vendorarchexp',
                                             'vendorlibexp'
                                           ],
                               'DESTDIR' => '',
                               'INSTALLSITEHTMLDIR' => 'C:\Perl\\html',
                               'INSTALLSITEBIN' => 'C:\Perl\\site\\bin',
                               'CHMOD' => '$(ABSPERLRUN) -MExtUtils::Command -e chmod --',
                               'DESTINSTALLVENDORLIB' => '$(DESTDIR)$(INSTALLVENDORLIB)',
                               'OBJ_EXT' => '.obj',
                               'C' => [
                                        'Oracle.c',
                                        'dbdimp.c',
                                        'oci8.c'
                                      ],
                               'TARFLAGS' => 'cvf',
                               'PERL_INC' => 'C:\Perl\\lib\\CORE',
                               'HAS_LINK_CODE' => 1,
                               'INSTALLPRIVLIB' => 'C:\Perl\\lib',
                               'SITELIBEXP' => 'C:\Perl\\site\\lib',
                               'DESTINSTALLPRIVLIB' => '$(DESTDIR)$(INSTALLPRIVLIB)',
                               'VENDORLIBEXP' => '',
                               'DEFINE' => ' -DUTF8_SUPPORT -DORA_OCI_VERSION=\\"11.2.0.1\\" -DORA_OCI_102 -DORA_OCI_112',
                               'FULLEXT' => 'DBD\\Oracle',
                               'MAKEFILE' => 'Makefile',
                               'PL_FILES' => {},
                               'VENDORARCHEXP' => '',
                               'MM_VERSION' => '6.6302',
                               'INSTALLSCRIPT' => 'C:\Perl\\bin',
                               'CC' => 'cl',
                               'LIBS' => $dbd_oracle_mm_opts->{'LIBS'},
                               'DLEXT' => 'dll',
                               'EQUALIZE_TIMESTAMP' => '$(ABSPERLRUN) -MExtUtils::Command -e eqtime --',
                               'XS_VERSION_MACRO' => 'XS_VERSION',
                               'VERBINST' => 0,
                               'TAR' => 'tar',
                               'ABSPERL' => '$(PERL)',
                               'FALSE' => '$(ABSPERLRUN)  -e "exit 1" --',
                               'DESTINSTALLARCHLIB' => '$(DESTDIR)$(INSTALLARCHLIB)',
                               'INST_STATIC' => '$(INST_ARCHAUTODIR)\\$(BASEEXT)$(LIB_EXT)',
                               'DISTVNAME' => 'DBD-Oracle-1.50',
                               'ABSTRACT_FROM' => 'lib/DBD/Oracle.pm',
                               'DESTINSTALLSCRIPT' => '$(DESTDIR)$(INSTALLSCRIPT)',
                               'INST_AUTODIR' => '$(INST_LIB)\\auto\\$(FULLEXT)',
                               'RESULT' => [
                                             '# This Makefile is for the DBD::Oracle extension to perl.
#
# It was generated automatically by MakeMaker version
# 6.6302 (Revision: 66302) from the contents of
# Makefile.PL. Don\'t edit this file, edit Makefile.PL instead.
#
#       ANY CHANGES MADE HERE WILL BE LOST!
#
#   MakeMaker ARGV: (q[INSTALLDIRS=perl])
#
',
                                             '#   MakeMaker Parameters:
',
                                             '#     ABSTRACT_FROM => q[lib/DBD/Oracle.pm]',
                                             '#     AUTHOR => [q[Tim Bunce (dbi-users@perl.org)]]',
                                             '#     BUILD_REQUIRES => {  }',
                                             '#     CONFIGURE_REQUIRES => {  }',
                                             '#     DEFINE => q[ -DUTF8_SUPPORT -DORA_OCI_VERSION=\\"11.2.0.1\\" -DORA_OCI_102 -DORA_OCI_112]',
                                             '#     DIR => []',
                                             '#     INC => q[-IC:/cygwin/home/gecko/build-20121219T123114-skkeyhqctt/DBD-Oracle/instantclient_11_2/sdk/include -IC:/cygwin/home/gecko/build-20121219T123114-skkeyhqctt/DBD-Oracle/instantclient_11_2/rdbms/demo -IC:\Perl\\lib\\auto\\DBI]',
                                             '#     LIBS => [q[-LC:/cygwin/home/gecko/build-20121219T123114-skkeyhqctt/DBD-Oracle/instantclient_11_2/sdk/LIB/MSVC OCI]]',
                                             '#     LICENSE => q[perl]',
                                             '#     META_MERGE => { resources=>{ repository=>{ web=>q[http://github.com/yanick/DBD-Oracle/tree], url=>q[git://github.com/yanick/DBD-Oracle.git], type=>q[git] }, homepage=>q[http://search.cpan.org/dist/DBD-Oracle], bugtracker=>{ web=>q[http://rt.cpan.org/Public/Dist/Display.html?Name=DBD-Oracle], mailto=>q[bug-dbd-oracle at rt.cpan.org] } }, build_requires=>{ ExtUtils::MakeMaker=>q[0], Test::Simple=>q[0.90], DBI=>q[1.51] }, configure_requires=>{ DBI=>q[1.51] } }',
                                             '#     NAME => q[DBD::Oracle]',
                                             '#     OBJECT => q[$(O_FILES)]',
                                             '#     PREREQ_PM => { DBI=>q[1.51] }',
                                             '#     VERSION_FROM => q[lib/DBD/Oracle.pm]',
                                             '#     clean => { FILES=>q[xstmp.c Oracle.xsi dll.base dll.exp sqlnet.log libOracle.def mk.pm DBD_ORA_OBJ.*] }',
                                             '#     dist => { DIST_DEFAULT=>q[clean distcheck disttest tardist], COMPRESS=>q[gzip -v9], PREOP=>q[$(MAKE) -f Makefile.old distdir], SUFFIX=>q[gz] }',
                                             '
# --- MakeMaker post_initialize section:'
                                           ],
                               'FULLPERLRUNINST' => '$(FULLPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"',
                               'MAP_TARGET' => 'perl',
                               'INSTALLMAN3DIR' => 'C:\Perl\\man\\man3',
                               'PERLPREFIX' => 'C:\Perl',
                               'AUTHOR' => [
                                             'Tim Bunce (dbi-users@perl.org)'
                                           ],
                               'INC' => '-IC:/cygwin/home/gecko/build-20121219T123114-skkeyhqctt/DBD-Oracle/instantclient_11_2/sdk/include -IC:/cygwin/home/gecko/build-20121219T123114-skkeyhqctt/DBD-Oracle/instantclient_11_2/rdbms/demo -IC:\Perl\\lib\\auto\\DBI',
                               'LDFLAGS' => '-nologo -nodefaultlib -debug -opt:ref,icf  -libpath:"C:\Perl\\lib\\CORE"  -machine:x86',
                               'INSTALLVENDORHTMLDIR' => 'C:\Perl\\html',
                               'dist' => $dbd_oracle_mm_opts->{'dist'},
                               'INSTALLVENDORMAN1DIR' => '',
                               'MAKEFILE_OLD' => 'Makefile.old',
                               'H' => [
                                        'Oracle.h',
                                        'dbdimp.h',
                                        'dbivport.h',
                                        'ocitrace.h'
                                      ],
                               'PERLRUNINST' => '$(PERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"',
                               'CI' => 'ci -u',
                               'DESTINSTALLBIN' => '$(DESTDIR)$(INSTALLBIN)',
                               'DESTINSTALLVENDORMAN1DIR' => '$(DESTDIR)$(INSTALLVENDORMAN1DIR)',
                               'INST_ARCHLIBDIR' => '$(INST_ARCHLIB)\\DBD',
                               'OBJECT' => '$(O_FILES)',
                               'BUILD_REQUIRES' => {},
                               'NAME_SYM' => 'DBD_Oracle',
                               'RANLIB' => 'rem',
                               'DIRFILESEP' => '^\\',
                               'POSTOP' => '$(NOECHO) $(NOOP)',
                               'INSTALLVENDORBIN' => '',
                               'COMPRESS' => 'gzip --best',
                               'SUFFIX' => '.gz',
                               'MAN1EXT' => '1',
                               'PERL_LIB' => 'C:\Perl\\lib',
                               'ECHO' => '$(ABSPERLRUN) -l -e "print qq{@ARGV}" --',
                               'EXPORT_LIST' => '$(BASEEXT).def',
                               'INST_BOOT' => '$(INST_ARCHAUTODIR)\\$(BASEEXT).bs',
                               'MV' => '$(ABSPERLRUN) -MExtUtils::Command -e mv --',
                               'OSVERS' => '5.2',
                               'LD_RUN_PATH' => '',
                               'MKPATH' => '$(ABSPERLRUN) -MExtUtils::Command -e mkpath --',
                               'DESTINSTALLMAN1DIR' => '$(DESTDIR)$(INSTALLMAN1DIR)',
                               'OSNAME' => 'MSWin32',
                               'AR' => 'lib',
                               'O_FILES' => [
                                              'Oracle.obj',
                                              'dbdimp.obj',
                                              'oci8.obj'
                                            ],
                               'FIXIN' => 'pl2bat.bat',
                               'DIST_DEFAULT' => 'tardist',
                               'SKIPHASH' => {},
                               'NOOP' => 'rem',
                               'PERL_ARCHLIB' => 'C:\Perl\\lib',
                               'VERSION_SYM' => '1_50',
                               'VERSION_MACRO' => 'VERSION',
                               'WARN_IF_OLD_PACKLIST' => '$(ABSPERLRUN) -MExtUtils::Command::MM -e warn_if_old_packlist --',
                               'MM_REVISION' => 66302,
                               'RM_F' => '$(ABSPERLRUN) -MExtUtils::Command -e rm_f --',
                               'LIBC' => 'msvcrt.lib',
                               'UNINST' => 0,
                               'PERLRUN' => '$(PERL)',
                               'LINKTYPE' => 'dynamic',
                               'INSTALLVENDORLIB' => '',
                               'DEV_NULL' => '> NUL',
                               'DLSRC' => 'dl_win32.xs',
                               'INST_ARCHAUTODIR' => '$(INST_ARCHLIB)\\auto\\$(FULLEXT)',
                               'DESTINSTALLSITEBIN' => '$(DESTDIR)$(INSTALLSITEBIN)',
                               'MACROEND' => '',
                               'ARGS' => {
                                           'NAME' => 'DBD::Oracle',
                                           'META_MERGE' => $dbd_oracle_mm_opts->{'META_MERGE'},
                                           'INC' => '-IC:/cygwin/home/gecko/build-20121219T123114-skkeyhqctt/DBD-Oracle/instantclient_11_2/sdk/include -IC:/cygwin/home/gecko/build-20121219T123114-skkeyhqctt/DBD-Oracle/instantclient_11_2/rdbms/demo -IC:\Perl\\lib\\auto\\DBI',
                                           'LIBS' => $dbd_oracle_mm_opts->{'LIBS'},
                                           'AUTHOR' => $dbd_oracle_mm_self->{'AUTHOR'},
                                           'DIR' => $dbd_oracle_mm_opts->{'DIR'},
                                           'DEFINE' => ' -DUTF8_SUPPORT -DORA_OCI_VERSION=\\"11.2.0.1\\" -DORA_OCI_102 -DORA_OCI_112',
                                           'dist' => $dbd_oracle_mm_opts->{'dist'},
                                           'OBJECT' => '$(O_FILES)',
                                           'clean' => $dbd_oracle_mm_opts->{'clean'},
                                           'INSTALLDIRS' => 'perl',
                                           'ABSTRACT_FROM' => 'lib/DBD/Oracle.pm',
                                           'VERSION_FROM' => 'lib/DBD/Oracle.pm',
                                           'LICENSE' => 'perl',
                                           'PREREQ_PM' => $dbd_oracle_mm_opts->{'PREREQ_PM'}
                                         },
                               'CP' => '$(ABSPERLRUN) -MExtUtils::Command -e cp --',
                               'DEFINE_VERSION' => '-D$(VERSION_MACRO)=\\"$(VERSION)\\"',
                               'PREREQ_PM' => $dbd_oracle_mm_opts->{'PREREQ_PM'},
                               'DESTINSTALLSITELIB' => '$(DESTDIR)$(INSTALLSITELIB)',
                               'INST_LIB' => 'blib\\lib',
                               'INST_DYNAMIC' => '$(INST_ARCHAUTODIR)\\$(DLBASE).$(DLEXT)',
                               'FULLPERLRUN' => '$(FULLPERL)',
                               'META_MERGE' => $dbd_oracle_mm_opts->{'META_MERGE'},
                               'INSTALLSITEMAN1DIR' => '$(INSTALLMAN1DIR)',
                               'DESTINSTALLSITEMAN3DIR' => '$(DESTDIR)$(INSTALLSITEMAN3DIR)',
                               'MOD_INSTALL' => '$(ABSPERLRUN) -MExtUtils::Install -e "install([ from_to => {@ARGV}, verbose => \'$(VERBINST)\', uninstall_shadows => \'$(UNINST)\', dir_mode => \'$(PERM_DIR)\' ]);" --',
                               'DLBASE' => '$(BASEEXT)',
                               'INST_MAN3DIR' => 'blib\\man3',
                               'CCCDLFLAGS' => ' ',
                               'INSTALLSITEARCH' => 'C:\Perl\\site\\lib',
                               'PMLIBPARENTDIRS' => [
                                                      'lib'
                                                    ],
                               'DESTINSTALLSITESCRIPT' => '$(DESTDIR)$(INSTALLSITESCRIPT)',
                               'XS_DEFINE_VERSION' => '-D$(XS_VERSION_MACRO)=\\"$(XS_VERSION)\\"',
                               'SHAR' => 'shar',
                               'PERLMAINCC' => '$(CC)',
                               'RCS_LABEL' => 'rcs -Nv$(VERSION_SYM): -q',
                               'NAME' => 'DBD::Oracle',
                               'PARENT_NAME' => 'DBD',
                               'INSTALLSITELIB' => 'C:\Perl\\site\\lib',
                               'MAKE_APERL_FILE' => 'Makefile.aperl',
                               'ZIP' => 'zip',
                               'VERSION_FROM' => 'lib/DBD/Oracle.pm',
                               'LICENSE' => 'perl',
                               'SITEPREFIX' => 'C:\Perl\\site',
                               'INSTALLVENDORSCRIPT' => '',
                               'TO_UNIX' => '$(NOECHO) $(NOOP)',
                               'PERL' => 'C:\Perl\\bin\\perl.exe',
                               'DESTINSTALLVENDORARCH' => '$(DESTDIR)$(INSTALLVENDORARCH)',
                               'NOECHO' => '@',
                               'DESTINSTALLVENDORBIN' => '$(DESTDIR)$(INSTALLVENDORBIN)',
                               'DESTINSTALLHTMLDIR' => '$(DESTDIR)$(INSTALLHTMLDIR)',
                               'PERM_RW' => 644,
                               'UMASK_NULL' => 'umask 0',
                               'DOC_INSTALL' => '$(ABSPERLRUN) -MExtUtils::Command::MM -e perllocal_install --',
                               'TOUCH' => '$(ABSPERLRUN) -MExtUtils::Command -e touch --',
                               'LD' => 'link',
                               'PERL_SRC' => undef,
                               'DESTINSTALLMAN3DIR' => '$(DESTDIR)$(INSTALLMAN3DIR)',
                               'ZIPFLAGS' => '-r',
                               'PERM_DIR' => 755,
                               'DISTNAME' => 'DBD-Oracle',
                               'INST_BIN' => 'blib\\bin',
                               'FIRST_MAKEFILE' => 'Makefile',
                               'VENDORPREFIX' => '',
                               'LDFROM' => '$(OBJECT)',
                               'clean' => $dbd_oracle_mm_opts->{'clean'},
                               'PREFIX' => '$(PERLPREFIX)',
                               'INSTALLDIRS' => 'perl',
                               'INST_ARCHLIB' => 'blib\\arch',
                               'INSTALLHTMLDIR' => 'C:\Perl\\html',
                               'PERL_ARCHIVE' => '$(PERL_INC)\\perl516.lib',
                               'INSTALLVENDORARCH' => '',
                               'DESTINSTALLSITEMAN1DIR' => '$(DESTDIR)$(INSTALLSITEMAN1DIR)',
                               'INSTALLBIN' => 'C:\Perl\\bin',
                               'INSTALLSITEMAN3DIR' => '$(INSTALLMAN3DIR)',
                               'PERL_ARCHIVE_AFTER' => '',
                               'MAN3PODS' => {
                                               'lib/DBD/Oracle/Troubleshooting.pod' => '$(INST_MAN3DIR)\\DBD.Oracle.Troubleshooting.$(MAN3EXT)',
                                               'lib/DBD/Oracle/Troubleshooting/Cygwin.pod' => '$(INST_MAN3DIR)\\DBD.Oracle.Troubleshooting.Cygwin.$(MAN3EXT)',
                                               'lib/DBD/Oracle.pm' => '$(INST_MAN3DIR)\\DBD.Oracle.$(MAN3EXT)',
                                               'lib/DBD/Oracle/Troubleshooting/Hpux.pm' => '$(INST_MAN3DIR)\\DBD.Oracle.Troubleshooting.Hpux.$(MAN3EXT)',
                                               'Oraperl.pm' => '$(INST_MAN3DIR)\\DBD\\Oraperl.$(MAN3EXT)',
                                               'lib/DBD/Oracle/Troubleshooting/Sun.pod' => '$(INST_MAN3DIR)\\DBD.Oracle.Troubleshooting.Sun.$(MAN3EXT)',
                                               'lib/DBD/Oracle/Troubleshooting/Vms.pod' => '$(INST_MAN3DIR)\\DBD.Oracle.Troubleshooting.Vms.$(MAN3EXT)',
                                               'lib/DBD/Oracle/Troubleshooting/Macos.pod' => '$(INST_MAN3DIR)\\DBD.Oracle.Troubleshooting.Macos.$(MAN3EXT)',
                                               'lib/DBD/Oracle/Object.pm' => '$(INST_MAN3DIR)\\DBD.Oracle.Object.$(MAN3EXT)',
                                               'lib/DBD/Oracle/Troubleshooting/Aix.pod' => '$(INST_MAN3DIR)\\DBD.Oracle.Troubleshooting.Aix.$(MAN3EXT)',
                                               'lib/DBD/Oracle/Troubleshooting/Linux.pod' => '$(INST_MAN3DIR)\\DBD.Oracle.Troubleshooting.Linux.$(MAN3EXT)',
                                               'lib/DBD/Oracle/Troubleshooting/Win64.pod' => '$(INST_MAN3DIR)\\DBD.Oracle.Troubleshooting.Win64.$(MAN3EXT)',
                                               'lib/DBD/Oracle/Troubleshooting/Win32.pod' => '$(INST_MAN3DIR)\\DBD.Oracle.Troubleshooting.Win32.$(MAN3EXT)',
                                               'lib/DBD/Oracle/GetInfo.pm' => '$(INST_MAN3DIR)\\DBD.Oracle.GetInfo.$(MAN3EXT)'
                                             },
                               'LIBPERL_A' => 'libperl.lib',
                               'INSTALLARCHLIB' => 'C:\Perl\\lib',
                               'LIB_EXT' => '.lib',
                               'DESTINSTALLSITEHTMLDIR' => '$(DESTDIR)$(INSTALLSITEHTMLDIR)',
                               'AR_STATIC_ARGS' => 'cr',
                               'INSTALLVENDORMAN3DIR' => '',
                               'EXE_EXT' => '.exe',
                               'EXTRALIBS' => 'C:\\cygwin\\home\\gecko\\build-20121219T123114-skkeyhqctt\\DBD-Oracle\\instantclient_11_2\\sdk\\LIB\\MSVC\\OCI.lib C:\\PROGRA~1\\MICROS~1\\VC98\\LIB\\oldnames.lib C:\\PSDK\\Lib\\kernel32.lib C:\\PSDK\\Lib\\user32.lib C:\\PSDK\\Lib\\gdi32.lib C:\\PSDK\\Lib\\winspool.lib C:\\PSDK\\Lib\\comdlg32.lib C:\\PSDK\\Lib\\advapi32.lib C:\\PROGRA~1\\MICROS~1\\VC98\\LIB\\PSDK\\shell32.lib C:\\PSDK\\Lib\\ole32.lib C:\\PSDK\\Lib\\oleaut32.lib C:\\PSDK\\Lib\\netapi32.lib C:\\PROGRA~1\\MICROS~1\\VC98\\LIB\\PSDK\\uuid.lib C:\\PSDK\\Lib\\ws2_32.lib C:\\PSDK\\Lib\\mpr.lib C:\\PSDK\\Lib\\winmm.lib C:\\PSDK\\Lib\\version.lib C:\\PSDK\\Lib\\odbc32.lib C:\\PSDK\\Lib\\odbccp32.lib C:\\PSDK\\Lib\\comctl32.lib C:\\PROGRA~1\\MICROS~1\\VC98\\LIB\\msvcrt.lib',
                               'PERM_RWX' => 755,
                               'DESTINSTALLSITEARCH' => '$(DESTDIR)$(INSTALLSITEARCH)',
                               'ABSPERLRUN' => '$(ABSPERL)',
                               'CONFIGURE_REQUIRES' => {},
                               'DESTINSTALLVENDORSCRIPT' => '$(DESTDIR)$(INSTALLVENDORSCRIPT)',
                               'BASEEXT' => 'Oracle',
                               'TEST_F' => '$(ABSPERLRUN) -MExtUtils::Command -e test_f --',
                               'PM' => {
                                         'lib/DBD/Oracle/Troubleshooting/Cygwin.pod' => 'blib\\lib\\DBD\\Oracle\\Troubleshooting\\Cygwin.pod',
                                         'lib/DBD/Oracle.pm' => 'blib\\lib\\DBD\\Oracle.pm',
                                         'oraperl.ph' => '$(INST_LIB)/oraperl.ph',
                                         'lib/DBD/Oracle/Troubleshooting/Vms.pod' => 'blib\\lib\\DBD\\Oracle\\Troubleshooting\\Vms.pod',
                                         'lib/DBD/Oracle/Troubleshooting/Linux.pod' => 'blib\\lib\\DBD\\Oracle\\Troubleshooting\\Linux.pod',
                                         'lib/DBD/Oracle/GetInfo.pm' => 'blib\\lib\\DBD\\Oracle\\GetInfo.pm',
                                         'lib/DBD/Oracle/Troubleshooting.pod' => 'blib\\lib\\DBD\\Oracle\\Troubleshooting.pod',
                                         'lib/DBD/Oracle/Troubleshooting/Hpux.pm' => 'blib\\lib\\DBD\\Oracle\\Troubleshooting\\Hpux.pm',
                                         'Oraperl.pm' => '$(INST_LIB)/Oraperl.pm',
                                         'lib/DBD/Oracle/Troubleshooting/Sun.pod' => 'blib\\lib\\DBD\\Oracle\\Troubleshooting\\Sun.pod',
                                         'lib/DBD/Oracle/Troubleshooting/Macos.pod' => 'blib\\lib\\DBD\\Oracle\\Troubleshooting\\Macos.pod',
                                         'lib/DBD/Oracle/Troubleshooting/Aix.pod' => 'blib\\lib\\DBD\\Oracle\\Troubleshooting\\Aix.pod',
                                         'lib/DBD/Oracle/Object.pm' => 'blib\\lib\\DBD\\Oracle\\Object.pm',
                                         'lib/DBD/Oracle/Troubleshooting/Win64.pod' => 'blib\\lib\\DBD\\Oracle\\Troubleshooting\\Win64.pod',
                                         'mk.pm' => '$(INST_LIB)\\DBD\\mk.pm',
                                         'lib/DBD/Oracle/Troubleshooting/Win32.pod' => 'blib\\lib\\DBD\\Oracle\\Troubleshooting\\Win32.pod'
                                       },
                               'ABSPERLRUNINST' => '$(ABSPERLRUN) "-I$(INST_ARCHLIB)" "-I$(INST_LIB)"',
                               'PERL_CORE' => 0,
                               'INSTALLMAN1DIR' => 'C:\Perl\\man\\man1',
                               'SO' => 'dll',
                               'VERSION' => '1.50',
                               'DIST_CP' => 'best',
                               'INST_SCRIPT' => 'blib\\script',
                               'UNINSTALL' => '$(ABSPERLRUN) -MExtUtils::Command::MM -e uninstall --'
                             }, 'PACK001' );
