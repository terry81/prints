<?php

Yii::import('application.models._base.BaseFingerprint');

class Fingerprint extends BaseFingerprint
{
	public static function model($className=__CLASS__) {
		return parent::model($className);
	}
}