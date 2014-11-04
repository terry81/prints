<div class="wide form">

<?php $form = $this->beginWidget('GxActiveForm', array(
	'action' => Yii::app()->createUrl($this->route),
	'method' => 'get',
)); ?>

	<div class="row">
		<?php echo $form->label($model, 'tpp_id'); ?>
		<?php echo $form->textField($model, 'tpp_id'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'fingerprint_id'); ?>
		<?php echo $form->dropDownList($model, 'fingerprint_id', GxHtml::listDataEx(Fingerprint::model()->findAllAttributes(null, true)), array('prompt' => Yii::t('app', 'All'))); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'protein_id'); ?>
		<?php echo $form->dropDownList($model, 'protein_id', GxHtml::listDataEx(Protein::model()->findAllAttributes(null, true)), array('prompt' => Yii::t('app', 'All'))); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'numberofelements'); ?>
		<?php echo $form->textField($model, 'numberofelements'); ?>
	</div>

	<div class="row buttons">
		<?php echo GxHtml::submitButton(Yii::t('app', 'Search')); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->
