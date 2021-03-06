<?php

/**
 * This is the model base class for the table "crossreference".
 * DO NOT MODIFY THIS FILE! It is automatically generated by giix.
 * If any changes are necessary, you must set or override the required
 * property or method in class "Crossreference".
 *
 * Columns in table "crossreference" available as properties of the model,
 * followed by relations of table "crossreference" available as properties of the model.
 *
 * @property integer $fingerprint_id
 * @property string $name
 * @property string $accession
 * @property string $identifier
 * @property integer $reference_id
 *
 * @property Fingerprint $fingerprint
 */
abstract class BaseCrossreference extends GxActiveRecord {

	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public function tableName() {
		return 'crossreference';
	}

	public static function label($n = 1) {
		return Yii::t('app', 'Crossreference|Crossreferences', $n);
	}

	public static function representingColumn() {
		return 'name';
	}

	public function rules() {
		return array(
			array('fingerprint_id', 'numerical', 'integerOnly'=>true),
			array('name, accession', 'length', 'max'=>15),
			array('identifier', 'length', 'max'=>25),
			array('fingerprint_id, name, accession, identifier', 'default', 'setOnEmpty' => true, 'value' => null),
			array('fingerprint_id, name, accession, identifier, reference_id', 'safe', 'on'=>'search'),
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
			'fingerprint_id' => null,
			'name' => Yii::t('app', 'Name'),
			'accession' => Yii::t('app', 'Accession'),
			'identifier' => Yii::t('app', 'Identifier'),
			'reference_id' => Yii::t('app', 'Reference'),
			'fingerprint' => null,
		);
	}

	public function search() {
		$criteria = new CDbCriteria;

		$criteria->compare('fingerprint_id', $this->fingerprint_id);
		$criteria->compare('name', $this->name, true);
		$criteria->compare('accession', $this->accession, true);
		$criteria->compare('identifier', $this->identifier, true);
		$criteria->compare('reference_id', $this->reference_id);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
		));
	}
}