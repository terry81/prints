<?php

Yii::import('application.models._base.BaseCfi');

class Cfi extends BaseCfi
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}