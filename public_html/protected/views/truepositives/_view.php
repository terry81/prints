<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('tp_id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->tp_id), array('view', 'id' => $data->tp_id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('fingerprint_id')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->fingerprint)); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('protein_id')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->protein)); ?>
	<br />

</div>