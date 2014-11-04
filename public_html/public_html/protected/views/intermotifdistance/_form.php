<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'intermotifdistance-form',
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
		<?php echo $form->labelEx($model,'region'); ?>
		<?php echo $form->textField($model, 'region', array('maxlength' => 10)); ?>
		<?php echo $form->error($model,'region'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'min'); ?>
		<?php echo $form->textField($model, 'min'); ?>
		<?php echo $form->error($model,'min'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'max'); ?>
		<?php echo $form->textField($model, 'max', array('maxlength' => 10)); ?>
		<?php echo $form->error($model,'max'); ?>
		</div><!-- row -->


<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->