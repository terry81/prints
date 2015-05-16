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

<h2>Reference</h2>
<table>
<tr><th>Author</th><th>Title</th><th>Journal</th><th>Year</th></tr>
<?php
	foreach($model->references as $relatedModel) {
        $reference = Reference::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
        print '<tr><td>'.$reference->author.'</td><td>'.$reference->title.'</td><td>'.$reference->journal.'</td><td>'.$reference->year.'</td></tr>';
        /**$this->widget('zii.widgets.CDetailView', array(
            'data' => $reference,
            'attributes' => array(
            'author',
            'title',
            'journal',
            'year',
            ),
        ));
    echo '&nbsp;'; **/
	}
?>
</table>
<h2>Database Cross-References</h2>
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
        }  elseif (GxHtml::encode(GxHtml::valueEx($relatedModel))=="PFAM") {
            echo 'PFAM '.$crossreference->accession.' '.$crossreference->identifier;
        }
		echo GxHtml::closeTag('li');
	}
?>

</br>
<?php

/**
    Removed proteins
	echo GxHtml::openTag('ul');
	foreach($model->proteins as $relatedModel) {		
        $protein = Protein::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
        echo GxHtml::openTag('li');
        //echo GxHtml::link(GxHtml::encode(GxHtml::valueEx($relatedModel)), array('protein/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true)));
        echo '<a href="http://www.uniprot.org/uniprot/'.$relatedModel.'">'.$relatedModel.'</a>';
        echo '&nbsp;&nbsp;&nbsp;'.$protein->description;
        echo GxHtml::closeTag('li');
	}
	echo GxHtml::closeTag('ul');
**/?>


<h2>True-positives</h2>
<table>
<tr><th>Protein code</th><th>Accession number</th><th>Description</th></tr>
<?php
	foreach($model->truepositives as $relatedModel) {
		$truepositive = Truepositives::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
        $protein = Protein::model()->findByPk($truepositive->protein_id);
        echo '<tr><td>'.$protein->code.'</td>'.'<td><a href="http://www.uniprot.org/uniprot/'.$truepositive->accession_number.'">'.$truepositive->accession_number.'</a></td><td>'.$protein->description.'</td></tr>';
	}
?>
</table>
<?php
	foreach($model->truepartialpositives as $relatedModel) {
        $truepartialpositive = Truepartialpositives::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
		$protein = Protein::model()->findByPk($truepartialpositive->protein_id);
        $tpp_array[$protein->code] = array($truepartialpositive->numberofelements, $truepartialpositive->accession_number);
	}
    if (!empty($tpp_array)) {
        echo '<h2>True-partial-positives</h2>';
        echo '<table><tr><th>Protein title</th><th>Accession number</th><th>Number of elements</th><th>Description</th></tr>';
        arsort($tpp_array);
        foreach ($tpp_array as $key => $val) {
        //The link to Uniprot is connected to the accession number as requested by prof. Attwood
            echo '<tr><td>'.$key.'</td><td><a href="http://www.uniprot.org/uniprot/'.$val[1].'">'.$val[1].'</a></td><td>'.$val[0].'</td><td>'.$protein->description.'</td>';
        }
        echo '</table></br></br>';
    }
?>

<h2>Initial Motifs</h2>
<?php
	echo GxHtml::openTag('ul');
	foreach($model->motifs as $relatedModel) {
		$motif = Motif::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
        if ($motif->position == 'initial') {
            echo GxHtml::openTag('li');
            echo GxHtml::link(GxHtml::encode(GxHtml::valueEx($relatedModel)), array('motif/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true)));
            echo GxHtml::closeTag('li');
        }
    }
	echo GxHtml::closeTag('ul');
?>

<h2>Final Motifs</h2>
<?php
	echo GxHtml::openTag('ul');
	foreach($model->motifs as $relatedModel) {
		$motif = Motif::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
        if ($motif->position == 'final') {
            echo GxHtml::openTag('li');
            echo GxHtml::link(GxHtml::encode(GxHtml::valueEx($relatedModel)), array('motif/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true)));
            echo GxHtml::closeTag('li');
        }
    }
	echo GxHtml::closeTag('ul');
?>


<h2>Scan History</h2>
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
	}
	echo GxHtml::closeTag('ul');
?>
