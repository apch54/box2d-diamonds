<?php

//Name of product used by the socle
define('PRODUCT', 'diamonds-mines');

$gameOptions = array(
	'duration' => 80,
	'pointEarned' => 3,
    'pointLost' => 1,
	'pointToLevel1' => 250,
    'winningLevel' =>1,
    'timingTemps'=> false,
    'percentToNextLevel' => 1.5,
    'life' => 3,
    'pointBonus' => 8,

    //Here You can add new specific parameters
    'vx0' 					=> 60,			// initial basket velocity 
    'gravityY'				=> 1500,    	// system gravity
    'n_diamonds_for_bonus' 	=> 7			// number of diamonds in basket to score a bonuss


);

//REGIEREPLACE
