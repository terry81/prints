<div class="form">


<?php $form = $this->beginWidget('GxActiveForm', array(
	'id' => 'fingerprint-form',
	'enableAjaxValidation' => false,
));
?>

	<p class="note">
		<?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?>.
	</p>

	<?php echo $form->errorSummary($model); ?>

		<div class="row">
		<?php echo $form->labelEx($model,'identifier'); ?>
		<?php echo $form->textField($model, 'identifier', array('maxlength' => 15)); ?>
		<?php echo $form->error($model,'identifier'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'accession'); ?>
		<?php echo $form->textField($model, 'accession', array('maxlength' => 15)); ?>
		<?php echo $form->error($model,'accession'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'no_motifs'); ?>
		<?php echo $form->textField($model, 'no_motifs', array('maxlength' => 100)); ?>
		<?php echo $form->error($model,'no_motifs'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'creation_date'); ?>
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
		<?php echo $form->error($model,'creation_date'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'update_date'); ?>
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
		<?php echo $form->error($model,'update_date'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'title'); ?>
		<?php echo $form->textField($model, 'title', array('maxlength' => 50)); ?>
		<?php echo $form->error($model,'title'); ?>
		</div><!-- row -->
		<div class="row">
		<?php echo $form->labelEx($model,'annotation'); ?>
		<?php echo $form->textArea($model, 'annotation'); ?>
		<?php echo $form->error($model,'annotation'); ?>
		</div><!-- row -->

		<label><?php echo GxHtml::encode($model->getRelationLabel('references')); ?></label>
		<?php echo $form->checkBoxList($model, 'references', GxHtml::encodeEx(GxHtml::listDataEx(Reference::model()->findAllAttributes(null, true)), false, true)); ?>
		<label><?php echo GxHtml::encode($model->getRelationLabel('crossreferences')); ?></label>
		<?php echo $form->checkBoxList($model, 'crossreferences', GxHtml::encodeEx(GxHtml::listDataEx(Crossreference::model()->findAllAttributes(null, true)), false, true)); ?>
		<label><?php echo GxHtml::encode($model->getRelationLabel('motifs')); ?></label>
		<?php echo $form->checkBoxList($model, 'motifs', GxHtml::encodeEx(GxHtml::listDataEx(Motif::model()->findAllAttributes(null, true)), false, true)); ?>

<?php
echo GxHtml::submitButton(Yii::t('app', 'Save'));
$this->endWidget();
?>
</div><!-- form -->