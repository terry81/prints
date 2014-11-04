<?php

Yii::import('application.models._base.BaseLiterature');

class Literature extends BaseLiterature
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}