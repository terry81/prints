<?php

Yii::import('application.models._base.BaseProtein');

class Protein extends BaseProtein
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}