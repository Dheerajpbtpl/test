
// Report 50125 "Auto mail"
// {
//     ProcessingOnly = true;
//     UsageCategory = Lists;

//     dataset
//     {
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 field(Ledger; VarLedger)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Daily Sale Report"; DailySale)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(DailyPur; DailyPur)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnPreReport()
//     begin
//         if VarLedger = true then begin
//             LedgerReportEmail;
//         end else
//             if DailySale = true then begin
//                 DailySalesReportEmail;
//             end else
//                 if
//          DailyPur = true then begin
//                     DailyPurchaseReportEmail;
//                 end;

//         LedgerReportEmail;
//         DailySalesReportEmail;
//         DailyPurchaseReportEmail;
//     end;

//     var
//         VarInputMailType: Option " ",Ledger," Daily Sale Report";
//         VarLedger: Boolean;
//         DailySale: Boolean;
//         DailyPur: Boolean;

//     local procedure LedgerReportEmail()
//     var
//         // SMTPMailSetup: Record "SMTP Mail Setup";
//         Hour: Text;
//         Minutes: Text;
//         FileName: Text[250];
//         Body: Text[1024];
//         SMTPMail: Codeunit "SMTP Mail";
//         GLAcct: Record "G/L Account";
//         EmailBody: Text;
//         CmpInfo: Record "Company Information";
//         EmailSubject: Text;
//         PartyEmail: Text;
//     begin
//         Hour := DelChr(Format(Time), '=', ':');
//         Minutes := DelChr(Hour, '=', ' ');
//         FileName := 'E:\Perfoma Invoice PBTPL' + 'LedgerReport-' + Hour + Minutes + '.Pdf';
//         GLAcct.Reset;
//         //GLAcct.SETRANGE("No.",'');
//         GLAcct.SetFilter("Date Filter", '%1..%2', Dmy2date(1, 4, 2018), Today);
//         Report.SaveAsPdf(Report::Ledger, FileName, GLAcct);
//         Sleep(1000);
//         if Exists(FileName) then begin
//             EmailBody := 'Dear Sir/Mam ,';
//             EmailBody := '/n' + '  Please Find Attached Report';

//             // SMTPMailSetup.Get;
//             // SMTPMailSetup.TestField("User ID");
//             CmpInfo.Get;

//             EmailSubject := 'Ledger Report';
//             PartyEmail := 'sales@punjabbulls.com';


//             SMTPMail.CreateMessage(CmpInfo.Name, SMTPMailSetup."User ID", PartyEmail, EmailSubject, EmailBody, false);
//             SMTPMail.AddCC('bharat@punjabbulls.com');
//             SMTPMail.AddBCC('dheeraj@punjabbulls.com');
//             SMTPMail.AddAttachment(FileName, 'LedgerReport');

//             SMTPMail.Send;
//         end;
//         Message('mail Send');
//     end;

//     local procedure DailySalesReportEmail()
//     var
//         SMTPMailSetup: Record "SMTP Mail Setup";
//         Hour: Text;
//         Minutes: Text;
//         FileName: Text[250];
//         Body: Text[1024];
//         SMTPMail: Codeunit "SMTP Mail";
//         Cust: Record "Cust. Ledger Entry";
//         EmailBody: Text;
//         CmpInfo: Record "Company Information";
//         EmailSubject: Text;
//         PartyEmail: Text;
//         ArCustomerOverDue: Report Canblization;
//     begin
//         Hour := DelChr(Format(Time), '=', ':');
//         Minutes := DelChr(Hour, '=', ' ');
//         FileName := 'E:\Perfoma Invoice PBTPL' + 'DailySalesReport-' + Hour + Minutes + '.Pdf';
//         Cust.Reset;
//         Cust.SetRange("Customer No.");
//         Cust.SetRange("Posting Date", Today);
//         //REPORT.SAVEASPDF(50090,FileName,Cust);
//         ArCustomerOverDue.SaveAsPdf(FileName);
//         Sleep(1000);
//         if Exists(FileName) then begin
//             EmailBody := 'Dear Sir/Mam';
//             EmailBody := EmailBody + '</b>'
//                           + ' Please Attached File';
//             //MailSubject:='Payment Due date Notification';

//             SMTPMailSetup.Get;
//             SMTPMailSetup.TestField("User ID");
//             CmpInfo.Get;

//             EmailSubject := 'Daily Sales Report';
//             PartyEmail := 'sales@punjabbulls.com';

//             SMTPMail.CreateMessage(CmpInfo.Name, SMTPMailSetup."User ID", PartyEmail, EmailSubject, EmailBody, false);
//             SMTPMail.AddCC('bharat@punjabbulls.com');
//             SMTPMail.AddBCC('dheeraj@punjabbulls.com');
//             SMTPMail.AddAttachment(FileName, 'DailySalesReport');
//             SMTPMail.Send;
//         end;
//         Message('mail Send');
//     end;

//     local procedure DailyPurchaseReportEmail()
//     var
//         SMTPMailSetup: Record "SMTP Mail Setup";
//         Hour: Text;
//         Minutes: Text;
//         FileName: Text[250];
//         Body: Text[1024];
//         SMTPMail: Codeunit "SMTP Mail";
//         Cust: Record "Sales Invoice Header";
//         EmailBody: Text;
//         CmpInfo: Record "Company Information";
//         EmailSubject: Text;
//         PartyEmail: Text;
//     begin
//         Hour := DelChr(Format(Time), '=', ':');
//         Minutes := DelChr(Hour, '=', ' ');
//         FileName := 'E:\Perfoma Invoice PBTPL\' + 'DailypurReport-' + Hour + Minutes + '.Pdf';

//         Cust.Reset;
//         Cust.SetRange("No.", '');
//         Cust.SetRange("Posting Date");
//         Report.SaveAsPdf(50074, FileName, Cust);
//         Sleep(1000);

//         if Exists(FileName) then begin
//             EmailBody := 'Hello ,';
//             EmailBody := EmailBody + '<br/>' + 'please Attached File';

//             SMTPMailSetup.Get;
//             SMTPMailSetup.TestField("User ID");
//             CmpInfo.Get;

//             EmailSubject := 'Daily purchase Report';
//             PartyEmail := 'sales@punjabbulls.com';

//             SMTPMail.CreateMessage(CmpInfo.Name, SMTPMailSetup."User ID", PartyEmail, EmailSubject, EmailBody, false);
//             SMTPMail.AddCC('bharat@punjabbulls.com');
//             SMTPMail.AddBCC('dheeraj@punjabbulls.com');
//             SMTPMail.AddAttachment(FileName, 'DailyPurchaseReport');
//             SMTPMail.Send;
//         end;
//         Message('mail Send');
//     end;

//     local procedure Posting()
//     begin
//     end;
// }

