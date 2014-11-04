<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('sh_id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->sh_id), array('view', 'id' => $data->sh_id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('database')); ?>:
	<?php echo GxHtml::encode($data->database); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('iterations_number')); ?>:
	<?php echo GxHtml::encode($data->iterations_number); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('hitlist_length')); ?>:
	<?php echo GxHtml::encode($data->hitlist_length); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('scanning_method')); ?>:
	<?php echo GxHtml::encode($data->scanning_method); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('fingerprint_id')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->fingerprint)); ?>
	<br />

</div>