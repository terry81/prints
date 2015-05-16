<?php

$this->breadcrumbs = array(
	$model->label(2) => array('search'),
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


<h1><?php echo "Fingerprint $model->identifier"; ?></h1>

<?php
$model->annotation = trim(preg_replace('/\n{2,}/', 'secret_delimiter', $model->annotation));
$model->annotation = trim(preg_replace('/\n+/', ' ', $model->annotation));
$model->annotation = trim(preg_replace('/secret_delimiter/', "\n\n", $model->annotation));


$model->creation_date = strtotime($model->creation_date );
$model->creation_date = date ('d-m-Y', $model->creation_date);

if ($model->update_date) {
    $model->update_date = strtotime($model->update_date );
    $model->update_date = date ('d-m-Y', $model->update_date);
} else {
    $model->update_date = '';
}

$model->summary = preg_replace('/\b(\d{3})\b codes/', "&nbsp;$1 codes", $model->summary);
$model->summary = preg_replace('/\b(\d{2})\b codes/', "&nbsp;&nbsp;$1 codes", $model->summary);
$model->summary = preg_replace('/\b(\d{1})\b codes/', "&nbsp;&nbsp;&nbsp;$1 codes", $model->summary);
$model->summary = preg_replace('/elements/', 'motifs', $model->summary);

$model->cfi = preg_replace('/\n\|\s+1\s+2/', "\n&nbsp;| 1 2", $model->cfi);
$model->cfi = preg_replace('/\b(\d{1})\b /', "&nbsp;&nbsp;$1 ", $model->cfi);
$model->cfi = preg_replace('/\b(\d{2})\b /', "&nbsp;$1 ", $model->cfi);

echo 'Title: '.$model->title.'</br>';
echo 'Number of motifs: '.$model->no_motifs.'</br>';
echo 'Creation date: '.$model->creation_date.'; Updated: '.$model->update_date.'</br>';
echo 'Accession: '.$model->accession.'</br></br>';

?>

<h2>Database Cross-References</h2>
<?php
    $print_prints = 0;
    $print_scop = 0;
    $print_prosite = 0;
    $print_pdb = 0;
    $print_interpro = 0;
    $print_cath = 0; 
    $print_pfam = 0;
	foreach($model->crossreferences as $relatedModel) {
        //Find and extract the attributes for each reference
        $crossreference = Crossreference::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
        if (GxHtml::encode(GxHtml::valueEx($relatedModel))=="SCOP") {
            if ($print_scop == 0) {
                echo '<br/>SCOP: ';
            }
            echo ' <a href="http://scop.mrc-lmb.cam.ac.uk/scop/search.cgi?key='.$crossreference->accession.'">'.$crossreference->accession.'</a>';
            $print_scop++;
        } elseif (GxHtml::encode(GxHtml::valueEx($relatedModel))=="PROSITE") {
            if ($print_prosite == 0) {
                echo '<br/>PROSITE: ';
            }
            echo ' <a href="http://prosite.expasy.org/cgi-bin/prosite/prosite-search-ac?'.$crossreference->accession.'">'.$crossreference->accession.'</a>';
            $print_prosite++;
        } elseif (GxHtml::encode(GxHtml::valueEx($relatedModel))=="PDB") {
            if ($print_pdb == 0) {
                echo '<br/>PDB: ';
            }
            echo ' <a href="http://www.ebi.ac.uk/thornton-srv/databases/cgi-bin/pdbsum/GetPage.pl?pdbcode='.$crossreference->accession.'">'.$crossreference->accession.'</a>';
            $print_pdb++;
        } elseif (GxHtml::encode(GxHtml::valueEx($relatedModel))=="PRINTS") {
            if ($print_prints == 0) {
                echo 'PRINTS: ';
            }
            echo ' <a href="http://www.bioinf.manchester.ac.uk/cgi-bin/dbbrowser/PRINTS/DoPRINTS.pl?cmd_a=Display&qua_a=none&fun_a=Text&qst_a='.$crossreference->accession.'">'.$crossreference->accession.'</a> ';
            echo ' <a href="http://www.bioinf.manchester.ac.uk/cgi-bin/dbbrowser/PRINTS/DoPRINTS.pl?cmd_a=Display&qua_a=/Full&fun_a=Code&qst_a='.$crossreference->identifier.'">'.$crossreference->identifier.'</a>';
            $print_prints++;
        } elseif (GxHtml::encode(GxHtml::valueEx($relatedModel))=="INTERPRO") {
            if ($print_interpro == 0) {
                echo '<br/>INTERPRO: ';
            }
            echo ' <a href="http://www.ebi.ac.uk/interpro/entry/'.$crossreference->accession.'">'.$crossreference->accession.'</a>';
            $print_interpro++;
        } elseif (GxHtml::encode(GxHtml::valueEx($relatedModel))=="CATH") {
            if ($print_cath == 0) {
                echo '<br/>CATH: ';
            }
            echo ' <a href="http://www.cathdb.info/cgi-bin/search.pl?search_text='.$crossreference->accession.'">'.$crossreference->accession.'</a>';
            $print_cath++;
        }  elseif (GxHtml::encode(GxHtml::valueEx($relatedModel))=="PFAM") {
            if ($print_pfam == 0) {
                echo '<br/>PFAM: ';
            }
            echo ' '.$crossreference->accession.' '.$crossreference->identifier;
            $print_pfam++;
        }
         echo ';';
	}

	
echo "</br></br><h2>Annotation</h2>";
$this->widget('ext.expander.Expander',array(
            'content'=>nl2br($model->annotation),
            'config'=>array('slicePoint'=>300, 'expandText'=>'read more', 'userCollapseText'=>'read less', 'preserveWords'=>true)
        ));	
?>

</br></br>
<h2>Literature References</h2>
<?php
	foreach($model->references as $relatedModel) {
        $reference = Reference::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
        print $reference->author.'</br>'.$reference->title.'</br>'.$reference->journal.'</br>'.'</br>';
	}
?>

<?php
echo '</br><h2>Summary</h2>'.nl2br($model->summary).'</br>';
echo '</br><h2>Composite Fingerprint Index</h2>'.nl2br($model->cfi).'</br>';
?>

</br></br>


<h2>True-positives</h2>
<table style="table">
<col width="10%"><col width="5%"><col width="85%">
<tr><th>Protein ID code</th><th>Accession number</th><th>Description</th></tr>
<?php
	foreach($model->truepositives as $relatedModel) {
		$truepositive = Truepositives::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
        $protein = Protein::model()->findByPk($truepositive->protein_id);
        echo '<tr><td>'.$protein->code.'</td>'.'<td><a href="http://www.uniprot.org/uniprot/'.$truepositive->accession_number.'">'.$truepositive->accession_number.'</a></td><td>'.$protein->description.'</td></tr>';
	}
?>
</table>
</div>
<?php
	foreach($model->truepartialpositives as $relatedModel) {
        $truepartialpositive = Truepartialpositives::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
		$protein = Protein::model()->findByPk($truepartialpositive->protein_id);
        $tpp_array[$protein->code] = array($truepartialpositive->numberofelements, $truepartialpositive->accession_number, $protein->description);
	}
    if (!empty($tpp_array)) {
        echo '<h2>True-partial-positives</h2>';
        echo '<table style="table"><col width="10%"><col width="5%"><col width="5%"><col width="80%"><tr><th>Protein ID code</th><th>Accession number</th><th>Number of motifs</th><th>Description</th></tr>';
        arsort($tpp_array);
        foreach ($tpp_array as $key => $val) {
        //The link to Uniprot is connected to the accession number as requested by prof. Attwood
            echo '<tr><td>'.$key.'</td><td><a href="http://www.uniprot.org/uniprot/'.$val[1].'">'.$val[1].'</a></td><td>'.$val[0].'</td><td>'.$val[2].'</td>';
        }
        echo '</table></br></br>';
    }
?>


<h2>Scan History</h2>
<table style="table">
<col width="10"><col width="10"><col width="10">
<?php
	foreach($model->scanhistories as $relatedModel) {
        $scanhistory = Scanhistory::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
        echo '<tr>';
        echo '<td>';
        echo GxHtml::link(GxHtml::encode(GxHtml::valueEx($relatedModel)), array('scanhistory/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true)));
        echo '</td><td>';
        echo '&nbsp;&nbsp;&nbsp;'.$scanhistory->iterations_number;
        echo '</td><td>';
        echo '&nbsp;&nbsp;&nbsp;'.$scanhistory->hitlist_length;
        echo '</td><td>';
        echo '&nbsp;&nbsp;&nbsp;'.$scanhistory->scanning_method;
        echo '</td>';
        echo '</tr>';
	}
?>
</table>

<h2>Initial Motifs</h2>
<?php
	foreach($model->motifs as $relatedModel) {
		$motif = Motif::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
        $seqs = Seq::model()->findAllByAttributes(array('motif_id'=>$motif['motif_id']));
        if ($motif->position == 'initial') {
            echo '&nbsp;'.GxHtml::link(GxHtml::encode(GxHtml::valueEx($relatedModel)), array('motif/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true))).' Length: '.$motif['length'].'. '.$motif['title'].'</br></br>';
            print '<table style="width:300px">';
            foreach($seqs as $item) {
                print '<tr>';
                print '<td>'.$item['sequence'].'</td><td>'.$item['pcode'].'</td><td>'.$item['start'].'</td><td>'. $item['interval'].'</td>';
                print '</tr>';
            }
            print '</table>';
        }
    }
?>

<h2>Final Motifs</h2>
<?php
	foreach($model->motifs as $relatedModel) {
		$motif = Motif::model()->findByPK(GxActiveRecord::extractPkValue($relatedModel, true));
        $seqs = Seq::model()->findAllByAttributes(array('motif_id'=>$motif['motif_id']));
        if ($motif->position == 'final') {
            echo '&nbsp;'.GxHtml::link(GxHtml::encode(GxHtml::valueEx($relatedModel)), array('motif/view', 'id' => GxActiveRecord::extractPkValue($relatedModel, true))).' Length: '.$motif['length'].'. '.$motif['title'].'</br></br>';
            print '<table style="width:300px">';
            foreach($seqs as $item) {
                print '<tr>';
                print '<td>'.$item['sequence'].'</td><td>'.$item['pcode'].'</td><td style="text-align: right">'.$item['start'].'</td><td style="text-align: right">'. $item['interval'].'</td>';
                print '</tr>';
            }
            print '</table>';
        }
    }
?>
