<?php

$this->breadcrumbs = array(
	$model->label(2) => array('index'),
	GxHtml::valueEx($model),
);

$this->menu=array(
	array('label'=>Yii::t('app', 'List') . ' ' . $model->label(2), 'url'=>array('index')),
	array('label'=>Yii::t('app', 'Search') . ' ' . $model->label(), 'url'=>array('search')),
);
?>

<h1><?php echo Yii::t('app', 'View') . ' ' . GxHtml::encode($model->label()) . ' ' . GxHtml::encode(GxHtml::valueEx($model)); ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data' => $model,
	'attributes' => array(
'id',
array(
			'name' => 'fingerprint',
			'type' => 'raw',
			'value' => $model->fingerprint !== null ? GxHtml::link(GxHtml::encode(GxHtml::valueEx($model->fingerprint)), array('fingerprint/view', 'id' => GxActiveRecord::extractPkValue($model->fingerprint, true))) : null,
			),
'code',
'description',
	),
)); ?>

<h2><?php echo GxHtml::encode($model->getRelationLabel('truepartialpositives')); ?></h2>
<?php
	echo GxHtml::openTag('ul');
	foreach($model->truepartialpositives as $relatedModel) {
		echo GxHtml::openTag('li');
		echo GxHtml::link(GxHtml::encode(GxHtml::valueEx($relatedModel)), array('truepartialpositives/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true)));
		echo GxHtml::closeTag('li');
	}
	echo GxHtml::closeTag('ul');
?><h2><?php echo GxHtml::encode($model->getRelationLabel('truepositives')); ?></h2>
<?php
	echo GxHtml::openTag('ul');
	foreach($model->truepositives as $relatedModel) {
		echo GxHtml::openTag('li');
		echo GxHtml::link(GxHtml::encode(GxHtml::valueEx($relatedModel)), array('truepositives/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true)));
		echo GxHtml::closeTag('li');
	}
	echo GxHtml::closeTag('ul');
?>