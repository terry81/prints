<?php

$this->breadcrumbs = array(
	$model->label(2) => array('index'),
	GxHtml::valueEx($model),
);

$this->menu=array(
	array('label'=>Yii::t('app', 'List') . ' ' . $model->label(2), 'url'=>array('index')),
	array('label'=>Yii::t('app', 'Create') . ' ' . $model->label(), 'url'=>array('create')),
	array('label'=>Yii::t('app', 'Update') . ' ' . $model->label(), 'url'=>array('update', 'id' => $model->tpp_id)),
	array('label'=>Yii::t('app', 'Delete') . ' ' . $model->label(), 'url'=>'#', 'linkOptions' => array('submit' => array('delete', 'id' => $model->tpp_id), 'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>Yii::t('app', 'Manage') . ' ' . $model->label(2), 'url'=>array('admin')),
);
?>

<h1><?php echo Yii::t('app', 'View') . ' ' . GxHtml::encode($model->label()) . ' ' . GxHtml::encode(GxHtml::valueEx($model)); ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data' => $model,
	'attributes' => array(
'tpp_id',
array(
			'name' => 'fingerprint',
			'type' => 'raw',
			'value' => $model->fingerprint !== null ? GxHtml::link(GxHtml::encode(GxHtml::valueEx($model->fingerprint)), array('fingerprint/view', 'id' => GxActiveRecord::extractPkValue($model->fingerprint, true))) : null,
			),
array(
			'name' => 'protein',
			'type' => 'raw',
			'value' => $model->protein !== null ? GxHtml::link(GxHtml::encode(GxHtml::valueEx($model->protein)), array('protein/view', 'id' => GxActiveRecord::extractPkValue($model->protein, true))) : null,
			),
'numberofelements',
	),
)); ?>

