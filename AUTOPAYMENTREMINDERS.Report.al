// Report 50076 "AUTO PAYMENT REMINDERS"
// {
//     ProcessingOnly = true;
//     UsageCategory = Tasks;

//     dataset
//     {
//         dataitem(Customer; Customer)
//         {
//             DataItemTableView = sorting("No.") where(Balance = filter(<> 0));
//             RequestFilterFields = "No.", "Customer Posting Group";

//             trigger OnAfterGetRecord()
//             begin
//                 SMTPSetup.Get;
//                 //  Customer.GET(CustNo);
//                 TestField("E-Mail");

//                 //SMTPMail.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,HtmlFormatted) //Parameters
//                 SMTPMail.CreateMessage(COMPANYNAME, 'info@itek.in',
//                                        Customer."E-Mail", 'Needed Overdue Payments', '', true);
//                 SMTPMail.AppendBody('Dear Sir / Madam,');
//                 SMTPMail.AppendBody('<br><br>');
//                 SMTPMail.AppendBody('Please find overdue payments list,kindly close ASAP.');
//                 SMTPMail.AppendBody('<br><Br>');
//                 SMTPMail.AppendBody('<table border="1" >');
//                 SMTPMail.AppendBody('<tr>');

//                 SMTPMail.AppendBody('<th>Invoice No.</th>');
//                 SMTPMail.AppendBody('<th>Invoice Date</th>');
//                 SMTPMail.AppendBody('<th>Due Date</th>');
//                 SMTPMail.AppendBody('<th>Invoice Amount</th>');
//                 SMTPMail.AppendBody('<th>Balance Amount</th>');
//                 SMTPMail.AppendBody('</tr>');

//                 TotalAmt := 0;
//                 Totalbalance := 0;

//                 CustLedgEntry.SetCurrentkey("Customer No.", Open, Positive, "Due Date", "Currency Code");
//                 CustLedgEntry.SetRange(CustLedgEntry."Customer No.", "No.");
//                 CustLedgEntry.SetRange(Open, true);
//                 // CustLedgEntry.SETRANGE(CustLedgEntry."Document Type",CustLedgEntry."Document Type"::Invoice);
//                 CustLedgEntry.SetFilter(CustLedgEntry."Due Date", '<=%1', Today);

//                 if CustLedgEntry.FindFirst then
//                     repeat

//                         CustLedgEntry.CalcFields("Amount (LCY)");
//                         CustLedgEntry.CalcFields("Remaining Amt. (LCY)");
//                         Totalbalance += CustLedgEntry."Remaining Amt. (LCY)";
//                         TotalAmt += CustLedgEntry."Amount (LCY)";

//                         SMTPMail.AppendBody('<tr style="background-color:DarkSalmon" >');// bgcolor="#5D7B9D" >');
//                         SMTPMail.AppendBody('<td>' + Format(CustLedgEntry."Document No.") + '</td>');
//                         SMTPMail.AppendBody('<td>' + Format(CustLedgEntry."Posting Date") + '</td>');
//                         SMTPMail.AppendBody('<td>' + Format(CustLedgEntry."Due Date") + '</td>');
//                         SMTPMail.AppendBody('<td>' + Format(CustLedgEntry."Amount (LCY)") + '</td>');
//                         SMTPMail.AppendBody('<td>' + Format(CustLedgEntry."Remaining Amt. (LCY)") + '</td>');
//                         SMTPMail.AppendBody('</tr>');

//                     until (CustLedgEntry.Next = 0);
//                 //For Total
//                 SMTPMail.AppendBody('<td>' + Format('TOTAL') + '</td>');
//                 SMTPMail.AppendBody('<td>' + Format('') + '</td>');
//                 SMTPMail.AppendBody('<td>' + Format('') + '</td>');
//                 SMTPMail.AppendBody('<td>' + Format('') + '</td>');
//                 SMTPMail.AppendBody('<td>' + Format(Totalbalance) + '</td>');
//                 //For Total

//                 SMTPMail.AppendBody('</table>');
//                 SMTPMail.AppendBody('<br><br>');
//                 SMTPMail.AppendBody('Regards,');
//                 SMTPMail.AppendBody('<br>');
//                 SMTPMail.AppendBody('Accounts Department');
//                 SMTPMail.AppendBody('<br><br>');
//                 SMTPMail.AppendBody(COMPANYNAME);
//                 SMTPMail.AppendBody('<br><br>');
//                 SMTPMail.AppendBody('This is a system generated mail from MICROSOFT DYNAMICS NAVISION. Please do not reply to this email ID.');
//                 SMTPMail.AppendBody('<br><br>');
//                 SMTPMail.Send;
//                 //MESSAGE('message send');
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         SMTPSetup: Record "SMTP Mail Setup";
//         SMTPMail: Codeunit "SMTP Mail";
//         CustLedgEntry: Record "Cust. Ledger Entry";
//         Totalbalance: Decimal;
//         TotalAmt: Decimal;


//     procedure SendMailTocustomer()
//     begin
//     end;
// }

