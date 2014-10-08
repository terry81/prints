<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('tpp_id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->tpp_id), array('view', 'id' => $data->tpp_id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('fingerprint_id')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->fingerprint)); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('protein_id')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->protein)); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('numberofelements')); ?>:
	<?php echo GxHtml::encode($data->numberofelements); ?>
	<br />

</div>