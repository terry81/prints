<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('imd_id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->imd_id), array('view', 'id' => $data->imd_id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('motif_id')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->motif)); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('region')); ?>:
	<?php echo GxHtml::encode($data->region); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('min')); ?>:
	<?php echo GxHtml::encode($data->min); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('max')); ?>:
	<?php echo GxHtml::encode($data->max); ?>
	<br />

</div>