<?php
abstract class MCADTangableBase extends MCADObjectBase{
	
	public function LinearExtrude($mixData){
		$objManipulation = new MCADLinearExtrude($mixData);
		$this->AddChild($objManipulation);
		return $this;
	}
	public function RotateExtrude($mixData){
		$objManipulation = new MCADRotateExtrude($mixData);
		$this->AddChild($objManipulation);
		return $this;
	}
	public function Rotate($intX = 0, $intY = 0, $intZ = 0){
		$objManipulation = new MCADRotate($intX , $intY, $intZ);
		$this->AddChild($objManipulation);
		return $this;
	}
	public function Scale($intX = 0, $intY = 0, $intZ = 0){
		$objManipulation = new MCADScale($intX , $intY, $intZ);
		$this->AddChild($objManipulation);
		return $this;
	}
	public function Translate($intX = 0, $intY = 0, $intZ = 0){
		$objManipulation = new MCADTranslate($intX , $intY, $intZ);
		$this->AddChild($objManipulation);
		return $this;
	}
	public function Hull($objObject){
		if(get_class($this) == 'MCADHull'){
			$this->AddChild($objObject);
			return $this;
		}else{
			$objGroup = new MCADHull();
			$objGroup->AddChild($this);
			$objGroup->AddChild($objObject);
			return $objGroup;
		}
	}
	public function Union($objObject){
		if(get_class($this) == 'MCADUnion'){
			$this->AddChild($objObject);
			return $this;
		}else{
			$objGroup = new MCADUnion();
			$objGroup->AddChild($this);
			$objGroup->AddChild($objObject);
			return $objGroup;
		}
	}
	public function Intersect($objObject){
		if(get_class($this) == 'MCADIntersection'){
			$this->AddChild($objObject);
			return $this;
		}else{
			$objGroup = new MCADIntersection();
			$objGroup->AddChild($this);
			$objGroup->AddChild($objObject);
			return $objGroup;
		}
	}
	public function Minkowski($objObject){
		if(get_class($this) == 'MCADMinkowski'){
			$this->AddChild($objObject);
			return $this;
		}else{
			$objGroup = new MCADMinkowski();
			$objGroup->AddChild($this);
			$objGroup->AddChild($objObject);
			return $objGroup;
		}
	}
	public function Difference($objObject){
		if(get_class($this) == 'MCADDifference'){
			$this->AddChild($objObject);
			return $this;
		}else{
			$objGroup = new MCADDifference();
			$objGroup->AddChild($this);
			$objGroup->AddChild($objObject);
			return $objGroup;
		}
	}
	
	public function Color($mixObject){
		if(is_object($mixObject)){
			if(get_class($this) == 'MCADColor'){
				$this->AddChild($objObject);
				return $this;
			}else{
				//Not much we can do here
				throw new Exception("This is not a valid object type for this parameter");
			}
			
		}else{
			if(!is_string($mixObject)){
				throw new Exception("This is not a valid object type for this parameter");
			}
			$objGroup = new MCADColor($mixObject);
			$objGroup->AddChild($this);
			return $objGroup;
		}
	}
}
