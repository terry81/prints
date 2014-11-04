<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('literature_id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->literature_id), array('view', 'id' => $data->literature_id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('fingerprint_id')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->fingerprint)); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('author')); ?>:
	<?php echo GxHtml::encode($data->author); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('title')); ?>:
	<?php echo GxHtml::encode($data->title); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('journal')); ?>:
	<?php echo GxHtml::encode($data->journal); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('year')); ?>:
	<?php echo GxHtml::encode($data->year); ?>
	<br />

</div>