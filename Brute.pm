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

	my $self = { 'cookie' => '/tmp/first.cooks' };

	bless($self,$class);

	return $self;
}

sub ConnectTor
{
	my ($self, $host, $port, $url) = @_;
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
	$curl->setopt(CURLOPT_HTTPHEADER, \@authHeader);
	$curl->setopt(CURLOPT_AUTOREFERER, 1);
	$curl->setopt(CURLOPT_FOLLOWLOCATION, 1);
	$curl->setopt(CURLOPT_FAILONERROR, 0);	
	$curl->setopt(CURLOPT_CONNECTTIMEOUT, 0);
	$curl->setopt(CURLOPT_TIMEOUT, 120);
	$curl->setopt(CURLOPT_URL, $url);


	$curl->setopt(CURLOPT_COOKIEJAR, $self->{'cookie'});
	$curl->setopt(CURLOPT_COOKIEFILE, $self->{'cookie'});
	$curl->setopt(CURLOPT_PROXY, $host . ':' . $port);
	
	$curl->setopt(CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
	
	my ($response_body);
	
	$curl->setopt(CURLOPT_WRITEDATA, \$response_body);

	my ($retcode) = $curl->perform;

	if ($retcode == 0) 
	{
		return ($curl->getinfo(CURLINFO_HTTP_CODE), $response_body); 
	} 
	else 
	{
		# Error code, type of error, error message
		print("An error happened: $retcode ".$curl->strerror($retcode)." ".$curl->errbuf."\n");
	}
}

sub SendParamsPost
{
	my ($self, $url, $params) = @_;
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
	$curl->setopt(CURLOPT_HTTPHEADER, \@authHeader);
	$curl->setopt(CURLOPT_AUTOREFERER, 1);
	$curl->setopt(CURLOPT_FOLLOWLOCATION, 0); #disable auto riderect 
	$curl->setopt(CURLOPT_FAILONERROR, 0);	
	$curl->setopt(CURLOPT_CONNECTTIMEOUT, 0);
	$curl->setopt(CURLOPT_TIMEOUT, 120);
	$curl->setopt(CURLOPT_URL, $url);	
	$curl->setopt(CURLOPT_COOKIEJAR, $self->{'cookie'});
	$curl->setopt(CURLOPT_COOKIEFILE, $self->{'cookie'});	
	$curl->setopt(CURLOPT_POSTFIELDS, $params);
	
	my ($response_body);
	
	$curl->setopt(CURLOPT_WRITEDATA, \$response_body);

	my ($retcode) = $curl->perform;

	if ($retcode == 0) 
	{
		return ($curl->getinfo(CURLINFO_HTTP_CODE), $response_body); 
	} 
	else 
	{	
		print("An error happened: $retcode ".$curl->strerror($retcode)." ".$curl->errbuf."\n");
	}

}

sub Connect
{
	my ($self, $url) = @_;
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
	$curl->setopt(CURLOPT_HTTPHEADER, \@authHeader);
	$curl->setopt(CURLOPT_AUTOREFERER, 1);
	$curl->setopt(CURLOPT_FOLLOWLOCATION, 1);
	$curl->setopt(CURLOPT_FAILONERROR, 0);	
	$curl->setopt( CURLOPT_CONNECTTIMEOUT, 0);
	$curl->setopt(CURLOPT_TIMEOUT, 120);
	$curl->setopt(CURLOPT_URL, $url);

	$curl->setopt(CURLOPT_COOKIEJAR, $self->{'cookie'});
	$curl->setopt(CURLOPT_COOKIEFILE, $self->{'cookie'});	
	
	my ($response_body);
	
	$curl->setopt(CURLOPT_WRITEDATA, \$response_body);

	my ($retcode) = $curl->perform;

	if ($retcode == 0) 
	{
		return ($curl->getinfo(CURLINFO_HTTP_CODE), $response_body); 
	} 
	else 
	{	
		print("An error happened: $retcode ".$curl->strerror($retcode)." ".$curl->errbuf."\n");
	}
}

###############################################################################################

sub bustCustumCharactersFast_4
{
	my ($self, $arr) = @_;

	for my $char0 (@$arr)
	{
		for my $char1(@$arr)
		{
			for my $char2 (@$arr)
			{
				for my $char3 (@$arr)
				{
					###
					print $char0, $char1, $char2, $char3, "\n";
				}

			}

		}

	}
}

sub bustCustumCharactersRecursion
{
	my ($self, $arr, $word, $count) = @_;
	
	$count--;
	
	for(@$arr)
	{
		if($count)
		{
			$self->bustCustumCharactersRecursion($arr, $word . $_, $count);
		}
		else
		{
			#############
			#run
			############
			#print $$word.$_, "\n";
		}
	}
}


1;
