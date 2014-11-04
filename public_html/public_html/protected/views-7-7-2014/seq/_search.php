<div class="wide form">

<?php $form = $this->beginWidget('GxActiveForm', array(
	'action' => Yii::app()->createUrl($this->route),
	'method' => 'get',
)); ?>

	<div class="row">
		<?php echo $form->label($model, 'seq_id'); ?>
		<?php echo $form->textField($model, 'seq_id'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'motif_id'); ?>
		<?php echo $form->dropDownList($model, 'motif_id', GxHtml::listDataEx(Motif::model()->findAllAttributes(null, true)), array('prompt' => Yii::t('app', 'All'))); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'sequence'); ?>
		<?php echo $form->textField($model, 'sequence', array('maxlength' => 30)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'pcode'); ?>
		<?php echo $form->textField($model, 'pcode', array('maxlength' => 10)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'start'); ?>
		<?php echo $form->textField($model, 'start'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'interval'); ?>
		<?php echo $form->textField($model, 'interval'); ?>
	</div>

	<div class="row buttons">
		<?php echo GxHtml::submitButton(Yii::t('app', 'Search')); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->
