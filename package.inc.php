<?php
/*
 * Special thanks to Makerbot and Voltron - http://www.makerbot.com/blog/tag/openscad-tutorial/
 */
define('__MCAD__', dirname(__FILE__));

define('__MCAD_CORE__', __MCAD__ . '/_core');
define('__MCAD_CORE_CTL__', __MCAD_CORE__ . '/ctl');
define('__MCAD_CORE_MODEL__', __MCAD_CORE__ . '/model');
define('__MCAD_CORE_VIEW__', __MCAD_CORE__ . '/view');
MLCApplicationBase::$arrClassFiles['MCADDriver'] = __MCAD_CORE__ . '/MCADDriver.class.php';
MLCApplicationBase::$arrClassFiles['MCADObjectBase'] = __MCAD_CORE__ . '/MCADObjectBase.class.php';
MLCApplicationBase::$arrClassFiles['MCADTangableBase'] = __MCAD_CORE__ . '/MCADTangableBase.class.php';

//2d
MLCApplicationBase::$arrClassFiles['MCAD2DObjectBase'] = __MCAD_CORE__ . '/2d/MCAD2DObjectBase.class.php';
MLCApplicationBase::$arrClassFiles['MCADCircleObject'] = __MCAD_CORE__ . '/2d/MCADCircleObject.class.php';
MLCApplicationBase::$arrClassFiles['MCADPolygonObject'] = __MCAD_CORE__ . '/2d/MCADPolygonObject.class.php';
MLCApplicationBase::$arrClassFiles['MCADSquareObject'] = __MCAD_CORE__ . '/2d/MCADSquareObject.class.php';
//3d
MLCApplicationBase::$arrClassFiles['MCAD3DObjectBase'] = __MCAD_CORE__ . '/3d/MCAD3DObjectBase.class.php';
MLCApplicationBase::$arrClassFiles['MCADCubeObject'] = __MCAD_CORE__ . '/3d/MCADCubeObject.class.php';
MLCApplicationBase::$arrClassFiles['MCADCylinderObject'] = __MCAD_CORE__ . '/3d/MCADCylinderObject.class.php';
MLCApplicationBase::$arrClassFiles['MCADSphereObject'] = __MCAD_CORE__ . '/3d/MCADSphereObject.class.php';
//Group
MLCApplicationBase::$arrClassFiles['MCADGroupObjectBase'] = __MCAD_CORE__ . '/group/MCADGroupObjectBase.class.php';
MLCApplicationBase::$arrClassFiles['MCADColor'] = __MCAD_CORE__ . '/group/MCADColor.class.php';
MLCApplicationBase::$arrClassFiles['MCADDifference'] = __MCAD_CORE__ . '/group/MCADDifference.class.php';
MLCApplicationBase::$arrClassFiles['MCADHull'] = __MCAD_CORE__ . '/group/MCADHull.class.php';
MLCApplicationBase::$arrClassFiles['MCADIntersection'] = __MCAD_CORE__ . '/group/MCADIntersection.class.php';
MLCApplicationBase::$arrClassFiles['MCADMinkowski'] = __MCAD_CORE__ . '/group/MCADMinkowski.class.php';
MLCApplicationBase::$arrClassFiles['MCADUnion'] = __MCAD_CORE__ . '/group/MCADUnion.class.php';
//Manipulation
MLCApplicationBase::$arrClassFiles['MCADManipulationBase'] = __MCAD_CORE__ . '/manipulation/MCADManipulationBase.class.php';
MLCApplicationBase::$arrClassFiles['MCADLinearExtrude'] = __MCAD_CORE__ . '/manipulation/MCADLinearExtrude.class.php';
MLCApplicationBase::$arrClassFiles['MCADRotate'] = __MCAD_CORE__ . '/manipulation/MCADRotate.class.php';
MLCApplicationBase::$arrClassFiles['MCADRotateExtrude'] = __MCAD_CORE__ . '/manipulation/MCADRotateExtrude.class.php';
MLCApplicationBase::$arrClassFiles['MCADScale'] = __MCAD_CORE__ . '/manipulation/MCADScale.class.php';
MLCApplicationBase::$arrClassFiles['MCADTranslate'] = __MCAD_CORE__ . '/manipulation/MCADTranslate.class.php';
//Mash
MLCApplicationBase::$arrClassFiles['MCADImport'] = __MCAD_CORE__ . '/mash/MCADImport.class.php';
MLCApplicationBase::$arrClassFiles['MCADInclude'] = __MCAD_CORE__ . '/mash/MCADInclude.class.php';


require_once(__MCAD_CORE__ . '/_enum.inc.php');
require_once(__MCAD_CORE__ . '/_exception.inc.php');

