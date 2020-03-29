#!/usr/bin/env perl

use v5.10;

use strict;
use warnings;

use File::Find;
use File::Remove qw(remove);
use File::Slurp qw(edit_file_lines);
use Term::ReadKey;

my $dir = 'songs';

die "Could not find songs directory." unless -d $dir;

find({wanted => \&wanted, no_chdir => 0}, $dir);

sub wanted
{
	if ( $_ eq 'song.ini' )
	{
		say $File::Find::dir;

		edit_file_lines
		{
            s/^(icon =) ccc/$1/;
			s/^(banner_link_a =) http:\/\/customscreators.com\//$1/;
			s/^(link_name_a =) Custom Creators Collective Blog$/$1/;
			s/^(banner_link_b =) http:\/\/db.customscreators.com\//$1/;
			s/^(link_name_b =) Custom Creators Collective Song Database/$1/;
			s/^(loading_phrase =) Brought to you by Customs Creators Collective/$1/;
			s/^.*$// if (/^; Converted using C3/ .. /www.customscreators.com/);
		} $_;
	}

	if ( $_ eq 'ccc.png' )
	{
		remove( 'ccc.png', 'banner.png' );
	}
}

say "Press any key to continue...";
ReadMode('cbreak');
ReadKey(0);
ReadMode('normal');
