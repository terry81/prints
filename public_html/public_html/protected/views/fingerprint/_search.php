<div class="wide form">

<?php $form = $this->beginWidget('GxActiveForm', array(
	'action' => Yii::app()->createUrl($this->route),
	'method' => 'get',
)); ?>


	<div class="row">
		<?php echo $form->label($model, 'identifier'); ?>
		<?php echo $form->textField($model, 'identifier', array('maxlength' => 15)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'accession'); ?>
		<?php echo $form->textField($model, 'accession', array('maxlength' => 40)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'no_motifs'); ?>
		<?php echo $form->textField($model, 'no_motifs'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'creation_date'); ?>
		<?php $form->widget('zii.widgets.jui.CJuiDatePicker', array(
			'model' => $model,
			'attribute' => 'creation_date',
			'value' => $model->creation_date,
			'options' => array(
				'showButtonPanel' => true,
				'changeYear' => true,
				'dateFormat' => 'yy-mm-dd',
				),
			));
; ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'update_date'); ?>
		<?php $form->widget('zii.widgets.jui.CJuiDatePicker', array(
			'model' => $model,
			'attribute' => 'update_date',
			'value' => $model->update_date,
			'options' => array(
				'showButtonPanel' => true,
				'changeYear' => true,
				'dateFormat' => 'yy-mm-dd',
				),
			));
; ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'title'); ?>
		<?php echo $form->textField($model, 'title', array('maxlength' => 100)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'annotation'); ?>
		<?php echo $form->textArea($model, 'annotation'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'cfi'); ?>
		<?php echo $form->textArea($model, 'cfi'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model, 'summary'); ?>
		<?php echo $form->textArea($model, 'summary'); ?>
	</div>

	<div class="row buttons">
		<?php echo GxHtml::submitButton(Yii::t('app', 'Search')); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->
