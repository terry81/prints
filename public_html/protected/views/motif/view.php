<?php

$this->breadcrumbs = array(
	$model->label(2) => array('index'),
	GxHtml::valueEx($model),
);

$this->menu=array(
	array('label'=>Yii::t('app', 'List') . ' ' . $model->label(2), 'url'=>array('index')),
	array('label'=>Yii::t('app', 'Create') . ' ' . $model->label(), 'url'=>array('create')),
	array('label'=>Yii::t('app', 'Update') . ' ' . $model->label(), 'url'=>array('update', 'id' => $model->motif_id)),
	array('label'=>Yii::t('app', 'Delete') . ' ' . $model->label(), 'url'=>'#', 'linkOptions' => array('submit' => array('delete', 'id' => $model->motif_id), 'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>Yii::t('app', 'Manage') . ' ' . $model->label(2), 'url'=>array('admin')),
);
?>

<h1><?php echo Yii::t('app', 'View') . ' ' . GxHtml::encode($model->label()) . ' ' . GxHtml::encode(GxHtml::valueEx($model)); ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data' => $model,
	'attributes' => array(
'motif_id',
array(
			'name' => 'fingerprint',
			'type' => 'raw',
			'value' => $model->fingerprint !== null ? GxHtml::link(GxHtml::encode(GxHtml::valueEx($model->fingerprint)), array('fingerprint/view', 'id' => GxActiveRecord::extractPkValue($model->fingerprint, true))) : null,
			),
'title',
'code',
'length',
'position',
	),
)); ?>

<h2>Inter Motif Distance</h2>
<?php
        foreach($model->intermotifdistances as $relatedModel) {
        $intermotifdistance = Intermotifdistance::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));

        $this->widget('zii.widgets.CDetailView', array(
        'data' => $intermotifdistance,
        'attributes' => array(
            'region',
            'min',
            'max',
            ),
        ));

        }
?><h2>Sequences</h2>
<pre>
<table>
<tr><th>Sequences</th><th>Pcode</th><th>Start</th><th>Interval</th></tr>
<?php
	
	foreach($model->seqs as $relatedModel) {
        $sequence = Seq::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
		echo GxHtml::openTag('td');
        echo GxHtml::link(GxHtml::encode($sequence->sequence), array('seq/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true)));
        echo GxHtml::closeTag('td');
        echo GxHtml::openTag('td');
        echo $sequence->pcode;
        echo GxHtml::closeTag('td');
        echo GxHtml::openTag('td');
        echo $sequence->start;
        echo GxHtml::closeTag('td');
        echo GxHtml::openTag('td');
        echo $sequence->interval;		
		echo GxHtml::closeTag('td');
        echo GxHtml::closeTag('tr');
	}

?>
</table>
</pre>