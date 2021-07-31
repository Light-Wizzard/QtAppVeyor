/******************************************************************************
 * Qt AppVeyor
*******************************************************************************/
#include "AboutDialog.h"
/******************************************************************************
* \class AboutDialog Constructor
*******************************************************************************/
/*!
   \class AboutDialog
   \fn AboutDialog::AboutDialog(QWidget *parent) : QDialog(parent), ui(new Ui::AboutDialog)
   \brief Show About Dialog Box.
 */
AboutDialog::AboutDialog(QWidget *parent) : QDialog(parent), ui(new Ui::AboutDialog)
{
    myMySettings = new MyOrgSettings(parent);
    QString thisHelp = myMySettings->readFile(":help/About-en.html");
    ui->setupUi(this);
    ui->textEditAbout->setHtml(thisHelp);
} // end AboutDialog
/******************************************************************************
* \fn AboutDialog Destructor
*******************************************************************************/
AboutDialog::~AboutDialog()
{
    delete ui;
} // end ~AboutDialog
/******************************************************************************
* \fn on_buttonBox_accepted
*******************************************************************************/
void AboutDialog::on_buttonBox_accepted()
{
    AboutDialog::close();
}
/******************************************************************************
* \fn on_pushButtonAboutAuthor_clicked
*******************************************************************************/
void AboutDialog::on_pushButtonAboutAuthor_clicked()
{
    QString thisHelp = myMySettings->readFile(":help/About-Author-en.html");
    ui->textEditAbout->setHtml(thisHelp);
}
/******************************* End of File *********************************/

