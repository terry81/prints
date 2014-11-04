<?php

class TruepartialpositivesController extends GxController {

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
			'model' => $this->loadModel($id, 'Truepartialpositives'),
		));
	}

	public function actionCreate() {
		$model = new Truepartialpositives;


		if (isset($_POST['Truepartialpositives'])) {
			$model->setAttributes($_POST['Truepartialpositives']);

			if ($model->save()) {
				if (Yii::app()->getRequest()->getIsAjaxRequest())
					Yii::app()->end();
				else
					$this->redirect(array('view', 'id' => $model->tpp_id));
			}
		}

		$this->render('create', array( 'model' => $model));
	}

	public function actionUpdate($id) {
		$model = $this->loadModel($id, 'Truepartialpositives');


		if (isset($_POST['Truepartialpositives'])) {
			$model->setAttributes($_POST['Truepartialpositives']);

			if ($model->save()) {
				$this->redirect(array('view', 'id' => $model->tpp_id));
			}
		}

		$this->render('update', array(
				'model' => $model,
				));
	}

	public function actionDelete($id) {
		if (Yii::app()->getRequest()->getIsPostRequest()) {
			$this->loadModel($id, 'Truepartialpositives')->delete();

			if (!Yii::app()->getRequest()->getIsAjaxRequest())
				$this->redirect(array('admin'));
		} else
			throw new CHttpException(400, Yii::t('app', 'Your request is invalid.'));
	}

	public function actionIndex() {
		$dataProvider = new CActiveDataProvider('Truepartialpositives');
		$this->render('index', array(
			'dataProvider' => $dataProvider,
		));
	}

	public function actionAdmin() {
		$model = new Truepartialpositives('search');
		$model->unsetAttributes();

		if (isset($_GET['Truepartialpositives']))
			$model->setAttributes($_GET['Truepartialpositives']);

		$this->render('admin', array(
			'model' => $model,
		));
	}

}