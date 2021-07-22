#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QDebug>
#include "ui_mainwindow.h"
#include "AboutDialog.h"
//
#ifdef Q_OS_MAC
    const QString rsrcPath = ":/images/mac";
#else
    const QString rsrcPath = ":/images/win";
#endif

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE
/******************************************************************************
* \class MainWindow
*******************************************************************************/
class MainWindow : public QMainWindow
{
        Q_OBJECT

    public:
        MainWindow(QWidget *parent = nullptr);
        ~MainWindow();

    public slots:
        void onAbout();                       //!< ui->actionAbout
        void onCreate();                      //!< ui->actionCreate
    private:
        Ui::MainWindow *ui = nullptr;         //!< \c ui \brief Pointer to mainwindow.ui
        bool            isDebugMessage=true;  //!< \c isDebugMessage \brief  true of false
};
#endif // MAINWINDOW_H
/*** ************************* End of File ***********************************/
