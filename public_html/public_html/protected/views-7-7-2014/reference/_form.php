<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'reference-form',
	'enableAjaxValidation' => false,
));
?>

	<p class="note">
		<?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?>.
	</p>

	<?php echo $form->errorSummary($model); ?>

		<div class="row">
		<?php echo $form->labelEx($model,'fingerprint_id'); ?>
		<?php echo $form->dropDownList($model, 'fingerprint_id', GxHtml::listDataEx(Fingerprint::model()->findAllAttributes(null, true))); ?>
		<?php echo $form->error($model,'fingerprint_id'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'author'); ?>
		<?php echo $form->textField($model, 'author', array('maxlength' => 100)); ?>
		<?php echo $form->error($model,'author'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'title'); ?>
		<?php echo $form->textField($model, 'title', array('maxlength' => 100)); ?>
		<?php echo $form->error($model,'title'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'journal'); ?>
		<?php echo $form->textField($model, 'journal', array('maxlength' => 100)); ?>
		<?php echo $form->error($model,'journal'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'year'); ?>
		<?php echo $form->textField($model, 'year'); ?>
		<?php echo $form->error($model,'year'); ?>
		</div><!-- row -->


<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->