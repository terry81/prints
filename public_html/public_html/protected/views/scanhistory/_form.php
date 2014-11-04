<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'scanhistory-form',
	'enableAjaxValidation' => false,
));
?>

	<p class="note">
		<?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?>.
	</p>

	<?php echo $form->errorSummary($model); ?>

		<div class="row">
		<?php echo $form->labelEx($model,'database'); ?>
		<?php echo $form->textField($model, 'database', array('maxlength' => 30)); ?>
		<?php echo $form->error($model,'database'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'iterations_number'); ?>
		<?php echo $form->textField($model, 'iterations_number'); ?>
		<?php echo $form->error($model,'iterations_number'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'hitlist_length'); ?>
		<?php echo $form->textField($model, 'hitlist_length'); ?>
		<?php echo $form->error($model,'hitlist_length'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'scanning_method'); ?>
		<?php echo $form->textField($model, 'scanning_method', array('maxlength' => 15)); ?>
		<?php echo $form->error($model,'scanning_method'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'fingerprint_id'); ?>
		<?php echo $form->dropDownList($model, 'fingerprint_id', GxHtml::listDataEx(Fingerprint::model()->findAllAttributes(null, true))); ?>
		<?php echo $form->error($model,'fingerprint_id'); ?>
		</div><!-- row -->


<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->