<?php

$this->breadcrumbs = array(
	$model->label(2) => array('search'),
	Yii::t('app', 'Manage'),
);

$this->menu = array(
		array('label'=>Yii::t('app', 'List') . ' ' . $model->label(2), 'url'=>array('index')),
	);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$.fn.yiiGridView.update('seq-grid', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1><?php echo Yii::t('app', 'Manage') . ' ' . GxHtml::encode($model->label(2)); ?></h1>

<p>
You may optionally enter a comparison operator (&lt;, &lt;=, &gt;, &gt;=, &lt;&gt; or =) at the beginning of each of your search values to specify how the comparison should be done.
</p>

<?php echo GxHtml::link(Yii::t('app', 'Advanced Search'), '#', array('class' => 'search-button')); ?>
<div class="search-form">
<?php $this->renderPartial('_search', array(
	'model' => $model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('zii.widgets.grid.CGridView', array(
    'htmlOptions'=>array('style'=>'cursor: pointer;'),
    'selectionChanged'=>"function(id){window.location='" . Yii::app()->urlManager->createUrl('seq/view', array('id'=>'')) . "' + $.fn.yiiGridView.getSelection(id);}",
	'id' => 'seq-grid',
	'dataProvider' => $model->search(),
	'filter' => $model,
	'columns' => array(
		'seq_id',
		array(
				'name'=>'motif_id',
				'value'=>'GxHtml::valueEx($data->motif)',
				'filter'=>GxHtml::listDataEx(Motif::model()->findAllAttributes(null, true)),
				),
		'sequence',
		'pcode',
		'start',
		'interval',
		array(
			'class' => 'CButtonColumn',
            'template' => '{view}',
		),
	),
)); ?>