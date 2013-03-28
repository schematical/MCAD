<?php
class MCADRotateExtrude extends MCADManipulationBase{
	protected $strCommand = 'rotate_extrude';
	public function __construct($mixData){
		if(is_int($mixData)){
			$this->convexity = $mixData;
			$mixData = null;
		}
		parent::__construct($mixData);
	}
}