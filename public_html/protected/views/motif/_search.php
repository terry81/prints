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
		<?php echo $form->label($model, 'title'); ?>
		<?php echo $form->textField($model, 'title', array('maxlength' => 100)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'code'); ?>
		<?php echo $form->textField($model, 'code', array('maxlength' => 15)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'length'); ?>
		<?php echo $form->textField($model, 'length'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'position'); ?>
		<?php echo $form->textField($model, 'position', array('maxlength' => 7)); ?>
	</div>

	<div class="row buttons">
		<?php echo GxHtml::submitButton(Yii::t('app', 'Search')); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->
