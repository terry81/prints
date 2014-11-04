<div class="wide form">

<?php $form = $this->beginWidget('GxActiveForm', array(
	'action' => Yii::app()->createUrl($this->route),
	'method' => 'get',
)); ?>

	<div class="row">
		<?php echo $form->label($model, 'sh_id'); ?>
		<?php echo $form->textField($model, 'sh_id'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'database'); ?>
		<?php echo $form->textField($model, 'database', array('maxlength' => 30)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'iterations_number'); ?>
		<?php echo $form->textField($model, 'iterations_number'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'hitlist_length'); ?>
		<?php echo $form->textField($model, 'hitlist_length'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'scanning_method'); ?>
		<?php echo $form->textField($model, 'scanning_method', array('maxlength' => 15)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'fingerprint_id'); ?>
		<?php echo $form->dropDownList($model, 'fingerprint_id', GxHtml::listDataEx(Fingerprint::model()->findAllAttributes(null, true)), array('prompt' => Yii::t('app', 'All'))); ?>
	</div>

	<div class="row buttons">
		<?php echo GxHtml::submitButton(Yii::t('app', 'Search')); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->
