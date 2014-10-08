<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('protein_id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->protein_id), array('view', 'id' => $data->protein_id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('fingerprint_id')); ?>:
	<?php echo GxHtml::encode($data->fingerprint_id); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('identifier')); ?>:
	<?php echo GxHtml::encode($data->identifier); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('title')); ?>:
	<?php echo GxHtml::encode($data->title); ?>
	<br />

</div>