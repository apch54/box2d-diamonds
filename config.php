<?php

//Name of product used by the socle
define('PRODUCT', 'diamonds-mines');

$gameOptions = array(
	'duration' => 60,
	'pointEarned' => 10,
    'pointLost' => 15,
	'pointToLevel1' => 200,
    'winningLevel' =>1,
    'timingTemps'=> false,
    'percentToNextLevel' => 1.5,
    'life' => 2,
    'pointBonus' => 5,

    //Here You can add new specific parameters
    'vx0' 					=> 60,			// initial basket velocity 
    'gravityY'				=> 1200,    	// system gravity
    'n_diamonds_for_bonus' 	=> 5			// number of diamonds in basket to score a bonus


);

//REGIEREPLACE