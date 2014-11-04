<?php

Yii::import('application.models._base.BaseReference');

class Reference extends BaseReference
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}