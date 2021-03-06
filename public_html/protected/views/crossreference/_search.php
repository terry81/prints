<div class="wide form">

<?php $form = $this->beginWidget('GxActiveForm', array(
	'action' => Yii::app()->createUrl($this->route),
	'method' => 'get',
)); ?>

	<div class="row">
		<?php echo $form->label($model, 'fingerprint_id'); ?>
		<?php echo $form->dropDownList($model, 'fingerprint_id', GxHtml::listDataEx(Fingerprint::model()->findAllAttributes(null, true)), array('prompt' => Yii::t('app', 'All'))); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'name'); ?>
		<?php echo $form->textField($model, 'name', array('maxlength' => 15)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'accession'); ?>
		<?php echo $form->textField($model, 'accession', array('maxlength' => 15)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'identifier'); ?>
		<?php echo $form->textField($model, 'identifier', array('maxlength' => 25)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'reference_id'); ?>
		<?php echo $form->textField($model, 'reference_id'); ?>
	</div>

	<div class="row buttons">
		<?php echo GxHtml::submitButton(Yii::t('app', 'Search')); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->
