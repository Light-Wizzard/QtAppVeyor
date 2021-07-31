/******************************************************************************
* Qt AppVeyor
*******************************************************************************/
#pragma once
#ifndef ABOUTDIALOG_H
#define ABOUTDIALOG_H

#include <QDialog>
#include "ui_AboutDialog.h"
#include "MyOrgSettings.h"

namespace Ui { class AboutDialog; }
/******************************************************************************
* \class  AboutDialog : public QDialog
*******************************************************************************/
class AboutDialog : public QDialog
{
        Q_OBJECT

    public:
        explicit AboutDialog(QWidget *parent = nullptr);
        ~AboutDialog();

    private slots:
        void on_buttonBox_accepted();

        void on_pushButtonAboutAuthor_clicked();

    private:
        Ui::AboutDialog *ui;           //!< \c ui \brief Pointer to AboutDialog.ui
        MyOrgSettings   *myMySettings; //!< \c myMySettings \brief

}; // end class AboutDialog
#endif // ABOUTDIALOG_H
/******************************* End of File *********************************/
