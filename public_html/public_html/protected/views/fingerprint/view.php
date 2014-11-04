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

<pre>
<?php $this->widget('zii.widgets.CDetailView', array(
	'data' => $model,
	'attributes' => array(
'id',
'identifier',
'accession',
'no_motifs',
'creation_date',
'update_date',
'title',
'annotation',
'cfi',
'summary',
	),
)); ?>
</pre>

<h2><?php echo GxHtml::encode($model->getRelationLabel('references')); ?></h2>
<?php
	foreach($model->references as $relatedModel) {
        $reference = Reference::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
        $this->widget('zii.widgets.CDetailView', array(
            'data' => $reference,
            'attributes' => array(
            'author',
            'title',
            'journal',
            'year',
            ),
        ));
    echo '&nbsp;';
	}
?>

<h2>Crossreference</h2>
<?php
	echo GxHtml::openTag('ul');
	foreach($model->crossreferences as $relatedModel) {
        //Find and extract the attributes for each reference
        $crossreference = Crossreference::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
        echo GxHtml::openTag('li');
        //echo GxHtml::link(GxHtml::encode(GxHtml::valueEx($relatedModel)), array('crossreference/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true)));
        if (GxHtml::encode(GxHtml::valueEx($relatedModel))=="SCOP") {
            echo 'SCOP <a href="http://scop.mrc-lmb.cam.ac.uk/scop/search.cgi?key='.$crossreference->accession.'">'.$crossreference->accession.'</a>';
        } elseif (GxHtml::encode(GxHtml::valueEx($relatedModel))=="PROSITE") {
            echo 'PROSITE <a href="http://prosite.expasy.org/cgi-bin/prosite/prosite-search-ac?'.$crossreference->accession.'">'.$crossreference->accession.'</a>';
        } elseif (GxHtml::encode(GxHtml::valueEx($relatedModel))=="PDB") {
            echo 'PDB <a href="http://www.ebi.ac.uk/thornton-srv/databases/cgi-bin/pdbsum/GetPage.pl?pdbcode='.$crossreference->accession.'">'.$crossreference->accession.'</a>';
        } elseif (GxHtml::encode(GxHtml::valueEx($relatedModel))=="PRINTS") {
            echo 'PRINTS <a href="http://www.bioinf.manchester.ac.uk/cgi-bin/dbbrowser/PRINTS/DoPRINTS.pl?cmd_a=Display&qua_a=none&fun_a=Text&qst_a='.$crossreference->accession.'"> '.$crossreference->accession.'</a> ';
            echo '<a href="http://www.bioinf.manchester.ac.uk/cgi-bin/dbbrowser/PRINTS/DoPRINTS.pl?cmd_a=Display&qua_a=/Full&fun_a=Code&qst_a='.$crossreference->identifier.'">  '.$crossreference->identifier.'</a>';
        } elseif (GxHtml::encode(GxHtml::valueEx($relatedModel))=="INTERPRO") {
            echo 'INTERPRO '.$crossreference->accession;
        } elseif (GxHtml::encode(GxHtml::valueEx($relatedModel))=="CATH") {
            echo 'CATH <a href="http://www.cathdb.info/cgi-bin/search.pl?search_text='.$crossreference->accession.'">'.$crossreference->accession.'</a>';
        }
		echo GxHtml::closeTag('li');
	}
?>

</br>
<h2>Protein Titles</h2>
<?php
	echo GxHtml::openTag('ul');
	foreach($model->proteins as $relatedModel) {		
        $protein = Protein::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
        echo GxHtml::openTag('li');
        echo GxHtml::link(GxHtml::encode(GxHtml::valueEx($relatedModel)), array('protein/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true)));
        echo '&nbsp;&nbsp;&nbsp;'.$protein->description;
        echo GxHtml::closeTag('li');
	}
	echo GxHtml::closeTag('ul');
?>


<h2><?php echo GxHtml::encode($model->getRelationLabel('truepositives')); ?></h2>
<?php
	echo GxHtml::openTag('ul');
	foreach($model->truepositives as $relatedModel) {
		$truepositive = Truepositives::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
        $protein = Protein::model()->findByPk($truepositive->protein_id);
		echo GxHtml::openTag('li');
		echo GxHtml::link(GxHtml::encode($protein->code), array('truepositives/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true)));
		echo GxHtml::closeTag('li');
	}
	echo GxHtml::closeTag('ul');
?>

<h2><?php echo GxHtml::encode($model->getRelationLabel('truepartialpositives')); ?></h2>
Protein title - Number of elements</th></tr>
<?php
	foreach($model->truepartialpositives as $relatedModel) {
        $truepartialpositive = Truepartialpositives::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
		$protein = Protein::model()->findByPk($truepartialpositive->protein_id);

        //echo '</br>'.GxHtml::link(GxHtml::encode($protein->code), array('truepartialpositives/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true))).' - '.$truepartialpositive->numberofelements;
		$tpp_array[$protein->code] = $truepartialpositive->numberofelements;
        //echo GxHtml::openTag('re'); 
        //echo GxHtml::openTag('td');        
		//echo GxHtml::link(GxHtml::encode($protein->code), array('truepartialpositives/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true)));
        //echo GxHtml::closeTag('td');
        //echo GxHtml::openTag('td'); 
        //echo $truepartialpositive->numberofelements;
		//echo GxHtml::closeTag('td');
        //echo GxHtml::closeTag('tr');
	}
    asort($tpp_array);
    foreach ($tpp_array as $key => $val) {
        echo "</br> $key - $val";
    }
?>

<h2><?php echo GxHtml::encode($model->getRelationLabel('motifs')); ?></h2>
<?php
	echo GxHtml::openTag('ul');
	foreach($model->motifs as $relatedModel) {
		echo GxHtml::openTag('li');
		echo GxHtml::link(GxHtml::encode(GxHtml::valueEx($relatedModel)), array('motif/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true)));
		echo GxHtml::closeTag('li');
	}
	echo GxHtml::closeTag('ul');
?><h2>Scan History</h2>
<?php
	echo GxHtml::openTag('ul');
	foreach($model->scanhistories as $relatedModel) {
        $scanhistory = Scanhistory::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
        echo GxHtml::openTag('li');
        echo GxHtml::link(GxHtml::encode(GxHtml::valueEx($relatedModel)), array('scanhistory/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true)));
        //echo $scanhistory->database;
        echo '&nbsp;&nbsp;&nbsp;'.$scanhistory->iterations_number;
        echo '&nbsp;&nbsp;&nbsp;'.$scanhistory->hitlist_length;
        echo '&nbsp;&nbsp;&nbsp;'.$scanhistory->scanning_method;
		echo GxHtml::openTag('li');
		echo GxHtml::link(GxHtml::encode(GxHtml::valueEx($relatedModel)), array('scanhistory/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true)));
		echo GxHtml::closeTag('li');
	}
	echo GxHtml::closeTag('ul');
?>
