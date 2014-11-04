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
		<?php echo $form->dropDownList($model, 'fingerprint_id', GxHtml::listDataEx(Fingerprint::model()->findAllAttributes(null, true))); ?>
		<?php echo $form->error($model,'fingerprint_id'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'code'); ?>
		<?php echo $form->textField($model, 'code', array('maxlength' => 20)); ?>
		<?php echo $form->error($model,'code'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'description'); ?>
		<?php echo $form->textField($model, 'description', array('maxlength' => 2000)); ?>
		<?php echo $form->error($model,'description'); ?>
		</div><!-- row -->

		<label><?php echo GxHtml::encode($model->getRelationLabel('truepartialpositives')); ?></label>
		<?php echo $form->checkBoxList($model, 'truepartialpositives', GxHtml::encodeEx(GxHtml::listDataEx(Truepartialpositives::model()->findAllAttributes(null, true)), false, true)); ?>
		<label><?php echo GxHtml::encode($model->getRelationLabel('truepositives')); ?></label>
		<?php echo $form->checkBoxList($model, 'truepositives', GxHtml::encodeEx(GxHtml::listDataEx(Truepositives::model()->findAllAttributes(null, true)), false, true)); ?>

<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->