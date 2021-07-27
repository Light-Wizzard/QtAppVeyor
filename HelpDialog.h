#ifndef HELPDIALOG_H
#define HELPDIALOG_H

#include <QDialog>
#include "MyOrgSettings.h"

namespace Ui { class HelpDialog; }
/******************************************************************************
* \class  HelpDialog
*******************************************************************************/
class HelpDialog : public QDialog
{
        Q_OBJECT

    public:
        explicit HelpDialog(QWidget *parent = nullptr);
        ~HelpDialog();

    private slots:
        void on_pushButtonClose_clicked();

    private:
        Ui::HelpDialog *ui;            //!< \c ui \brief ui
        MyOrgSettings   *myMySettings; //!< \c myMySettings \brief Used for Path
};

#endif // HELPDIALOG_H
/******************************* End of File *********************************/
