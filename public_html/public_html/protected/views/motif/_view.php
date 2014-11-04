<div class="view">

        <?php echo GxHtml::encode($data->getAttributeLabel('code')); ?>:
        <?php echo GxHtml::link($data->code, array('view', 'id' => $data->motif_id)); ?>

        <br />

        <?php echo GxHtml::encode($data->getAttributeLabel('fingerprint_id')); ?>:
                <?php echo GxHtml::encode(GxHtml::valueEx($data->fingerprint)); ?>
        <br />
        <?php echo GxHtml::encode($data->getAttributeLabel('length')); ?>:
        <?php echo GxHtml::encode($data->length); ?>
        <br />
        <?php echo GxHtml::encode($data->getAttributeLabel('title')); ?>:
        <?php echo GxHtml::encode($data->title); ?>
        <br />

</div>