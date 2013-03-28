<?php
class MCADRotate extends MCADManipulationBase{
	protected $strCommand = 'rotate';
	public function __construct($intX = 0, $intY = 0, $intZ = 0){
		$this->x = $intX;
		$this->y = $intY;
		$this->z = $intZ;
	}
	public function RenderProps(){
		return sprintf(
			'[%s, %s, %s]',
			$this->x,
			$this->y,
			$this->z		
		);
	}
}