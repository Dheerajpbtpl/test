// /// <summary>
// /// Report Mail From Navision (ID 50054).
// /// </summary>
// Report 50054 "Mail From Navision"
// {
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem(Contact; Contact)
//         {
//             DataItemTableView = where("E-Mail" = filter(<> ''));
//             RequestFilterFields = "No.", "Contact Group";

//             trigger OnAfterGetRecord()
//             begin
//                 if not ToContacts then
//                     CurrReport.Skip;

//                 ContactMailLedgerEntry.Reset;
//                 ContactMailLedgerEntry.SetRange("Contact No.", Contact."No.");
//                 //ContactMailLedgerEntry.SETRANGE(Subject,Subject);
//                 ContactMailLedgerEntry.SetRange("Sent By", UserId);
//                 ContactMailLedgerEntry.SetRange(Date, (Today - 6), Today);
//                 if ContactMailLedgerEntry.FindFirst then
//                     CurrReport.Skip;
//                 /*
//                 WHILE STRPOS(BodyText,'/') > 0 DO
//                   BodyText := DELSTR(BodyText,STRPOS(BodyText,'/')) +'<Br>' + COPYSTR(BodyText,STRPOS(BodyText,'/') + STRLEN('/'));

//                 WHILE STRPOS(BodyText1,'/') > 0 DO
//                   BodyText1 := DELSTR(BodyText1,STRPOS(BodyText1,'/')) +'<Br>' + COPYSTR(BodyText1,STRPOS(BodyText1,'/') + STRLEN('/'));
//                 */
//                 BodyText := ReplaceString(BodyText);
//                 BodyText1 := ReplaceString(BodyText1);
//                 if Signature = Signature::Amandeep then
//                     SMTPMail.CreateMessage('Amandeep', SMTPMailSetup."User ID", Contact."E-Mail", Subject, '', true)
//                 else
//                     if Signature = Signature::Anjali then
//                         SMTPMail.CreateMessage('Anjali', SMTPMailSetup."User ID", Contact."E-Mail", Subject, '', true);

//                 if Contact.Name <> '' then
//                     SMTPMail.AppendBody('<p style = "font-size:18px"> Dear ' + Contact.Name + ',')
//                 else
//                     SMTPMail.AppendBody('<p style = "font-size:18px"> Dear Sir/Madam,');

//                 SMTPMail.AppendBody('<Br><Br> <p style = "font-size:16px">' + BodyText + '<br>');
//                 SMTPMail.AppendBody('<p style = "font-size:16px">' + BodyText1 + '<br><br><br><br>');
//                 if Signature = Signature::Amandeep then
//                     SMTPMail.AppendBody('<IMG SRC="https://static.wixstatic.com/media/bbb5fc_61ae8cee1887453cb1076ecaaa5ae780~mv2.png/v1/fill/w_481,h_378,al_c/bbb5fc_61ae8cee1887453cb1076ecaaa5ae780~mv2.png">')
//                 else
//                     if Signature = Signature::Anjali then
//                         SMTPMail.AppendBody('<IMG SRC="https://static.wixstatic.com/media/bbb5fc_e7bd28025e484f4e9a05412503d0d549~mv2.png/v1/fill/w_600,h_446,al_c,usm_0.66_1.00_0.01/bbb5fc_e7bd28025e484f4e9a05412503d0d549~mv2.png">');
//                 SMTPMail.Send;

//                 EntryNo += 1;
//                 ContactMailLedgerEntry.Init;
//                 ContactMailLedgerEntry."Entry No." := EntryNo;
//                 ContactMailLedgerEntry."Contact No." := Contact."No.";
//                 ContactMailLedgerEntry."Contact Name" := Contact.Name;
//                 ContactMailLedgerEntry."E-mail" := Contact."E-Mail";
//                 ContactMailLedgerEntry.Subject := Subject;
//                 ContactMailLedgerEntry."Sent By" := UserId;
//                 ContactMailLedgerEntry.Date := Today;
//                 ContactMailLedgerEntry.Insert;

//             end;

//             trigger OnPostDataItem()
//             begin
//                 //ReplaceString(String : Text[250];FindWhat : Text[250];ReplaceWith : Text[250]) NewString : Text[250]
//                 SMTPMailSetup."User ID" := OldEmailid;
//                 SMTPMailSetup.Password := OldPwd;
//                 SMTPMailSetup.Modify;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 if UserId = 'PBTPLSRV\ANJALIRATHORE' then
//                     Contact.SetFilter("Salesperson Code", 'Anjali');
//                 if UserId = 'PBTPLSRV\AMANDEEP' then
//                     Contact.SetFilter("Salesperson Code", 'Amandeep');

//                 if TestMailtoID then
//                     Contact.SetRange("No.", '');

//                 if Signature = Signature::" " then
//                     Error('Please Select Signature.');
//                 SMTPMailSetup.Get;

//                 OldEmailid := SMTPMailSetup."User ID";
//                 OldPwd := SMTPMailSetup.Password;


//                 if TestMailtoID then begin
//                     if Ids = '' then
//                         Error('Ids Must Have a Value.');
//                     if Subject = '' then
//                         Error('Subject Must have a Value.');

