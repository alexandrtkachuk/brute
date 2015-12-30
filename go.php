<?php

$start = microtime(true);

include ("Brute.php");
 
$brute = new  Brute();

#$brute->test();


class workerThread extends Thread {
    public function __construct($i){
	$this->i=$i;
    }

    public function run(){
	while(true){
	    echo $this->i;
	    sleep(1);
	}
    }
}



$time = microtime(true) - $start;
printf('Скрипт выполнялся %.4F сек.' . "\n", $time);
    
