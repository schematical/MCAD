<?php
class MCADLinearExtrude extends MCADManipulationBase{
	protected $strCommand = 'linear_extrude';
	public function __construct($mixData){
		if(is_int($mixData)){
			$this->height = $mixData;
			$mixData = null;
		}
		parent::__construct($mixData);
	}

}