//                     BodyText := ReplaceString(BodyText);
//                     BodyText1 := ReplaceString(BodyText1);
//                     /*
//                     WHILE STRPOS(BodyText,'.') > 0 DO
//                       BodyText := DELSTR(BodyText,STRPOS(BodyText,'.')) + '<br>' + COPYSTR(BodyText,STRPOS(BodyText,'.') + STRLEN('.'));
//                     WHILE STRPOS(BodyText1,'.') > 0 DO
//                       BodyText1 := DELSTR(BodyText1,STRPOS(BodyText1,'.')) +'<br>' + COPYSTR(BodyText1,STRPOS(BodyText1,'.') + STRLEN('.'));
//                     */

//                     if Signature = Signature::Amandeep then
//                         SMTPMail.CreateMessage('Amandeep', SMTPMailSetup."User ID", Ids, Subject, '', true)
//                     else
//                         if Signature = Signature::Anjali then
//                             SMTPMail.CreateMessage('Anjali', SMTPMailSetup."User ID", Ids, Subject, '', true);

//                     SMTPMail.AppendBody('<p style = "font-size:18px"> Dear Sir/Madam,');
//                     SMTPMail.AppendBody('<Br><Br> <p style = "font-size:16px">' + BodyText + '<br>');
//                     SMTPMail.AppendBody('<p style = "font-size:16px">' + BodyText1 + '<br><br><br><br>');
//                     if Signature = Signature::Amandeep then
//                         SMTPMail.AppendBody('<IMG SRC="https://static.wixstatic.com/media/bbb5fc_61ae8cee1887453cb1076ecaaa5ae780~mv2.png/v1/fill/w_481,h_378,al_c/bbb5fc_61ae8cee1887453cb1076ecaaa5ae780~mv2.png">')
//                     else
//                         if Signature = Signature::Anjali then
//                             SMTPMail.AppendBody('<IMG SRC="https://static.wixstatic.com/media/bbb5fc_e7bd28025e484f4e9a05412503d0d549~mv2.png/v1/fill/w_600,h_446,al_c,usm_0.66_1.00_0.01/bbb5fc_e7bd28025e484f4e9a05412503d0d549~mv2.png">');
//                     SMTPMail.Send;

//                 end else begin
//                     if Ids <> '' then
//                         Error('Ids Must be Blank.');
//                     if Name <> '' then
//                         Error('Name Must be Blank.');
//                 end;
//                 Contact.SetFilter("E-Mail", '<>%1', '');
//                 if ContactMailLedgerEntry.FindLast then
//                     EntryNo := ContactMailLedgerEntry."Entry No."
//                 else
//                     EntryNo := 0;

//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//             area(content)
//             {
//                 field("Test Mail to ID"; TestMailtoID)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(IDs; Ids)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("To Contacts"; ToContacts)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Subject; Subject)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Body; BodyText)
//                 {
//                     ApplicationArea = Basic;
//                     MultiLine = true;
//                 }
//                 field("Additional Body"; BodyText1)
//                 {
//                     ApplicationArea = Basic;
//                     MultiLine = true;
//                 }
//                 field(Signature; Signature)
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
//         // SMTPMailSetup.Get;
//         // if UserId = 'PBTPLSRV\ANJALIRATHORE' then begin
//         //     SMTPMailSetup."User ID" := SMTPMailSetup."User 2 ID";
//         //     SMTPMailSetup.Password := SMTPMailSetup."User 2 Password";
//         //     SMTPMailSetup.Modify;
//         // end;

//         // if UserId = 'PBTPLSRV\AMANDEEP' then begin
//         //     SMTPMailSetup."User ID" := SMTPMailSetup."User 1 ID";
//         //     SMTPMailSetup.Password := SMTPMailSetup."User 1 Password";
//         //     SMTPMailSetup.Modify;
//         // end;
//     end;

//     var
//         SMTPMailSetup: Record "SMTP Mail Setup";
//         SMTPMail: Codeunit "SMTP Mail";
//         CompanyInformation: Record "Company Information";
//         FileName: Text;
//         FileManagment: Codeunit "File Management";
//         TestMailtoID: Boolean;
//         Ids: Text;
//         ToContacts: Boolean;
//         NameTxt: Text;
//         BodyText: Text;
//         BodyText1: Text;
//         Subject: Text;
//         Signature: Option " ",Amandeep,Anjali;
//         ContactMailLedgerEntry: Record "Contact Mail Ledger Entry";
//         EntryNo: Integer;
//         OldEmailid: Text;
//         OldPwd: Text;
//         ReplaceIWith: Text;
//         Text2: Text;
//         Text1: Text;
//         Text3: Text;

//     local procedure ReplaceString(Text1: Text) ReturnString: Text
//     begin
//         Text2 := '';
//         repeat
//             Text3 := '';
//             Text3 := CopyStr(Text1, 1, StrPos(Text1, '.'));
//             if StrLen(Text3) = 1 then
//                 Text2 += ''
//             else
//                 Text2 += CopyStr(Text1, 1, StrPos(Text1, '.'));
//             Text2 += '<br>';
//             Text1 := DelStr(Text1, 1, StrPos(Text1, '.'));
//         until StrPos(Text1, '.') = 0;
//         exit(Text2);
//     end;
// }

