<?php

$this->breadcrumbs = array(
	$model->label(2) => array('index'),
	GxHtml::valueEx($model),
);

$this->menu=array(
	array('label'=>Yii::t('app', 'List') . ' ' . $model->label(2), 'url'=>array('index')),
	array('label'=>Yii::t('app', 'Create') . ' ' . $model->label(), 'url'=>array('create')),
	array('label'=>Yii::t('app', 'Update') . ' ' . $model->label(), 'url'=>array('update', 'id' => $model->id)),
	array('label'=>Yii::t('app', 'Delete') . ' ' . $model->label(), 'url'=>'#', 'linkOptions' => array('submit' => array('delete', 'id' => $model->id), 'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>Yii::t('app', 'Manage') . ' ' . $model->label(2), 'url'=>array('admin')),
);
?>

<h1><?php echo Yii::t('app', 'View') . ' ' . GxHtml::encode($model->label()) . ' ' . GxHtml::encode(GxHtml::valueEx($model)); ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data' => $model,
	'attributes' => array(
//'id',
'identifier',
'accession',
'no_motifs',
'creation_date',
'update_date',
'title',
'annotation',
	),
)); ?>

<h2><?php echo GxHtml::encode($model->getRelationLabel('references')); ?></h2>
<?php
	echo GxHtml::openTag('ul');
	foreach($model->references as $relatedModel) {
		echo GxHtml::openTag('li');
		echo GxHtml::link(GxHtml::encode(GxHtml::valueEx($relatedModel)), array('reference/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true)));
		echo GxHtml::closeTag('li');
	}
	echo GxHtml::closeTag('ul');
?><h2><?php echo GxHtml::encode($model->getRelationLabel('crossreferences')); ?></h2>
<?php
	echo GxHtml::openTag('ul');
	foreach($model->crossreferences as $relatedModel) {
		//Find and extract the attributes for each reference
		$crossreference = Crossreference::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));

		echo GxHtml::openTag('li');
		//echo GxHtml::link(GxHtml::encode(GxHtml::valueEx($relatedModel)), array('crossreference/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true)));
		if (GxHtml::encode(GxHtml::valueEx($relatedModel))=="SCOP") {
		    echo '<a href="http://scop.mrc-lmb.cam.ac.uk/scop/search.cgi?key='.$crossreference->accession.'">SCOP '.$crossreference->accession.'</a>';
		} elseif (GxHtml::encode(GxHtml::valueEx($relatedModel))=="PROSITE") {
		    echo '<a href="http://prosite.expasy.org/cgi-bin/prosite/prosite-search-ac?'.$crossreference->accession.'">PROSITE '.$crossreference->accession.'</a>';
		} elseif (GxHtml::encode(GxHtml::valueEx($relatedModel))=="PDB") {
		    echo '<a href="http://www.ebi.ac.uk/thornton-srv/databases/cgi-bin/pdbsum/GetPage.pl?pdbcode='.$crossreference->accession.'">PDB '.$crossreference->accession.'</a>';
		} elseif (GxHtml::encode(GxHtml::valueEx($relatedModel))=="PRINTS") {
		    echo '<a href="http://www.bioinf.manchester.ac.uk/cgi-bin/dbbrowser/PRINTS/DoPRINTS.pl?cmd_a=Display&qua_a=none&fun_a=Text&qst_a='.$crossreference->accession.'">PRINTS '.$crossreference->accession.'</a>';
		}

		echo GxHtml::closeTag('li');
	}
	echo GxHtml::closeTag('ul');
?><h2><?php echo GxHtml::encode($model->getRelationLabel('motifs')); ?></h2>
<?php
	echo GxHtml::openTag('ul');
	foreach($model->motifs as $relatedModel) {
		echo GxHtml::openTag('li');
		echo GxHtml::link(GxHtml::encode(GxHtml::valueEx($relatedModel)), array('motif/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true)));
		echo GxHtml::closeTag('li');
	}
	echo GxHtml::closeTag('ul');
?>
