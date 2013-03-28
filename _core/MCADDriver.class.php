<?php
abstract class MCADDriver{
	public static function Render($mixObjects){
		if(!is_array($mixObjects)){
			if(!is_null($mixObjects->Parent)){
				return self::Render($mixObjects->Parent);
			}
			$arrObjects = array($mixObjects);
		}else{
			$arrObjects = $mixObjects;
		}
		$strRendered = '';
		foreach($arrObjects as $intIndex => $objObject){
			$strRendered .= $objObject->Render();	
		}
		return $strRendered;
	}
}