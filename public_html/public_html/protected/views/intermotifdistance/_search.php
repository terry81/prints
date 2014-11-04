<div class="wide form">

<?php $form = $this->beginWidget('GxActiveForm', array(
	'action' => Yii::app()->createUrl($this->route),
	'method' => 'get',
)); ?>

	<div class="row">
		<?php echo $form->label($model, 'imd_id'); ?>
		<?php echo $form->textField($model, 'imd_id'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'motif_id'); ?>
		<?php echo $form->dropDownList($model, 'motif_id', GxHtml::listDataEx(Motif::model()->findAllAttributes(null, true)), array('prompt' => Yii::t('app', 'All'))); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'region'); ?>
		<?php echo $form->textField($model, 'region', array('maxlength' => 10)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'min'); ?>
		<?php echo $form->textField($model, 'min'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'max'); ?>
		<?php echo $form->textField($model, 'max', array('maxlength' => 10)); ?>
	</div>

	<div class="row buttons">
		<?php echo GxHtml::submitButton(Yii::t('app', 'Search')); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->
