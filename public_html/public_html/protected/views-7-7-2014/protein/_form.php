<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'protein-form',
	'enableAjaxValidation' => false,
));
?>

	<p class="note">
		<?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?>.
	</p>

	<?php echo $form->errorSummary($model); ?>

		<div class="row">
		<?php echo $form->labelEx($model,'fingerprint_id'); ?>
		<?php echo $form->textField($model, 'fingerprint_id'); ?>
		<?php echo $form->error($model,'fingerprint_id'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'identifier'); ?>
		<?php echo $form->textField($model, 'identifier', array('maxlength' => 15)); ?>
		<?php echo $form->error($model,'identifier'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'title'); ?>
		<?php echo $form->textField($model, 'title', array('maxlength' => 100)); ?>
		<?php echo $form->error($model,'title'); ?>
		</div><!-- row -->


<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->