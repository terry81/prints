<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('seq_id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->seq_id), array('view', 'id' => $data->seq_id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('motif_id')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->motif)); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('sequence')); ?>:
	<?php echo GxHtml::encode($data->sequence); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('pcode')); ?>:
	<?php echo GxHtml::encode($data->pcode); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('start')); ?>:
	<?php echo GxHtml::encode($data->start); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('interval')); ?>:
	<?php echo GxHtml::encode($data->interval); ?>
	<br />

</div>