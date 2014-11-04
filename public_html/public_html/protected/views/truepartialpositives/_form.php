<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'truepartialpositives-form',
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
		<?php echo $form->labelEx($model,'protein_id'); ?>
		<?php echo $form->dropDownList($model, 'protein_id', GxHtml::listDataEx(Protein::model()->findAllAttributes(null, true))); ?>
		<?php echo $form->error($model,'protein_id'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'numberofelements'); ?>
		<?php echo $form->textField($model, 'numberofelements'); ?>
		<?php echo $form->error($model,'numberofelements'); ?>
		</div><!-- row -->


<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->