<?php

/**
 * This is the model base class for the table "motif".
 * DO NOT MODIFY THIS FILE! It is automatically generated by giix.
 * If any changes are necessary, you must set or override the required
 * property or method in class "Motif".
 *
 * Columns in table "motif" available as properties of the model,
 * followed by relations of table "motif" available as properties of the model.
 *
 * @property integer $motif_id
 * @property integer $fingerprint_id
 * @property string $title
 * @property string $code
 * @property integer $length
 * @property string $position
 *
 * @property Intermotifdistance[] $intermotifdistances
 * @property Fingerprint $fingerprint
 * @property Seq[] $seqs
 */
abstract class BaseMotif extends GxActiveRecord {

	public static function model($className=__CLASS__) {
		return parent::model($className);
	}

	public function tableName() {
		return 'motif';
	}

	public static function label($n = 1) {
		return Yii::t('app', 'Motif|Motifs', $n);
	}

	public static function representingColumn() {
		return 'code';
	}

	public function rules() {
		return array(
			array('code, position', 'required'),
			array('fingerprint_id, length', 'numerical', 'integerOnly'=>true),
			array('title', 'length', 'max'=>100),
			array('code', 'length', 'max'=>15),
			array('position', 'length', 'max'=>7),
			array('fingerprint_id, title, length', 'default', 'setOnEmpty' => true, 'value' => null),
			array('motif_id, fingerprint_id, title, code, length, position', 'safe', 'on'=>'search'),
		);
	}

	public function relations() {
		return array(
			'intermotifdistances' => array(self::HAS_MANY, 'Intermotifdistance', 'motif_id'),
			'fingerprint' => array(self::BELONGS_TO, 'Fingerprint', 'fingerprint_id'),
			'seqs' => array(self::HAS_MANY, 'Seq', 'motif_id'),
		);
	}

	public function pivotModels() {
		return array(
		);
	}

	public function attributeLabels() {
		return array(
			'motif_id' => Yii::t('app', 'Motif'),
			'fingerprint_id' => null,
			'title' => Yii::t('app', 'Title'),
			'code' => Yii::t('app', 'Code'),
			'length' => Yii::t('app', 'Length'),
			'position' => Yii::t('app', 'Position'),
			'intermotifdistances' => null,
			'fingerprint' => null,
			'seqs' => null,
		);
	}

	public function search() {
		$criteria = new CDbCriteria;

		$criteria->compare('motif_id', $this->motif_id);
		$criteria->compare('fingerprint_id', $this->fingerprint_id);
		$criteria->compare('title', $this->title, true);
		$criteria->compare('UPPER(code)', strtoupper($this->code), true);
		$criteria->compare('length', $this->length);
		$criteria->compare('position', $this->position, true);

		return new CActiveDataProvider($this, array(
			'criteria' => $criteria,
		));
	}
}
