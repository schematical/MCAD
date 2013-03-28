<?php
class MCADCubeObject extends MCAD3DObjectBase{

	public function RenderProps(){
		return sprintf(
			'[%s, %s, %s]',
			$this->x,
			$this->y,
			$this->z		
		);
	}

}