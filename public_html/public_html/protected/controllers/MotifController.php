<?php

class MotifController extends GxController {


	public function filters() {
        return array(
            'accessControl', // perform access control for CRUD operations
        );
    }
    
    public function accessRules() {
        return array(
            array('allow', // allow all users to perform 'index' and 'view' actions
                'actions' => array('index','view','search'),
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
			'model' => $this->loadModel($id, 'Motif'),
		));
	}

	public function actionCreate() {
		$model = new Motif;


		if (isset($_POST['Motif'])) {
			$model->setAttributes($_POST['Motif']);

			if ($model->save()) {
				if (Yii::app()->getRequest()->getIsAjaxRequest())
					Yii::app()->end();
				else
					$this->redirect(array('view', 'id' => $model->motif_id));
			}
		}

		$this->render('create', array( 'model' => $model));
	}

	public function actionUpdate($id) {
		$model = $this->loadModel($id, 'Motif');


		if (isset($_POST['Motif'])) {
			$model->setAttributes($_POST['Motif']);

			if ($model->save()) {
				$this->redirect(array('view', 'id' => $model->motif_id));
			}
		}

		$this->render('update', array(
				'model' => $model,
				));
	}

	public function actionDelete($id) {
		if (Yii::app()->getRequest()->getIsPostRequest()) {
			$this->loadModel($id, 'Motif')->delete();

			if (!Yii::app()->getRequest()->getIsAjaxRequest())
				$this->redirect(array('admin'));
		} else
			throw new CHttpException(400, Yii::t('app', 'Your request is invalid.'));
	}

	public function actionIndex() {
		$dataProvider = new CActiveDataProvider('Motif');
		$this->render('index', array(
			'dataProvider' => $dataProvider,
		));
	}

	public function actionAdmin() {
		$model = new Motif('search');
		$model->unsetAttributes();

		if (isset($_GET['Motif']))
			$model->setAttributes($_GET['Motif']);

		$this->render('admin', array(
			'model' => $model,
		));
	}
    
    public function actionSearch() {
		$model = new Motif('search');
		$model->unsetAttributes();

		if (isset($_GET['Motif']))
			$model->setAttributes($_GET['Motif']);

		$this->render('search', array(
			'model' => $model,
		));
	}

}