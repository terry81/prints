<?php

class ProteinController extends GxController {

	public function filters() {
        return array(
            'accessControl', // perform access control for CRUD operations
        );
    }
    
    public function accessRules() {
        return array(
            array('allow', // allow all users to perform 'index' and 'view' actions
                'actions' => array('index','view', 'search'),
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
			'model' => $this->loadModel($id, 'Protein'),
		));
	}

	public function actionCreate() {
		$model = new Protein;


		if (isset($_POST['Protein'])) {
			$model->setAttributes($_POST['Protein']);

			if ($model->save()) {
				if (Yii::app()->getRequest()->getIsAjaxRequest())
					Yii::app()->end();
				else
					$this->redirect(array('view', 'id' => $model->id));
			}
		}

		$this->render('create', array( 'model' => $model));
	}

	public function actionUpdate($id) {
		$model = $this->loadModel($id, 'Protein');


		if (isset($_POST['Protein'])) {
			$model->setAttributes($_POST['Protein']);

			if ($model->save()) {
				$this->redirect(array('view', 'id' => $model->id));
			}
		}

		$this->render('update', array(
				'model' => $model,
				));
	}

	public function actionDelete($id) {
		if (Yii::app()->getRequest()->getIsPostRequest()) {
			$this->loadModel($id, 'Protein')->delete();

			if (!Yii::app()->getRequest()->getIsAjaxRequest())
				$this->redirect(array('admin'));
		} else
			throw new CHttpException(400, Yii::t('app', 'Your request is invalid.'));
	}

	public function actionIndex() {
		$dataProvider = new CActiveDataProvider('Protein');
		$this->render('index', array(
			'dataProvider' => $dataProvider,
		));
	}
	
	public function actionSearch() {
                $model = new Protein('search');
                $model->unsetAttributes();

                $this->render('search', array(
                        'model' => $model,
                ));
        }

	public function actionAdmin() {
		$model = new Protein('search');
		$model->unsetAttributes();

		if (isset($_GET['Protein']))
			$model->setAttributes($_GET['Protein']);

		$this->render('admin', array(
			'model' => $model,
		));
	}

}
