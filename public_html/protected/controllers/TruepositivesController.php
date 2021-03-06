<?php

class TruepositivesController extends GxController {

	public function filters() {
        return array(
            'accessControl', // perform access control for CRUD operations
        );
    }
    
    public function accessRules() {
        return array(
            array('allow', // allow all users to perform 'index' and 'view' actions
                'actions' => array('index','view'),
                'users' => array('*'),
            ),
            array('allow', // allow authenticated user to perform 'create' action
                'actions' => array('create','update','delete','admin'),
                'users' => array('@'),
            ),
            array('deny', // deny all users
                'users' => array('*'),
            ),
        );
    }

	public function actionView($id) {
		$this->render('view', array(
			'model' => $this->loadModel($id, 'Truepositives'),
		));
	}

	public function actionCreate() {
		$model = new Truepositives;


		if (isset($_POST['Truepositives'])) {
			$model->setAttributes($_POST['Truepositives']);

			if ($model->save()) {
				if (Yii::app()->getRequest()->getIsAjaxRequest())
					Yii::app()->end();
				else
					$this->redirect(array('view', 'id' => $model->tp_id));
			}
		}

		$this->render('create', array( 'model' => $model));
	}

	public function actionUpdate($id) {
		$model = $this->loadModel($id, 'Truepositives');


		if (isset($_POST['Truepositives'])) {
			$model->setAttributes($_POST['Truepositives']);

			if ($model->save()) {
				$this->redirect(array('view', 'id' => $model->tp_id));
			}
		}

		$this->render('update', array(
				'model' => $model,
				));
	}

	public function actionDelete($id) {
		if (Yii::app()->getRequest()->getIsPostRequest()) {
			$this->loadModel($id, 'Truepositives')->delete();

			if (!Yii::app()->getRequest()->getIsAjaxRequest())
				$this->redirect(array('admin'));
		} else
			throw new CHttpException(400, Yii::t('app', 'Your request is invalid.'));
	}

	public function actionIndex() {
		$dataProvider = new CActiveDataProvider('Truepositives');
		$this->render('index', array(
			'dataProvider' => $dataProvider,
		));
	}

	public function actionAdmin() {
		$model = new Truepositives('search');
		$model->unsetAttributes();

		if (isset($_GET['Truepositives']))
			$model->setAttributes($_GET['Truepositives']);

		$this->render('admin', array(
			'model' => $model,
		));
	}

}