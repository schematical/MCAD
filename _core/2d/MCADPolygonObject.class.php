<?php
class MCADPolygonObject extends MCAD2DObjectBase{
	protected $arrPoints = array();
	protected $strCommand = 'polygon';
	protected $arrPaths = null;
	
	public function AddPoint($intX, $intY, $blnDrawPath = true){
		if($blnDrawPath){
			$this->arrPaths[] = count($this->arrPoints);
		}
		$this->arrPoints[] = array(
			'x'=>$intX,
			'y'=>$intY
		);
		
		return $this;
		
	}
	public function RenderProps(){
		$arrRenderedPoint = '';
		foreach($this->arrPoints as $intIndex => $arrPointData){
			$arrRenderedPoint[] = sprintf(
				'[%s, %s]',
				$arrPointData['x'],
				$arrPointData['y']				
			);
		}
		$strPoints = implode(',', $arrRenderedPoint);
		
		
		
		$strPaths = sprintf(
			'[%s]',
			implode(',', $this->arrPaths)		
		);
		return sprintf(
			'[%s], [%s]',
			$strPoints,
			$strPaths		
		);
	}

}