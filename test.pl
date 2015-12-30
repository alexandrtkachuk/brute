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



sub getIp
{
	my ($code, $result) = $brute->ConnectTor('localhost', 9050, 'https://2ip.ru/');

	if ($result =~ /(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/ )
	{
		print "My ip:" , $1, "\n";
	}
	else
	{
		print $code, "\n";
	}
}


sub getIdent
{
	my ($code, $result) = $brute->ConnectTor('localhost', 9050, 'http://super-turbo-dubler.com');

	if ($result =~ /<input type="hidden" id="auth_ticket" value="(\w+)"/ )
	{
		print "Identi:" , $1, "\n";
	}
	else
	{
		print "Not found, code page:", $code, "\n";
	}
}

sub main
{
	getIp();
	getIdent();

}


=potok

my $tds = 9;

my $i : shared = 1;

my (@trl);

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


main();

print "\ntime worked : ",time() -  $timestart, "\n";	
