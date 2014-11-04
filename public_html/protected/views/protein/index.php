<?php

$this->breadcrumbs = array(
	Protein::label(2),
	Yii::t('app', 'Index'),
);

$this->menu = array(
	array('label'=>Yii::t('app', 'Search') . ' ' . Protein::label(), 'url' => array('search')),
);
?>

<h1><?php echo GxHtml::encode(Protein::label(2)); ?></h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); 