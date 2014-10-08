<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'seq-form',
	'enableAjaxValidation' => false,
));
?>

	<p class="note">
		<?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?>.
	</p>

	<?php echo $form->errorSummary($model); ?>

		<div class="row">
		<?php echo $form->labelEx($model,'motif_id'); ?>
		<?php echo $form->dropDownList($model, 'motif_id', GxHtml::listDataEx(Motif::model()->findAllAttributes(null, true))); ?>
		<?php echo $form->error($model,'motif_id'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'sequence'); ?>
		<?php echo $form->textField($model, 'sequence', array('maxlength' => 30)); ?>
		<?php echo $form->error($model,'sequence'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'pcode'); ?>
		<?php echo $form->textField($model, 'pcode', array('maxlength' => 10)); ?>
		<?php echo $form->error($model,'pcode'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'start'); ?>
		<?php echo $form->textField($model, 'start'); ?>
		<?php echo $form->error($model,'start'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'interval'); ?>
		<?php echo $form->textField($model, 'interval'); ?>
		<?php echo $form->error($model,'interval'); ?>
		</div><!-- row -->


<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->