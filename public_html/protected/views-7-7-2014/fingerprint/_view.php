<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('identifier')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->identifier), array('view', 'id' => $data->id)); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('accession')); ?>:
	<?php echo GxHtml::encode($data->accession); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('no_motifs')); ?>:
	<?php echo GxHtml::encode($data->no_motifs); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('creation_date')); ?>:
	<?php echo GxHtml::encode($data->creation_date); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('update_date')); ?>:
	<?php echo GxHtml::encode($data->update_date); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('title')); ?>:
	<?php echo GxHtml::encode($data->title); ?>
	<br />
	<?php /*
	<?php echo GxHtml::encode($data->getAttributeLabel('annotation')); ?>:
	<?php echo GxHtml::encode($data->annotation); ?>
	<br />
	*/ ?>

</div>
