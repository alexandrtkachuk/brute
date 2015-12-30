#
#===============================================================================
#
#         FILE: Brute.pm
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 28.12.2015 20:42:41
#     REVISION: ---
#===============================================================================
package Brute;
use strict;
use warnings;
 
use WWW::Curl::Easy;


sub new
{
	my $proto=shift;

	my $class = ref($proto) || $proto;

	my $self = {};

	bless($self,$class);

	return $self;
}

sub FConnect
{
	my ($curl) = WWW::Curl::Easy->new;
	
	my @authHeader = (
		'User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36',
		'language: ru,en-US;q=0.8,en;q=0.6,uk;q=0.4'
		,'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8'
		,'Connection: keep-alive'
		,'Upgrade-Insecure-Requests: 1'
		#,'Accept-Encoding: gzip, deflate'
		#,'Referer: https://www.google.com.ua/'
		
	);

	$curl->setopt(CURLOPT_HEADER, 1);
	#$curl->setopt(CURLOPT_USERAGENT, "Mozilla/5.0");
	$curl->setopt(CURLOPT_HTTPHEADER, \@authHeader);
	$curl->setopt(CURLOPT_AUTOREFERER, 1);
	$curl->setopt(CURLOPT_FOLLOWLOCATION, 1);
	$curl->setopt(CURLOPT_FAILONERROR, 0);	
	$curl->setopt( CURLOPT_CONNECTTIMEOUT, 0);
	#$curl->setopt(CURLOPT_TIMEOUT, 120);
	################################
	$curl->setopt(CURLOPT_URL, 'http://super-turbo-dubler.com');
	my ($url) = 'super-turbo-dubler.com';
	#$curl->setopt(CURLOPT_URL,
	#	'https://translate.google.com/translate?sl=auto&tl=en&js=y&prev=_t&hl=en&ie=UTF-8&u=http%3A%2F%2F'
	#		. $url
	#		. '%2F&edit-text=&act=url');
	#$curl->setopt(CURLOPT_URL, 'https://2ip.com.ua/ru');
	$curl->setopt(CURLOPT_URL, 'https://2ip.ru/');
	$curl->setopt(CURLOPT_COOKIEJAR, "/tmp/test2.cooks");
	$curl->setopt(CURLOPT_COOKIEFILE, "/tmp/test2.cooks");
	$curl->setopt(CURLOPT_PROXY, 'https://109.163.220.61:8080/');
	

	#$curl->setopt(CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
	$curl->setopt(CURLOPT_PROXYTYPE, CURLPROXY_HTTP );

	my ($response_body);
	$curl->setopt(CURLOPT_WRITEDATA, \$response_body);

	my ($retcode) = $curl->perform;

	if ($retcode == 0) 
	{
		#print("Transfer went ok\n");
		my $response_code = $curl->getinfo(CURLINFO_HTTP_CODE);

		# judge result and next action based on $response_code

		#print("Received response: $response_body\n");

		#print $response_body;

		#if ($response_body =~ /<input type="hidden" id="auth_ticket" value="(\w+)"/ )
		if ($response_body =~ /(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/ )
		{
			print "--" , $1, "-- \n";
		}
		else
		{
			print "code:", $response_code, "\n";
		}

	} 
	else 
	{
		# Error code, type of error, error message
		print("An error happened: $retcode ".$curl->strerror($retcode)." ".$curl->errbuf."\n");
	}
}





1;
