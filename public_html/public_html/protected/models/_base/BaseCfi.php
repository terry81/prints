<?php

/**
 * This is the model base class for the table "cfi".
 * DO NOT MODIFY THIS FILE! It is automatically generated by giix.
 * If any changes are necessary, you must set or override the required
 * property or method in class "Cfi".
 *
 * Columns in table "cfi" available as properties of the model,
 * followed by relations of table "cfi" available as properties of the model.
 *
 * @property integer $cfi_id
 * @property integer $fingerprint_id
 * @property integer $hitlist_number
 * @property string $hitlist_value
 *
 * @property Fingerprint $fingerprint
 */
abstract class BaseCfi extends GxActiveRecord {

	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public function tableName() {
		return 'cfi';
	}

	public static function label($n = 1) {
		return Yii::t('app', 'Cfi|Cfis', $n);
	}

	public static function representingColumn() {
		return 'hitlist_value';
	}

	public function rules() {
		return array(
			array('cfi_id', 'required'),
			array('cfi_id, fingerprint_id, hitlist_number', 'numerical', 'integerOnly'=>true),
			array('hitlist_value', 'safe'),
			array('fingerprint_id, hitlist_number, hitlist_value', 'default', 'setOnEmpty' => true, 'value' => null),
			array('cfi_id, fingerprint_id, hitlist_number, hitlist_value', 'safe', 'on'=>'search'),
		);
	}

	public function relations() {
		return array(
			'fingerprint' => array(self::BELONGS_TO, 'Fingerprint', 'fingerprint_id'),
		);
	}

	public function pivotModels() {
		return array(
		);
	}

	public function attributeLabels() {
		return array(
			'cfi_id' => Yii::t('app', 'Cfi'),
			'fingerprint_id' => null,
			'hitlist_number' => Yii::t('app', 'Hitlist Number'),
			'hitlist_value' => Yii::t('app', 'Hitlist Value'),
			'fingerprint' => null,
		);
	}

	public function search() {
		$criteria = new CDbCriteria;

		$criteria->compare('cfi_id', $this->cfi_id);
		$criteria->compare('fingerprint_id', $this->fingerprint_id);
		$criteria->compare('hitlist_number', $this->hitlist_number);
		$criteria->compare('hitlist_value', $this->hitlist_value, true);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
		));
	}
}