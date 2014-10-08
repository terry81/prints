<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'motif-form',
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
		<?php echo $form->labelEx($model,'title'); ?>
		<?php echo $form->textField($model, 'title', array('maxlength' => 100)); ?>
		<?php echo $form->error($model,'title'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'code'); ?>
		<?php echo $form->textField($model, 'code', array('maxlength' => 15)); ?>
		<?php echo $form->error($model,'code'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'length'); ?>
		<?php echo $form->textField($model, 'length'); ?>
		<?php echo $form->error($model,'length'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'position'); ?>
		<?php echo $form->textField($model, 'position', array('maxlength' => 7)); ?>
		<?php echo $form->error($model,'position'); ?>
		</div><!-- row -->

		<label><?php echo GxHtml::encode($model->getRelationLabel('intermotifdistances')); ?></label>
		<?php echo $form->checkBoxList($model, 'intermotifdistances', GxHtml::encodeEx(GxHtml::listDataEx(Intermotifdistance::model()->findAllAttributes(null, true)), false, true)); ?>
		<label><?php echo GxHtml::encode($model->getRelationLabel('seqs')); ?></label>
		<?php echo $form->checkBoxList($model, 'seqs', GxHtml::encodeEx(GxHtml::listDataEx(Seq::model()->findAllAttributes(null, true)), false, true)); ?>

<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->