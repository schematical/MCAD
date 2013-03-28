<?php
class MCADSquareObject extends MCAD2DObjectBase{
	protected $strCommand = 'square';
	public function __construct($mixData = null, $intWidth = null){
		if(is_int($mixData)){
			$this->h = $mixData;
			if(is_null($intWidth)){
				$this->w = $mixData;
			}else{
				$this->w = $intWidth;
			}
			$mixData = null;
		}
		parent::__construct($mixData);
	}
	public function RenderProps(){
		return sprintf(
			'[%s, %s]',
			$this->h,
			$this->w		
		);
	}

}