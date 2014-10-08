<?php

Yii::import('application.models._base.BaseCrossReference');

class CrossReference extends BaseCrossReference
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}