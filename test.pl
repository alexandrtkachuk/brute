#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: test.pl
#
#        USAGE: ./test.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 28.12.2015 19:32:28
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#use utf8;

use threads;
use threads::shared;

my ($timestart) = time();

use Brute;

#print 'test' , "\n";

my ($brute) = Brute->new();

$brute->FConnect();

my $tds = 9;

my $i : shared = 1;

my (@trl);

=potok
sub Potok
{
	my ($mytid) = threads->self->tid();

	while ($i<100)
	{
		{
			lock ($i);
			print " Поток - $mytid ,"; 
			print " число - $i \n";
			$i++;
		}

		sleep 1;
	}
}

for (1..$tds)
{
  push	@trl,  threads->create(\&Potok);
}


for(@trl)
 { 
	 $_->join; 
 }

=cut

print "\ntime work : ",time() -  $timestart, "\n";	
