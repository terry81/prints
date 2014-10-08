<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('reference_id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->reference_id), array('view', 'id' => $data->reference_id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('fingerprint_id')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->fingerprint)); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('name')); ?>:
	<?php echo GxHtml::encode($data->name); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('accession')); ?>:
	<?php echo GxHtml::encode($data->accession); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('identifier')); ?>:
	<?php echo GxHtml::encode($data->identifier); ?>
	<br />

</div>