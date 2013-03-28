<?php
class MCADCircleObject extends MCAD2DObjectBase{
	protected $strCommand = 'circle';
	public function __construct($mixData){
		if(is_int($mixData)){
			$this->r = $mixData;
			$mixData = null;
		}
		parent::__construct($mixData);
	}
}