<?php

Yii::import('application.models._base.BaseSeq');

class Seq extends BaseSeq
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}