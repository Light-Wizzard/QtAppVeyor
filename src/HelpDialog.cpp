#include "HelpDialog.h"
#include "ui_HelpDialog.h"
/******************************************************************************
* \class HelpDialog Constructor
*******************************************************************************/
/*!
   \class HelpDialog
   \fn HelpDialog::HelpDialog(QWidget *parent) : QDialog(parent), ui(new Ui::AboutDialog)
   \brief Show Help Dialog Box.
 */
HelpDialog::HelpDialog(QWidget *parent) : QDialog(parent), ui(new Ui::HelpDialog)
{
    myMySettings = new MyOrgSettings(parent);
    QString thisHelp = myMySettings->readFile(":help/Help-en.html");
    ui->setupUi(this);
    ui->textEditHelp->setHtml(thisHelp);
}
/******************************************************************************
* /fn HelpDialog Destructor
*******************************************************************************/
HelpDialog::~HelpDialog()
{
    delete ui;
}
/******************************************************************************
* /fn on_pushButtonClose_clicked
*******************************************************************************/
void HelpDialog::on_pushButtonClose_clicked()
{
    close();
}
/******************************************************************************
* /fn on_pushButtonHelpAuthor_clicked
*******************************************************************************/
void HelpDialog::on_pushButtonHelpAuthor_clicked()
{
    QString thisHelp = myMySettings->readFile(":help/About-Author-en.html");
    ui->textEditHelp->setHtml(thisHelp);
}
/******************************* End of File *********************************/


