<?php

$this->breadcrumbs = array(
	Fingerprint::label(2),
	Yii::t('app', 'Index'),
);

$this->menu = array(
	//array('label'=>Yii::t('app', 'Create') . ' ' . Fingerprint::label(), 'url' => array('create')),
    array('label'=>Yii::t('app', 'Search') . ' ' . Fingerprint::label(), 'url' => array('search')),
	//array('label'=>Yii::t('app', 'Manage') . ' ' . Fingerprint::label(2), 'url' => array('admin')),
);
?>

<h1><?php echo GxHtml::encode(Fingerprint::label(2)); ?></h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); 