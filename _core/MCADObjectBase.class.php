<?php
abstract class MCADObjectBase{
	protected $objParent = null;
	protected $arrChildren = array();
	
	protected $strCommand = null;
	protected $arrProps = array();
	
	protected $blnDissabled = false;
	protected $blnRoot = false;
	protected $blnBackground = false;
	protected $blnDebug = false;
	
	protected $blnRenderChildrenInBrackets = false;
	
	public function __construct($arrProps = null){
		if(is_array($arrProps)){
			$this->arrProps = $arrProps;
		}
		
	}
	public function AddChild($objChild){
		$objChild->SetParent($this);
		$this->arrChildren[] = $objChild;
	}
	public function SetParent($objParent){
		if(!is_null($this->objParent)){
			throw new Exception("This already has a parent");
		}
		$this->objParent = $objParent;
	}
	
	public function Render(){
		$strRendered = '';
		
		//Pre render chained shit
		
			
		foreach($this->arrChildren as $intIndex => $objChild){
			if($objChild instanceof MCADManipulationBase){
				$strRendered .= $objChild->Render();
			}	
		}
	
		
		
		
		if($this->blnDissabled){
			$strRendered .= '* ';
		}
		if($this->blnRoot){
			$strRendered .= '? ';
		}
		if($this->blnDissabled){
			$strRendered .= '% ';
		}
		if($this->blnDissabled){
			$strRendered .= '# ';
		}
		$strRendered .= $this->strCommand;
		
		$strProps = $this->RenderProps();
		
		$strRendered .= sprintf(
			'(%s)',
			$strProps
		);
		if(!$this->blnRenderChildrenInBrackets){
			
			if($this instanceof MCADManipulationBase){
				$strRendered .= ' ';
			}else{
				$strRendered .= ';' . "\n";
			}	
			
			
		}else{
			$strRendered .= '{' . "\n";
		
			foreach($this->arrChildren as $intIndex => $objChild){
				if($objChild instanceof MCADTangableBase){
					$strRendered .= $objChild->Render();
				}
			}
			
			$strRendered .= "\n" .'}' . "\n";
		}
		return $strRendered;
	}
	public function RenderProps(){
		
		//Rendering Params
		$arrRenderedProps = array();
		
		foreach($this->arrProps as $strKey => $mixVar){
			if(is_string($mixVar)){
				$mixVar = sprintf('"%s"', $mixVar);
			}
			$arrRenderedProps[] = $strKey . '=' . $mixVar;
		}
		$strProps = implode(',', $arrRenderedProps);
		return $strProps;
	}
	public function __get($strName){
		switch($strName){
			case('Dissabled'):
				return $this->blnDissabled;
			case('Root'):
				return $this->blnRoot;
			case('Background'):
				return $this->blnBackground;
			case('Debug'):
				return $this->blnDebug;
			case('RenderChildrenInBrackets'):
				return $this->blnRenderChildrenInBrackets;
			case('Parent'):
				return $this->objParent;
			default:
				if(array_key_exists($strName, $this->arrProps)){
					return $this->arrProps[$strName];
				}else{
					return null;
				}
		}
	}
	
	public function __set($strName, $mixVal){
		switch($strName){
			case('Dissabled'):
				return $this->blnDissabled = $mixVal;
			case('Root'):
				return $this->blnRoot = $mixVal;
			case('Background'):
				return $this->blnBackground = $mixVal;
			case('Debug'):
				return $this->blnDebug = $mixVal;
			default:		
				return $this->arrProps[$strName] = $mixVal;		
		}
	}
	
	
}
