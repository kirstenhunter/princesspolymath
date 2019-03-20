#!/bin/perl

my $akamai = $ENV{'AKAMAI_CMD'};
my @filelist;
while (<>) {
	next if ($_ !~ /_site/);
	chomp($_);
	$_ =~ s#_site#https://www.princesspolymath.com#;
	push (@filelist, $_);
        if ($#filelist >= 50) {
		purge(@filelist);
		@filelist = ();
	}
}
purge(@filelist);

sub purge(@filelist) {
	print "Purging " . $#filelist . " files\n";
	my $files = join (' ', @filelist);
 	`$akamai purge invalidate $files`;
	return()
}
